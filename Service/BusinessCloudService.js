"use strict";
/**
 * Created by fnmxcl on 2015/11/12.
 */
var net = require('net');
var Config = require('../Config/Config');
var CloudBusinessShared = require('./../Shared/CloudBusinessShared.js');
var uuid = require('node-uuid');
var express = require('express');
var path = require('path');
var CWSModelRoutes = require('./../Routers/CWSModelRouter.js');
var CWSBizTemplateRouter = require('./../Routers/CWSBizTemplateRouter.js');
var WebSiteAccessRouter = require('./../Routers/WebSiteAccessRouter.js');
var Runlog = require('./BusinessLog.js');
var Request = require('request');
var querystring = require('querystring');
var async = require('async');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var AutoTaskSchedule = require('./AutoTaskSchedule.js');
var fs = require('fs');

var ApplicationContext = require("SBE.AppFrame/Application/Server/ApplicationContext.js");
var APPModelManage = require("SBE.AppFrame/Model/ModelManage/APPModelManage");
var DataService = require("SBE.AppFrame/Application/Server/Service/DataService");
var APPModelsConfig = require("SBE.AppFrame/Model/ModelManage/APPModelsConfig.js");


 function Start(){
     var dataServiceisMy = new DataService();
     var APPModelPath = path.join(__dirname,"./../ModelAppFiles");
     var compiledModelPath = path.join(__dirname,"./../Data/");
     var modelConfig = new APPModelsConfig(APPModelPath,compiledModelPath);
     var applicationContext = new ApplicationContext(modelConfig);
     var includeDebugInfo = false;
     applicationContext.init(includeDebugInfo,true)
         .then(function(result){
                 console.log('应用程序上下文初始化成功......');

                 async.series([function queryCloudClients(callback){
                         //加载平台相关的表信息
                         var queryinfo = {
                             TabularType:'ApplicationData.Client',
                             Properties:['Id','No','Name','DataSource','ConnectionString','Database']
                         };
                         try{
                             dataServiceisMy.dataQuery(queryinfo,function(err,queryResult){
                                 if(err){
                                     callback("BusinessCloudService reading Cloud Clients Error, abort the application,Error:"+err,null);
                                     return;
                                 }
                                 if (queryResult!= null && queryResult!= undefined  ) {
                                     if(queryResult.Items && queryResult.Items.length > 0){
                                         CloudBusinessShared.CloudClientList = queryResult.Items;
                                         Runlog.WriteLog("BusinessCloudService", "queryCloudClients success response S1 Success!");
                                     }
                                 }
                                 callback(null,"queryCloudClients");
                             });
                         }catch(exception){
                             callback("BusinessCloudService reading Cloud Clients Error, abort the application,Error:"+exception,null);
                         }
                     },
                         function   queryCloudDataSounce(callback){
                             var queryinfo = {
                                 TabularType:'ApplicationData.DataSource',
                                 Properties:['Id','Description','IsDefault','Model','Name','No','DataSourceVersion']
                             };
                             try{
                                 //TODO: 目前暂时因为时间问题未时间，后面时间充裕之后继续修改。
                                 dataServiceisMy.dataQuery(queryinfo,function(err,data){
                                     try{
                                         var srcInfo = JSON.parse(fs.readFileSync('./Config/DataSourceInfo.json').toString().trim());
                                         if( srcInfo){
                                             //比较版本是否发生了变化
                                             for(let index = 0;index < srcInfo.length; index ++){
                                                var filterDataSource = data.Items.filter(v=>v.No == srcInfo[index].No &&
                                                    v.DataSourceVersion.readUInt32BE(4) != srcInfo[index].DataSourceVersion )[0];
                                                    //查找相关变化过的数据源。暂存准备给各客户端发送重新连接命令。
                                                 if( filterDataSource ){

                                                 }
                                             }
                                         }
                                     }catch(exception){

                                     }

                                     if(err){
                                         callback("BusinessCloudService reading Cloud DataSounce Error, abort the application,Error:"+err,null);
                                         return;
                                     }
                                     var registerInfo = null;
                                     if (data!= null && data!= undefined && data.Items && data.Items.length > 0) {
                                         CloudBusinessShared.CloudDataSourceList = data.Items;
                                         //保存数据源的版本信息。
                                         var dataSourceVersionInfo = [];
                                         for(let index = 0;index < data.Items.length; index ++){
                                             dataSourceVersionInfo.push({
                                                 Id:data.Items[index].Id,
                                                 No:data.Items[index].No,
                                                 DataSourceVersion:data.Items[index].DataSourceVersion.readUInt32BE(4)
                                             });
                                         }

                                         try {
                                             fs.writeFileSync('./Config/DataSourceInfo.json', JSON.stringify(dataSourceVersionInfo, null, 4));
                                         } catch (exception) {
                                             callback("BusinessCloudService queryCloudDataSounce Error, abort the application,Error:"+exception,null);
                                         }

                                         Runlog.WriteLog("BusinessCloudService", "queryCloudDataSounce success response S2 Success!");

                                     }else{
                                         Runlog.WriteLog("BusinessCloudService", "queryCloudClients success response S2 Success ,But Data is Empty!","Error");
                                     }
                                     callback(null,"queryCloudDataSounce");
                                 });
                             }catch(exception)
                             {
                                 callback("BusinessCloudService reading Cloud DataSounce Error, abort the application,Error:"+exception,null);
                             }
                         },
                         function queryBizTemplate(callback){
                             var queryinfo = {
                                 TabularType:'ApplicationData.BizTemplate',
                                 Properties:['Id','No','Name','CreateTime','UpdateTime']
                             };
                            try{
                                dataServiceisMy.dataQuery(queryinfo,function(err,data){
                                    if(err){
                                        callback("BusinessCloudService queryBizTemplate Error, abort the application,Error:"+err,null);
                                        return;
                                    }
                                    var registerInfo = null;
                                    if (data!= null && data!= undefined && data.Items && data.Items.length > 0) {
                                        CloudBusinessShared.CloudBizTemplateList = data.Items;
                                        Runlog.WriteLog("BusinessCloudService", "queryBizTemplate success response S3 Success!");

                                    }else{
                                        Runlog.WriteLog("BusinessCloudService", "queryBizTemplate success response S3,But Data is Empty!","Error");
                                    }
                                    callback(null,"queryCloudDataSounce");
                                });
                            }catch(exception){
                                callback("BusinessCloudService queryBizTemplate Error, abort the application,Error:"+exception,null);
                            }
                         },
                         function queryBizTemplateDataSource(callback){
                             var queryinfo = {
                                 TabularType:'ApplicationData.BizTemplateDataSource',
                                 Properties:['Id','BizTemplate','CustomCode','DataSource']
                             };

                             try{
                                 dataServiceisMy.dataQuery(queryinfo,function(err,data){
                                     if(err){
                                         callback("BusinessCloudService queryBizTemplate Error, abort the application,Error:"+err,null);
                                         return;
                                     }
                                     var registerInfo = null;
                                     if (data!= null && data!= undefined && data.Items && data.Items.length > 0) {
                                         CloudBusinessShared.CloudBizTemplateDataSource  = data.Items;
                                         Runlog.WriteLog("BusinessCloudService", "queryBizTemplate success response S4 Success!");

                                     }else{
                                         Runlog.WriteLog("BusinessCloudService", "queryBizTemplate success response S4 Success ,But Data is Empty!","Error");
                                     }
                                     callback(null,"queryBizTemplate");
                                 });
                             }catch(exception){
                                 callback("BusinessCloudService reading BizTemplateDataSource Error, abort the application,exception:"+exception,null);
                             }
                         }
                     ],
                     function(error,result){
                         if(error) {
                             console.log("BusinessCloudService Error : E3,Detail:" + error);
                             return ;
                         }
                         //云平台TCP应用服务---------------------------------------------------------------------------
                         var clientManageServer = net.createServer();
                         CloudBusinessShared.ClientManageServer = clientManageServer;
                         clientManageServer.listen(Config.BusinessCloudServiceConfig.TcpServicePort);
                         //获取连接事件
                         clientManageServer.on('connection',ProcessClientConntion);
                         //获取客户端发送数据的事件
                         Runlog.WriteLog("BusinessCloudService", "Client Manage Service  is Started");
                         //云平台TCP应用服务---------------------------------------------------------------------------

                         //云平台命令执行TCP应用服务---------------------------------------------------------------------------
                         var clientCommandServer = net.createServer();
                         clientCommandServer.listen(Config.BusinessCloudServiceConfig.CommandCloudWebServicePort);
                         clientCommandServer.on('connection',ProcessCommandConnection);
                         CloudBusinessShared.ClientCommandServer = clientCommandServer;
                         Runlog.WriteLog("BusinessCloudService", "Client Command Service  is Started");
                         //云平台命令执行Web服务-------------------------------------------------------------------------------
                         //启动云平台WEB服务
                         var cloudWebService = express();
                         CloudBusinessShared.CloudWebService = cloudWebService;

                         //cloudWebService.use(express.query());
                         //模型相关的路由
                         cloudWebService.use('/Model',CWSModelRoutes);
                         //设置执行模版路由
                         cloudWebService.use('/CloudAPI',CWSBizTemplateRouter);
                         //设置对外的接口信息
                         cloudWebService.use('/WebSiteAccess',WebSiteAccessRouter);
                         //设置静态资源目录。
                         cloudWebService.use(express.static(path.join(__dirname, '../ManagePresentation')));
                         cloudWebService.use(express.static(path.join(__dirname, 'bower_components')));

                         cloudWebService.use('/lib', express.static('bower_components'));
                         cloudWebService.listen(Config.BusinessCloudServiceConfig.CloudWebServicePort || 19862, function(){
                             if(Config.BusinessCloudServiceConfig.DebugMode) {
                                 console.log('Express server listening');
                             }
                             Runlog.WriteLog("BusinessCloudService", 'Express server listening');
                         });

                         cloudWebService.use(function(err, req, res, next) {
                             console.error(err.stack);
                             res.status(500).send('异常错误! 500 CODE Error:'+err);
                             Runlog.WriteLog("BusinessCloudService", '异常错误!  E2:' + err,"Error");
                         });
                         //云平台Web服务-------------------------------------------------------------------------------
                     });

                 //启动自动任务系统
                 AutoTaskSchedule.Start();
             },
             function(err){
                 console.error('application context inited error:'+err.toString());
             });



}

