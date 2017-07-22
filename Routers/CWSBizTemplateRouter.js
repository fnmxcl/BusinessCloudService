"use strict";
/**
 * Created by fnmxcl on 2015/11/28.
 */
var async = require('async');
var express = require('express');
var router = express.Router();
var Request = require('request');
var Config = require('../Config/Config');
var querystring = require('querystring');
var Runlog = require('../Service/BusinessLog.js');
var CloudBusinessShared = require('./../Shared/CloudBusinessShared.js');
var mPackageSystem = require('./../Shared/BinaryPackage.js');
var BizTemplateExcutor = require('./../Shared/BizTemplateCommunication.js');
var uuid = require('node-uuid');
//var mExecutorControlService = require('../Service/ExecutorControlService.js');
var DataService = require("SBE.AppFrame/Application/Server/Service/DataService.js");
var util = require("../Shared/util.js");

router.get('/ExecuteBizTemplate', function(req, res) {
    Runlog.WriteLog("CWSBizTemplateRouter", "调用了ExecuteBizTemplate");
    console.time('BizTemplateRouter');
    var json = {};
    var client =  req.query["client"];
    if(client == undefined || client == null) {
        client =  req.query["Client"];
    }

    var ReturnInfo = {};
    var CurrentClentInstance = CloudBusinessShared.GetCloudClient("No",client);
    if(CurrentClentInstance == null){

        ReturnInfo["Status"] = "Error";
        ReturnInfo["ErrorMessage"] = "Can not find client:" + client;
        res.end(JSON.stringify(ReturnInfo),"UTF-8");
        return ;
    }

    var bizTemplate =   req.query["bizTemplate"];
    if(bizTemplate == undefined || bizTemplate == null) {
        bizTemplate =  req.query["BizTemplate"];
    }
    var parameters = req.query["parameters"];
    if(parameters == undefined || parameters == null) {
        parameters =  req.query["Parameters"];
    }

    var packageType =   req.query["PackageType"];
    //若PackageType 参数为空则执行常规的模版命令，否则只执行 PackageType 涉及的命令
    if(packageType == undefined || packageType == null  ){

        var bizTemplateInfo =  CloudBusinessShared.GetBizTemplate("No",bizTemplate);
        if (bizTemplateInfo == null)
        {
            ReturnInfo["Status"] = "Error";
            ReturnInfo["ErrorMessage"] =  "Can not find bizTemplate:" + bizTemplate;
            res.end(JSON.stringify(ReturnInfo),"UTF-8");
            return ;
        }

        var bizTemplateDataSource = CloudBusinessShared.GetBizTemplateDataSource("DataSource",CurrentClentInstance["DataSource"],"BizTemplate",bizTemplateInfo["Id"]);
        if (bizTemplateDataSource == null)
        {
            ReturnInfo["Status"] = "Error";
            ReturnInfo["ErrorMessage"] = "Can't find biztemplate:" + bizTemplate + " for client:" + client;
            res.end(JSON.stringify(ReturnInfo),"UTF-8");
            return ;
        }


        if (parameters != null &&  parameters!="" && parameters!= undefined)
        {
            json["Parameters"] = JSON.parse(parameters);
        }
        json["CustomCode"] =  bizTemplateDataSource["CustomCode"];
    }else{
        json["PackageType"] = packageType;
    }


    //找到此客户端发送信息
    var currentTcpClient =  CloudBusinessShared.GetTcpClient("Id",client);
    if(currentTcpClient == null) {
        ReturnInfo["Status"] = "Error";
        ReturnInfo["ErrorMessage"] = "Client:" + client + " is not connected";
        res.end(JSON.stringify(ReturnInfo),"UTF-8");
        return ;
    }

    //判定是否还有相关的命令连接通道,如无则直接返回错误消息(出现此错误很有可能为客户端平台连接不上云平台导致)
    var commandConnList =  CloudBusinessShared.GetCommandConnection(client);
    if(commandConnList == null || commandConnList == undefined || commandConnList.length == 0){
        ReturnInfo["Status"] = "Error";
        ReturnInfo["ErrorMessage"] = "Client Command List :" + client + " is not connected,Please check it!";
        res.end(JSON.stringify(ReturnInfo),"UTF-8");
    }

    var charsLength = Buffer.byteLength(JSON.stringify(json), "UTF-8");
    //超过最大发送次数将直接返回错误信息
    if(charsLength > Config.BusinessCloudServiceConfig.MaxReceiveBytes ){
        Runlog.WriteLog("CWSBizTemplateRouter", "数据超过:" + Config.BusinessCloudServiceConfig.MaxReceiveBytes + "个字节,当前处理字节为:" + charsLength);
        res.end("CWSBizTemplateRouter:C_E1,Over maximum transmission length","UTF-8");
        return ;
    }
    //对request设置超时时间,如果配置中大于2分钟则设置，否者按照其默认设置即可
    if(Config.BusinessCloudServiceConfig.HttpContextWatingTimeOut > 120){
        req.connection.setTimeout(Config.BusinessCloudServiceConfig.HttpContextWatingTimeOut * 1000);
    }
    //记录日志信息创建。
    var LogSavedata = { AddedEntities:[] };
    var mainEntity = {
        "__EntityType": "ApplicationData.BizTemplateExecutionLog",
        "__UniqueId": 1,
        "BeginExecutionTime": new Date(),
        "BizTemplateId": (packageType == undefined || packageType == null  ) ? bizTemplateInfo["Id"] : -2147483641 ,
        "BizTemplateNo":(packageType == undefined || packageType == null  ) ? bizTemplate : packageType,
        "Client":CurrentClentInstance["Id"],
        "ExecutionMode":"Client",
        "Parameters":(packageType == undefined || packageType == null  ) ? parameters:packageType,
        "RetryCount":0,
        //"Result" : "Test",
        "Status": "Success",
        "EndExecutionTime": new Date()
    };

    LogSavedata.AddedEntities.push(mainEntity);
    var operatorKey = uuid.v4();


    function ExecutorControlProcess(LogSavedata,operatorKey,res){
        var ParamInstance = {};
        ParamInstance["OperatorKey"] = operatorKey;
        ParamInstance["ServerKey"] = client;
        ParamInstance["Response"] =  res;
        ParamInstance["BizTemplate"]  = bizTemplate;
        ParamInstance["ExecuteBizContent"] = json;
        ParamInstance["LogSaveData"] = LogSavedata;
        CloudBusinessShared.SetHttpContextInstance(operatorKey,ParamInstance);
        let temp_CurrentInstance = {};
        if(CloudBusinessShared.GetHttpContextInstance(operatorKey)){
            temp_CurrentInstance = CloudBusinessShared.GetHttpContextInstance(operatorKey)["HttpContext"];
        }

        if(temp_CurrentInstance){
            if(CloudBusinessShared.GetTcpClient(temp_CurrentInstance["ServerKey"])){
                CloudBusinessShared.GetEffectiveCommandConnection(temp_CurrentInstance).then(function(data){
                    if(Config.BusinessCloudServiceConfig.DebugMode) {
                        console.log("已找到对应的执行命令连接管道!");
                    }
                    let currentCommandConnection = data["CommandConnection"];
                    let CurrentInstance = data["CurrentInstance"];
                    if(currentCommandConnection){
                        let CurrentPackeageSystem = new mPackageSystem().uint32Head().littleEndian();
                        CurrentInstance["CommandInstance"]= currentCommandConnection;
                        currentCommandConnection["Instance"].removeAllListeners();
                        CurrentInstance["ExecuteBizContent"]["bizTemplateName"] = CurrentInstance["BizTemplate"];
                        CurrentInstance["ExecuteBizContent"]["OperatorKey"] = CurrentInstance["OperatorKey"];
                        let noticeLength  = Buffer.byteLength(JSON.stringify(CurrentInstance["ExecuteBizContent"]), "UTF-8");
                        var calcBuffer = new Buffer(4);
                        calcBuffer[0] = (noticeLength & 0x000000FF);calcBuffer[1] = ((noticeLength >> 8) & 0x000000FF);calcBuffer[2] =((noticeLength >> 16) & 0x000000FF);calcBuffer[3] = ((noticeLength >> 24) & 0x000000FF);
                        if(currentCommandConnection["Instance"].writable){
                            if(currentCommandConnection["Instance"].write(calcBuffer)){
                                currentCommandConnection["Instance"].write(JSON.stringify(CurrentInstance["ExecuteBizContent"]));
                                currentCommandConnection["Instance"].on("data", function(data){
                                    CurrentPackeageSystem.put(data);
                                });
                                currentCommandConnection["Instance"].on('close', function(error) {
                                    Runlog.WriteLog("ExecutorControlService", "client on close,"+"ServerKey:"+CurrentInstance["ServerKey"]+ ",Error:"+ error +'\r\n',"Error");
                                });
                                ////监听错误事件
                                currentCommandConnection["Instance"].on('error',function(error){
                                    Runlog.WriteLog("ExecutorControlService", "client on error, "+"ServerKey:"+CurrentInstance["ServerKey"]+ ",Error:"+ error +'\r\n' ,"Error");
                                });
                                //收到完整的包
                                CurrentPackeageSystem.on('data',function(data){
                                    let realData =  data.toString("UTF-8",0,data.length);
                                    try{
                                        if(realData){
                                            let LogSaveData = null;
                                            //找到并执行对应的Response回复
                                            let json = JSON.parse(realData);
                                            //搜索对应的HttpContext对象.
                                            if(json["OperatorKey"] != null && json != undefined){
                                                let currentOperatorKey =  json["OperatorKey"];
                                                let httpContextInstance =  CloudBusinessShared.GetHttpContextInstance(currentOperatorKey);
                                                if(httpContextInstance){
                                                    let CurrentInstance = httpContextInstance["HttpContext"];
                                                    if(CurrentInstance){
                                                        LogSaveData = CurrentInstance["LogSaveData"];
                                                        CurrentInstance["CommandInstance"]["InstanceStatus"] = "Normal";
                                                        //将执行结果设置到记录日志实体中。
                                                        LogSaveData.AddedEntities[0]["Result"] = JSON.stringify( json);
                                                        if(CurrentInstance!=null){
                                                            CurrentInstance["Response"].send(JSON.stringify( json));
                                                            CurrentInstance["Response"].end();
                                                            CloudBusinessShared.DelHttpContextInstance(currentOperatorKey);
                                                        }
                                                        CloudBusinessShared.SaveExecuteLog(LogSaveData);
                                                    }else{
                                                        Runlog.WriteLog("ExecutorControlService", "currentOperatorKey:" + currentOperatorKey +" is be deleted");
                                                    }
                                                }else{
                                                    Runlog.WriteLog("ExecutorControlService", "GetHttpContextInstance Connection Instance may be deleted!,currentOperatorKey:" + currentOperatorKey );
                                                }
                                            }
                                        }
                                    }catch(exception){
                                        Runlog.WriteLog("ExecutorControlService", "CurrentPackeageSystem On Data Exception:" + exception + "[errorData:"+realData+"]","Error");
                                    }
                                    finally {
                                        try {
                                            CurrentInstance.CommandInstance.Instance.removeAllListeners();
                                        }catch(exception){
                                            Runlog.WriteLog("ExecutorControlService", "CurrentInstance.CommandInstance.Instance Removing Events Exception:" + exception);
                                        }
                                        try {
                                            CurrentPackeageSystem.removeAllListeners();
                                        }catch(exception){
                                            Runlog.WriteLog("ExecutorControlService", "CurrentPackeageSystem Removing Events Exception:" + exception);
                                        }

                                        CurrentPackeageSystem = null;
                                    }
                                });
                            }
                        }
                    }else{
                        res.end("此请求等待" + ((Config.BusinessCloudServiceConfig.EffectiveCommandPollingCount * Config.BusinessCloudServiceConfig.EffectiveCommandPollingTime) / 1000)+"秒(此项为服务器配置超时项) 仍未找到可用的执行连接,此次操作取消。 E1");
                        try{
                            CurrentInstance["CommandInstance"]["InstanceStatus"] = "Normal";

                        }catch(exception){
                            //console.log("ExecutorControlService Exception1:"+exception);
                        }
                        CurrentInstance["LogSaveData"]["Result"] = "此请求等待" + ((Config.BusinessCloudServiceConfig.EffectiveCommandPollingCount * Config.BusinessCloudServiceConfig.EffectiveCommandPollingTime) / 1000)+"秒(此项为服务器配置超时项) 仍未找到可用的执行连接,此次操作取消。 E2";
                        //回调并记录日志
                        LogSaveData.AddedEntities[0]["Status"] = "Failed";
                        CloudBusinessShared.SaveExecuteLog(CurrentInstance["LogSaveData"]);
                    }
                },function(error){
                    if(error){
                        let CurrentInstance = error["CurrentInstance"];
                        let LogSaveData = CurrentInstance["LogSaveData"];
                        if(LogSaveData){
                            LogSaveData.AddedEntities[0]["Status"] = "Failed";
                            LogSaveData.AddedEntities[0]["EndExecutionTime"] = new Date();
                            LogSaveData.AddedEntities[0]["Result"] = "此请求等待" + ((Config.BusinessCloudServiceConfig.EffectiveCommandPollingCount * Config.BusinessCloudServiceConfig.EffectiveCommandPollingTime) / 1000)+"秒(此项为服务器配置超时项) 仍未找到可用的执行连接,此次操作取消。 E3";
                            //直接记录日志信息.。
                            CloudBusinessShared.SaveExecuteLog(LogSaveData);
                        }
                    }
                });
            }
        }else{
            res.send(util.errorResult("CWSBizTemplateRouter temp_CurrentInstance is Empty!"));
            res.end();
        }
    }

    ExecutorControlProcess(LogSavedata,operatorKey,res);
});
module.exports = router;


