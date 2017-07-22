"use strict";
/**
 * Created by fnmxcl on 2015/11/25.
 */
var express = require('express');
var router = express.Router();
var Runlog = require('../Service/BusinessLog.js');
var Config = require('../Config/Config');
var CloudBusinessShared = require('./../Shared/CloudBusinessShared.js');
var fs = require('fs');
require('date-utils');
var async = require('async');

router.get('/Login', function(req, res) {
    var retMessage = {};
    var loginInfoParam = JSON.parse(req.query.request);
    if(Config.ManageUserConfig){
        for(var index = 0; index < Config.ManageUserConfig.length;index ++){
            if(Config.ManageUserConfig[index]["UserName"] == loginInfoParam.UserName  && Config.ManageUserConfig[index]["UserPassWord"] == loginInfoParam.PassWord){
                retMessage["Status"] = "Success";
                retMessage["Message"] = "登录成功";

                var LoginInfo = {"UserName":Config.ManageUserConfig[index]["UserName"] ,
                    "Discription":Config.ManageUserConfig[index]["Discription"] ,
                    "CreateTime": Config.ManageUserConfig[index]["CreateTime"],
                    "GuidID": Config.ManageUserConfig[index]["GuidID"]
                };

                retMessage["LoginInfo"] = LoginInfo;
                //req.session.LoginInfo = LoginInfo;
                res.end(JSON.stringify(retMessage),"UTF-8");

                return;
            }
        }
        //未找到相关用户或密码不对
        retMessage["Status"] = "Error";
        retMessage["Message"] = "用户名或密码错误!";
        retMessage["LoginInfo"] = null;

        res.end(JSON.stringify(retMessage),"UTF-8");
    }else{
        retMessage["Status"] = "Error";
        retMessage["Message"] = "无相关用户信息";
        retMessage["LoginInfo"] = null;
        res.end(JSON.stringify(retMessage),"UTF-8");
    }

    //if(req.session.lastPage) {
    //             console.log('Last page was: ' + req.session.lastPage + ".");
    //         }
    // req.session.lastPage = '/Login'; //每一次访问时，session对象的lastPage会自动的保存或更新内存中的session中去。
    // res.send("You're Awesome. And the session expired time is: " + req.session.cookie.maxAge);


});



// GetCloudPlatformParams 获取运行参数
router.get('/GetCloudPlatformParams', function(req, res) {
        var returnParams = {};
        for(var item in Config.BusinessCloudServiceConfig){
            returnParams[item] = Config.BusinessCloudServiceConfig[item];
        }
        res.end(JSON.stringify(returnParams),"UTF-8");

});

router.get('/GetPlatformInformation',function(req,res){
    var PlatformInfo = [];
    var mem = process.memoryUsage();
    var format = function(bytes) {
        return (bytes/1024/1024).toFixed(2)+'MB';
    };

    //console.log('Process: heapTotal '+format(mem.heapTotal) + ' heapUsed ' + format(mem.heapUsed) + ' rss ' + format(mem.rss));
    //console.log('----------------------------------------');

    PlatformInfo.push({"Name":"Memory","Property":[
        {"Name":"heapTotal","Value":format(mem.heapTotal)},
        {"Name":"heapUsed","Value":format(mem.heapUsed)},
        {"Name":"rss","Value":format(mem.rss)}]});


    res.end(JSON.stringify(PlatformInfo),"UTF-8");
});