function ProcessCommandConnection(client){

    Runlog.WriteLog("BusinessCloudLog", "ProcessCommandConnection Received Client Connection Request: " + client.remoteAddress);

    //client.once("error",function(error){
    //
    //});
    //client.once("close",function(data){
    //
    //});

    client.once("data",function(data){

        Runlog.WriteLog("BusinessCloudLog", "ProcessCommandConnection Received Client Read Data: " + data + ",Client:" + client);

        if(data.toString().match(/Connection: Keep-Alive/g)){
            Runlog.WriteLog("BusinessCloudLog", "ProcessCommandConnection IS Keep-Alive!");
            return;
        }
        //if(data.Cont Connection: Keep-Alive)
        //48个字节的请求身份信息。
        if(data.length != 48){
            Runlog.WriteLog("BusinessCloudLog", "Received Error Data ,Client Closing");
            var retValue = {};
            retValue["ReturnInfo"] = "标识身份不被服务器认可(要求48字节)!";
            if(client.writable){
                client.write(JSON.stringify(retValue));
            }
            client.destroy();
        }else{
            var clientJSON = JSON.parse(data.toString("UTF-8"));
            var currentTcpClient =  CloudBusinessShared.GetTcpClient("Id",clientJSON["ClientID"]);
            if(currentTcpClient){
                //获取命令执行连接列表。 根据参数设定每客户端允许最大连接数。
                var commandConnectionList = CloudBusinessShared.GetCommandConnection(clientJSON["ClientID"]);
                if(commandConnectionList != null && commandConnectionList.length == Config.BusinessCloudServiceConfig.MaxCommandConnectionNumber){
                    var retValue = {};
                    retValue["ReturnInfo"] = "超过最大命令连接数!";
                    if(client.writable){
                        client.write(JSON.stringify(retValue));
                        client.destroy();
                    }
                    return;
                }

                Runlog.WriteLog("BusinessCloudLog", "当前：" + clientJSON["ClientID"] + "的连接数:" + (commandConnectionList.length + 1));

                if(clientJSON!=null && clientJSON!=undefined){
                    var retValue = {};
                    retValue["ReturnInfo"] = "OK";
                    if(client.writable){
                        client.write(JSON.stringify(retValue));
                    }
                    CloudBusinessShared.SetCommandConnection(clientJSON["ClientID"],client);
                }
            }else{
                var retValue = {};
                retValue["ReturnInfo"] = "标识身份未在服务器通过验证!";
                if(client.writable){
                    client.write(JSON.stringify(retValue));
                    client.destroy();
                }
            }
        }
    });
}


function ProcessClientConntion(client){
    //Runlog.WriteLog("BusinessCloudLog", "Received Client Connection Request: " + client.remoteAddress);
    //数据到达事件
    client.on("data",function(data){
        //数据到达事件
        if(data.length == 3 ){
            //接收到了ack字符并
            try{
                if(client){
                    CloudBusinessShared.TcpClientACKTimeModify(client);
                }else{
                    Runlog.WriteLog("BusinessCloudLog", "Call TcpClientACKTimeRepair Fun Client is Null! " );
                }
            }catch(exception){

            }
        }else{
            ProcessClientDataEvent(data,client);
        }
    });
    //监听关闭事件
    client.on('close', function(data) {
        ProcessCloseEvent(data,client);
    });
    ////监听错误事件
    client.on('error',function(error){
        ProcessServiceErrorEvent(error,client);
    });

}
function ProcessServiceErrorEvent(error,instance){
    //if(error){
    //    Runlog.WriteLog("BusinessCloudLog", "ProcessServiceErrorEvent error: "+error ,"Error");
    //}
    instance.destroy();
}

function ProcessCloseEvent(data,instance){
    var currentTcpClient =  CloudBusinessShared.GetTcpClient("Instance",instance);

    if(currentTcpClient){
        try {
            //先删除命令连接
            CloudBusinessShared.ClearCommandConnection(currentTcpClient["Id"]);
        }catch(exception){
            Runlog.WriteLog("BusinessCloudLog", "ProcessCloseEvent ClearCommandConnection Exception:" + exception);
        }
    }

    try{
        if(CloudBusinessShared.DeleteTcpClient("Instance",instance)){
            Runlog.WriteLog("BusinessCloudLog", "Closed Success! " );
        }
        instance.destroy();

    }catch(exception){
        Runlog.WriteLog("BusinessCloudLog", "ProcessCloseEvent Closed MainTcp Exception:" + exception);
    }
}