// 保存云平台参数
router.get('/SetCloudPlatformParams', function(req, res) {
    console.log("云平台状态管理网站调用了一次SetCloudPlatformParams!");

    var retValue = {};
            ////重启应用服务器(清除所有的队列)
            async.series([
                    function updateParams(callback) {
                        Runlog.WriteLog("WebSiteAccessRouter", "正在保存参数并重启云平台!");
                        //更新内存中的参数
                        if (req.query.request) {
                            var modifyParams = JSON.parse(req.query.request);
                            //开始更新覆盖参数
                            for (var index = 0; index < modifyParams.length; index++) {
                                for (var configItem in Config.BusinessCloudServiceConfig) {
                                    if (configItem == modifyParams[index].ParamKey) {
                                        Config.BusinessCloudServiceConfig[configItem] = modifyParams[index].ParamValue;
                                    }
                                }
                            }
                            //此出需要存文件.
                            var contentConfig = JSON.parse(fs.readFileSync('./Config/BusinessCloudServiceConfig.json').toString().trim());
                            for (var index = 0; index < modifyParams.length; index++) {
                                for (var configItem in contentConfig.BusinessCloudServiceConfig) {
                                    if (configItem == modifyParams[index].ParamKey) {
                                        contentConfig.BusinessCloudServiceConfig[configItem] = modifyParams[index].ParamValue;
                                    }
                                }
                            }
                            try {
                                fs.writeFileSync('./Config/BusinessCloudServiceConfig.json', JSON.stringify(contentConfig, null, 4));
                            } catch (exception) {
                                //retValue.Status = "Error";
                                //retValue.Message = "保存参数并重启应用服务器出现异常:"+exception ;
                                //res.status(500).send(JSON.stringify(retValue));
                                callback(exception, null);
                            }
                        }
                        callback(null, "updateParams");
                    },
                    function freeResources(callback) {
                        Runlog.WriteLog("WebSiteAccessRouter", "清除所有已连接的客户端以及TCP资源!");
                        ////剔除无效的命令连接。
                        while (true) {
                            var success = false;
                            for (var index = 0; index < CloudBusinessShared.TcpCommandConnectionList.length; index++) {
                                try {
                                    CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].destroy();

                                }
                                catch (exception) {
                                }
                                CloudBusinessShared.TcpCommandConnectionList.splice(index, 1);
                                success = true;
                                break;
                            }
                            if (!success) {
                                break;
                            }
                        }
                        while (true) {
                            var success = false;
                            for (var index = 0; index < CloudBusinessShared.HttpContextInstance.length; index++) {
                                CloudBusinessShared.HttpContextInstance.splice(index, 1);
                                success = true;
                                break;
                            }
                            if (!success) {
                                break;
                            }
                        }
                        //清除主要连接对象
                        while (true) {
                            var success = false;
                            for (var index = 0; index < CloudBusinessShared.TcpClientList.length; index++) {
                                try {
                                    CloudBusinessShared.TcpClientList[index]["Instance"].destroy();
                                } catch (exception) {

                                }
                                CloudBusinessShared.TcpClientList.splice(index, 1);
                                success = true;
                                break;
                            }
                            if (!success) {
                                break;
                            }
                        }
                        callback(null, "freeResources");

                    }
                ],
                function (error, result) {
                    if (error) {
                        retValue.Status = "Error";
                        retValue.Message = "保存参数并重启应用服务器出现异常:" + error;
                        res.end(JSON.stringify(retValue),"UTF-8");
                    } else {
                        retValue.Status = "Success";
                        retValue.Message = "已保存所有运行的参数";
                        res.end(JSON.stringify(retValue),"UTF-8");
                    }
                    Runlog.WriteLog("WebSiteAccessRouter", "保存参数并重启云平台结束!");
                    //云平台Web服务-------------------------------------------------------------------------------
                });
        //}else{
        //    var retMessage = {};
        //    retMessage["Status"] = "Error";
        //    retMessage["Message"] = "身份无效";
        //    retMessage["LoginInfo"] = null;
        //    res.status(401).send(retMessage);
        //}
    }

);


router.get('/GetClientInfo',function(req,res){
    var ClientInfo = [];
    for(var item = 0;item < CloudBusinessShared.CloudClientList.length; item ++ ){
        var clientRow = {};
        clientRow["Id"] = CloudBusinessShared.CloudClientList[i]["Id"];
        clientRow["No"] = CloudBusinessShared.CloudClientList[i]["No"];
        clientRow["Name"] = CloudBusinessShared.CloudClientList[i]["Name"];
        clientRow["DataSource"] = CloudBusinessShared.CloudClientList[i]["DataSource"];
        clientRow["Database"] = CloudBusinessShared.CloudClientList[i]["Database"];
        if(CloudBusinessShared.TcpClientList.filter(function(client){
                    return client.No == CloudBusinessShared.CloudClientList[item]["No"]["Id"];
                })){
            clientRow["Connected"] = 1;
        }else{
            clientRow["Connected"] = 0;
        }
        ClientInfo.push(clientRow);
    }
    res.end(JSON.stringify(ClientInfo),"UTF-8");

    console.log("云平台状态管理网站调用了一次GetClientInfo!");
});
//监控已连接的云平台客户端
router.get("/MonitoringCloudClient",function(req,res){
    //if(req.session.LoginInfo) {
        var monitoringData = [];
        //$scope.Data = [{Client: "2CD9E03F1A523E96EB5381C63CCD904C", PipeNumber: "0", State: "Normal"},
        //    {Client: "2366A9540950B357BD3084F723DB1C53", PipeNumber: "1", State: "Normal"},
        //    {Client: "9A3F2D81287763961A441DDF8137C69E", PipeNumber: "2", State: "Normal"}];

        if (CloudBusinessShared.TcpClientList != undefined &&
            CloudBusinessShared.TcpClientList != null &&
            CloudBusinessShared.TcpClientList.length > 0) {

            for (var index = 0; index < CloudBusinessShared.TcpClientList.length; index++) {
                var tcpClient = {};
                tcpClient["Id"] = CloudBusinessShared.TcpClientList[index]["Id"];
                tcpClient["ConnectionTime"] = CloudBusinessShared.TcpClientList[index]["ConnectionTime"];
                tcpClient["ACKTime"] = CloudBusinessShared.TcpClientList[index]["ACKTime"].toFormat("YYYY-MM-DD HH24:MI:SS");

                 var client  =  CloudBusinessShared.CloudClientList.filter(function(client){
                    return client.No == tcpClient["Id"];
                 });
                if(client[0]){
                    tcpClient["ClientName"] = client[0]["Name"];
                }
                var commandList = CloudBusinessShared.GetCommandConnection(CloudBusinessShared.TcpClientList[index]["Id"]);
                tcpClient["CommandNumber"] = commandList.length;
                var currentOperationNumber = 0;
                for (var i = 0; i < commandList.length; i++) {
                    if (commandList[i]["InstanceStatus"] == "Processing") {
                        currentOperationNumber = currentOperationNumber + 1;
                    }
                }
                tcpClient["OperationChannel"] = currentOperationNumber;
                monitoringData.push(tcpClient);
            }
        }
        res.end(JSON.stringify(monitoringData),"UTF-8");

    console.log("云平台状态管理网站调用了一次MonitoringCloudClient!");
});


module.exports = router;