function ProcessClientDataEvent(data,instance){
    var currentDate =  new Date();
    var clientInstace = {};
    var existsClientID = false;
    var responseMessage = {};
    responseMessage["ServerCommandAddress"] =  Config.BusinessCloudServiceConfig.CommandCloudWebServiceAddress;
    responseMessage["ServerCommandPort"] = Config.BusinessCloudServiceConfig.CommandCloudWebServicePort;
    responseMessage["MaxCommandConnectionNumber"]  = Config.BusinessCloudServiceConfig.MaxCommandConnectionNumber;
    responseMessage["CloudClientAckTimeInterval"]  = Config.BusinessCloudServiceConfig.CloudClientAckTimeInterval;
    if(data.toString("UTF-8")){
        Runlog.WriteLog("BusinessCloudLog", "Received " + instance.remoteAddress + "  Message :" + data.toString("UTF-8"));
        clientInstace["Id"] = data.toString("UTF-8");
        clientInstace['ConnectionTime'] = currentDate.toLocaleDateString() + " "+ currentDate.toLocaleTimeString();
        clientInstace['ACKTime'] = new Date();
        clientInstace["Instance"] = instance;
        if(CloudBusinessShared.GetCloudClient("No",data.toString("UTF-8"))){
            existsClientID = true;
        }
        if(!existsClientID){
            responseMessage["ServerStatus"] = "Can't find client:" +  data.toString("UTF-8");
        }else{
            responseMessage["ServerStatus"] = "OK";
        }
        if (responseMessage["ServerStatus"] == "OK")
        {
            Runlog.WriteLog("BusinessCloudLog", "客户注册成功:" + data.toString("UTF-8"));

            var currentTcpClient =  CloudBusinessShared.GetTcpClient("Id",data.toString("UTF-8"));
            if(currentTcpClient){
                try
                {
                    currentTcpClient.destroy();
                }
                catch(exception){

                    Runlog.WriteLog("BusinessCloudLog", "ExistsClient Destroy Error:"+ data.toString("UTF-8"),"Error");
                }
                CloudBusinessShared.ClearCommandConnection(data.toString("UTF-8"));
                if(!CloudBusinessShared.DeleteTcpClient("Id",data.toString("UTF-8"))){
                    Runlog.WriteLog("BusinessCloudLog", "DELETE SetTcpClient Error:"+ data.toString("UTF-8"),"Error");
                    instance.destroy();
                    return;
                }
                CloudBusinessShared.TcpClientList.push(clientInstace);
            }else{
                CloudBusinessShared.TcpClientList.push(clientInstace);
            }
        }
        instance.write(JSON.stringify(responseMessage));
        if (responseMessage["ServerStatus"] != "OK"){
            instance.destroy();
        }
    }
    else{
        instance.destroy();
    }
}
module.exports.Start = Start;
