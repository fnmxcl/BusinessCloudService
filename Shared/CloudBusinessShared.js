/**
 * Created by fnmxcl on 2015/11/27.
 */
var CloudBusinessShared = require('./CloudBusinessShared.js');
var TCP_CONNECTION_LIST = [];
var TCP_SERVER_LIST = [];
var TCP_COMMAND_CONNECTIONLIST = [];
var CLOUD_CONNECTION_LIST = [];
var ClOUD_DATASOURCE_LIST =[];
var CLOUD_BizTemplate_LIST = [];
var CLOUD_BizTemplateDataSource_LIST = [];
var HTTP_CONTEXT_INSTANCE = [];
var uuid = require('node-uuid');
var Q = require('q');
var Runlog = require('../Service/BusinessLog.js');
var Config = require('../Config/Config');
var DataService = require("SBE.AppFrame/Application/Server/Service/DataService.js");

/*
 TcpClientList  参数 Id(ClientID编号),ConnectionTime(连接时间),ACKTime(最近ACK时间),Instance(实例)
 */
module.exports.TcpClientList  = TCP_CONNECTION_LIST;
/*
 TcpCommandConnectionList  参数 ClientID(ClientID编号),Instance(实际的命令TCP连接),InstanceStatus(实例状态)
 */
module.exports.TcpCommandConnectionList = TCP_COMMAND_CONNECTIONLIST;
module.exports.CloudClientList  = CLOUD_CONNECTION_LIST;
module.exports.CloudDataSourceList  = ClOUD_DATASOURCE_LIST;
module.exports.CloudBizTemplateList = CLOUD_BizTemplate_LIST;
module.exports.CloudBizTemplateDataSource = CLOUD_BizTemplateDataSource_LIST;
module.exports.HttpContextInstance = HTTP_CONTEXT_INSTANCE;
//客户端管理服务对象
module.exports.ClientManageServer = null;
//命令管理服务对象
module.exports.ClientCommandServer = null;
//云平台WEB服务对象
module.exports.CloudWebService = null;

module.exports.SetHttpContextInstance = function(operatorKey,sender){
    console.log("CloudBusinessShared调用了一次 SetHttpContextInstance!");


    var httpContextInstance= {};
    httpContextInstance["OperatorKey"] = operatorKey;
    httpContextInstance["HttpContext"] = sender;
    httpContextInstance["CreateDateTime"] = new Date();
    CloudBusinessShared.HttpContextInstance.push(httpContextInstance);
};

module.exports.GetHttpContextInstance = function(operatorKey){
    console.log("CloudBusinessShared调用了一次 GetHttpContextInstance!");


    for(var index = 0;index < CloudBusinessShared.HttpContextInstance.length;index ++ ){
        if(CloudBusinessShared.HttpContextInstance[index]["OperatorKey"] == operatorKey){
            return CloudBusinessShared.HttpContextInstance[index];
        }
    }
    return null;
};



module.exports.DelHttpContextInstance = function(operatorKey){
    console.log("CloudBusinessShared调用了一次 DelHttpContextInstance!");


    while(true){
        var success = false;
        for(var index = 0;index < CloudBusinessShared.HttpContextInstance.length;index ++ ){
            //剔除无效的命令连接。
            if(CloudBusinessShared.HttpContextInstance[index]["OperatorKey"] == operatorKey){
                try{
                    CloudBusinessShared.HttpContextInstance[index]["Instance"].destroy();
                }
                catch(exception){
                }
                CloudBusinessShared.HttpContextInstance.splice(index,1);
                success = true;
                break;
            }
        }
        if(!success){
            break;
        }
    }
};


module.exports.SaveExecuteLog  = function(logContent){
    if((typeof Config.BusinessCloudServiceConfig.DebugMode == "string"  && Config.BusinessCloudServiceConfig.DebugMode.toUpperCase() == "TRUE" )||
        (typeof Config.BusinessCloudServiceConfig.DebugMode == "boolean"  && Config.BusinessCloudServiceConfig.DebugMode)){

        if(logContent){
            try{
                //加入执行结束时间
                logContent.AddedEntities[0].EndExecutionTime = new Date();
                var dataService = new DataService();
                dataService.saveChanges(logContent,function(error,result){
                    if(error){
                        Runlog.WriteLog("CloudBusinessShared", "记录云平台操作日志失败:" + error,"Error");
                    }else if(result){
                        if(result.Status == "OK"){
                            Runlog.WriteLog("CloudBusinessShared", "记录云平台操作日志成功!");
                        }
                        else{
                            Runlog.WriteLog("CloudBusinessShared", "记录云平台操作日志失败:" + result.ErrorMessage);
                        }
                    }else{
                        Runlog.WriteLog("CloudBusinessShared", "记录云平台操作日志失败:返回值为空!");
                    }
                });
            }catch(exception){
                Runlog.WriteLog("CloudBusinessShared", "记录云平台操作日志异常:"+exception);
            }
        }else{
            Runlog.WriteLog("CloudBusinessShared", "记录云平台操作日志出现错误:传入的日志内容参数为空!");
        }
    }else{
        console.log("当前DEBUG参数设定的值为False,云平台日志记录忽略.");
    }

}

module.exports.RepairHttpContextInstance = function(){
    console.log("CloudBusinessShared调用了一次 RepairHttpContextInstance!");


    while(true){
        var success = false;
        for(var index = 0;index < CloudBusinessShared.HttpContextInstance.length;index ++ ){
            //剔除无效的HTTPContext内容项。
            var httpContextInstance = CloudBusinessShared.HttpContextInstance[index]["CreateDateTime"];
            var CurrentDateTime = new Date();

            if((CurrentDateTime - httpContextInstance ) /1000 >= Config.BusinessCloudServiceConfig.HttpContextWatingTimeOut ){
                try{
                    var currentHttpContext = CloudBusinessShared.HttpContextInstance[index]["HttpContext"];
                    if(currentHttpContext){
                        currentHttpContext["CommandInstance"]["InstanceStatus"] = "Normal";
                        if(currentHttpContext["LogSaveData"]){
                            //记录日志.
                            var LogSaveData =    currentHttpContext["LogSaveData"];
                            LogSaveData.AddedEntities[0]["EndExecutionTime"] = new Date();
                            LogSaveData.AddedEntities[0]["Status"] = "Failed";
                            LogSaveData.AddedEntities[0]["Result"] = "HttpContextInstance执行超时,当前执行管道被删除!E1,此项信息标识意义为执行超时,服务器设置的最大执行时间为:"+Config.BusinessCloudServiceConfig.HttpContextWatingTimeOut;
                            CloudBusinessShared.SaveExecuteLog(LogSaveData,function(error,saveResult){
                                if(error){
                                    if(Config.BusinessCloudServiceConfig.DebugMode) {
                                        console.log("调用dataService.savedata(LogSaveData)错误返回!");
                                    }
                                    if(typeof error === "string" ){
                                        Runlog.WriteLog("CloudBusinessShared", "记录操作日志失败 C2S:" + error,"Error");

                                    }else if(typeof error === "object" ){

                                        Runlog.WriteLog("CloudBusinessShared", "记录操作日志失败 C2O:" + JSON.stringify(error),"Error");

                                    }
                                }else {
                                    if (Config.BusinessCloudServiceConfig.DebugMode) {
                                        console.log("调用dataService.savedata(LogSaveData)成功返回!");
                                    }
                                    if (typeof saveResult === "string") {
                                        //Runlog.WriteLog("CWSBizTemplateRouter", "记录操作日志成功 L1S:" + data);
                                        Runlog.WriteLog("CloudBusinessShared", "记录操作日志成功 C2S!");
                                    } else if (typeof saveResult === "object") {
                                        //Runlog.WriteLog("CWSBizTemplateRouter", "记录操作日志成功 L1O:" + JSON.stringify(data));
                                        Runlog.WriteLog("CloudBusinessShared", "记录操作日志成功 C2O!");
                                    }
                                }
                            });
                        }
                    }
                }
                catch(exception){

                }finally{
                    CloudBusinessShared.HttpContextInstance.splice(index,1);
                    if(Config.BusinessCloudServiceConfig.DebugMode) {
                        Runlog.WriteLog("CloudBusinessShared","删除了一个HttpContextInstance,目前还有:"+CloudBusinessShared.HttpContextInstance.length +" 个实例!");
                    }

                    try{
                        //如存在Response对象则回复超时时间。
                        if(currentHttpContext["Response"]){
                            var ReturnInfo = {};
                            ReturnInfo["Status"] = "Error";
                            ReturnInfo["ErrorMessage"] ="HttpContextInstance执行超时,当前执行管道被删除!E1,服务器设置的最大执行时间为:"+Config.BusinessCloudServiceConfig.HttpContextWatingTimeOut;
                            currentHttpContext["Response"].status(200).send(ReturnInfo);
                        }
                    }catch(exception){

                    }
                }
                success = true;
                break;
            }
        }
        if(!success){
            break;
        }
    }
};



module.exports.GetCloudClient  = function(filedkey,value){
    console.log("CloudBusinessShared调用了一次 GetCloudClient!");


    for(var index = 0;index < CloudBusinessShared.CloudClientList.length;index ++ ){
        if(CloudBusinessShared.CloudClientList[index][filedkey] == value){
            return CloudBusinessShared.CloudClientList[index];
        }
    }
    return null;
};



module.exports.GetDataSource  = function (filedkey,value){
    //console.log("CloudBusinessShared调用了一次 GetDataSource!");


    for(var index = 0;index < CloudBusinessShared.CloudDataSourceList.length;index ++ ){
        if(CloudBusinessShared.CloudDataSourceList[index][filedkey] == value){
            return CloudBusinessShared.CloudDataSourceList[index];
        }
    }
    return null;
};


module.exports.GetTcpClient  = function (filedkey,value){
    //console.log("CloudBusinessShared调用了一次 GetTcpClient!");


    for(var index = 0;index < CloudBusinessShared.TcpClientList.length;index ++ ){
        if(CloudBusinessShared.TcpClientList[index][filedkey] == value){
            return CloudBusinessShared.TcpClientList[index];
        }
    }
    return null;
};


module.exports.TcpClientACKTimeRepair = function(){
    console.log("CloudBusinessShared调用了一次 TcpClientACKTimeRepair!");

    Runlog.WriteLog("CloudBusinessShared","进入 TcpClientACKTimeRepair 函数,开始维护TcpClient的ACKTime信息(对于已休眠的云平台客户端进行关停)!");

    while(true){
        var success = false;

        for(var index = 0;index < CloudBusinessShared.TcpClientList.length;index ++ ){
            try{
              //  console.log( "ClientID:" + CloudBusinessShared.TcpClientList[index]["Id"] +"的ACKTime:"+ CloudBusinessShared.TcpClientList[index]["ACKTime"].toString());
                //剔除无效的HTTPContext内容项。
                var clientAckTime = CloudBusinessShared.TcpClientList[index]["ACKTime"];
                var CurrentDateTime = new Date();
                if((CurrentDateTime - clientAckTime ) /1000 >= Config.BusinessCloudServiceConfig.CloudServerACKCheckTimeOut ){
                    var clientID = CloudBusinessShared.TcpClientList[index]["Id"];
                    //删除该客户所有的命令连接
                    CloudBusinessShared.ClearCommandConnection(clientID);
                    if(Config.BusinessCloudServiceConfig.DebugMode) {
                        Runlog.WriteLog("CloudBusinessShared","已清除ClientID为:"+ clientID +" 的所有的命令连接!");
                    }

                    try{
                        CloudBusinessShared.TcpClientList[index]["Instance"].destroy();
                    }
                    catch(exception){
                    }
                    CloudBusinessShared.TcpClientList.splice(index,1);
                    if(Config.BusinessCloudServiceConfig.DebugMode) {
                        Runlog.WriteLog("CloudBusinessShared","删除了一个TcpClientInstance,目前还有:"+CloudBusinessShared.TcpClientList.length +" Client主连接!");
                    }
                    success = true;
                    break;
                }
            }catch(exception){

            }
        }
        if(!success){
            break;
        }
    }
};


module.exports.TcpClientACKTimeModify = function(instance){
    console.log("CloudBusinessShared调用了一次 TcpClientACKTimeModify!");

    for(var index = 0;index < CloudBusinessShared.TcpClientList.length;index ++ ){
        if(CloudBusinessShared.TcpClientList[index]["Instance"] == instance){
            CloudBusinessShared.TcpClientList[index]["ACKTime"] = new Date();
            return true;
        }
    }
    return false;
};


module.exports.GetBizTemplate = function (filedkey,value){
    console.log("CloudBusinessShared调用了一次 GetBizTemplate!");



    for(var index = 0;index < CloudBusinessShared.CloudBizTemplateList.length;index ++ ){
        if(CloudBusinessShared.CloudBizTemplateList[index][filedkey] == value){
            return CloudBusinessShared.CloudBizTemplateList[index];
        }
    }
    return null;
};

module.exports.GetBizTemplateDataSource = function(filedkey,value,filedKey2,value2){
    console.log("CloudBusinessShared调用了一次 GetBizTemplateDataSource!");


    for(var index = 0;index < CloudBusinessShared.CloudBizTemplateDataSource.length;index ++ ){
        if(CloudBusinessShared.CloudBizTemplateDataSource[index][filedkey] == value && CloudBusinessShared.CloudBizTemplateDataSource[index][filedKey2]== value2){
            return CloudBusinessShared.CloudBizTemplateDataSource[index];
        }
    }
    return null;
};

module.exports.DeleteTcpClient = function (filedkey,value){
    console.log("CloudBusinessShared调用了一次 DeleteTcpClient!");

    for(var index = 0;index < CloudBusinessShared.TcpClientList.length;index ++ ){
        if(CloudBusinessShared.TcpClientList[index][filedkey] == value){
            //CloudBusinessShared.TcpClientList.splice(index);
            CloudBusinessShared.TcpClientList.splice(index, 1);
            return true;
        }
    }
    return false;
};


module.exports.GetCommandConnection = function(filedValue){
    console.log("CloudBusinessShared调用了一次 GetCommandConnection!");

    var returnCommandConnection = [];
    for(var index = 0;index < CloudBusinessShared.TcpCommandConnectionList.length;index ++ ){
        if(CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"] == filedValue){
            returnCommandConnection.push(CloudBusinessShared.TcpCommandConnectionList[index]);
        }
    }
    return returnCommandConnection;
};

//
//module.exports.MonitoringCommandConnection = function(){
//    var date = new Date();
//    console.log( "-------Begin MonitoringCommandConnection AT "+ date.toLocaleDateString() + " "+ date.toLocaleTimeString() +"------" );
//    for(var index = 0;index < CloudBusinessShared.TcpCommandConnectionList.length;index ++ ){
//        console.log( CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"] +"的命令连接号"+index+"的状态为"+CloudBusinessShared.TcpCommandConnectionList[index]["InstanceStatus"] );
//    }
//    console.log( "-------End MonitoringCommandConnection------");
//}



module.exports.GetEffectiveCommandConnection = function(executorControlRuntime){
    var currentQ = Q.defer();
    var Count = 1;
    var period = Config.BusinessCloudServiceConfig.EffectiveCommandPollingTime; //轮询的时间默认为1秒
   var timer = setInterval(function() {
        if(Count >= Config.BusinessCloudServiceConfig.EffectiveCommandPollingCount) //轮询的默认次数为10次
        {
            var retValue = {};
            retValue["CommandConnection"] = null;
            retValue["CurrentInstance"] = executorControlRuntime;
            clearInterval(timer);
            return currentQ.reject(retValue);
        }else{
            for(var index = 0;index < CloudBusinessShared.TcpCommandConnectionList.length;index ++ ){
                if(CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"] == executorControlRuntime["ServerKey"] &&
                        CloudBusinessShared.TcpCommandConnectionList[index]["InstanceStatus"] == "Normal"){
                    CloudBusinessShared.TcpCommandConnectionList[index]["InstanceStatus"] = "Processing";
                    var retValue = {};
                    retValue["CommandConnection"] = CloudBusinessShared.TcpCommandConnectionList[index];
                    retValue["CurrentInstance"] = executorControlRuntime;
                    if(Config.BusinessCloudServiceConfig.DebugMode) {
                        Runlog.WriteLog("CloudBusinessShared","成功返回了:" + CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"] + "的命令连接!");

                    }
                    clearInterval(timer);
                    return currentQ.resolve(retValue);
                }
            }
            Count = Count + 1;
        }
    }, period);
    return currentQ.promise;
};

module.exports.ClearCommandConnection = function(filedValue){
    while(true){
        console.log("CloudBusinessShared调用了一次 ClearCommandConnection!");

        var success = false;
        for(var index = 0;index < CloudBusinessShared.TcpCommandConnectionList.length;index ++ ){
            //剔除无效的命令连接。
            if(CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"] == filedValue){
                try{
                    CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].destroy();
                }
                catch(exception){
                }
                CloudBusinessShared.TcpCommandConnectionList.splice(index,1);
                success = true;
                break;
            }
        }
        if(!success){
            break;
        }
    }
};

//module.exports.MonitorClientTcpEvents = function(){
//    for(var index = 0;index < CloudBusinessShared.TcpClientList.length;index ++ ){
//        var dataEventCount =   CloudBusinessShared.TcpClientList[index]["Instance"].listeners("data").length;
//        var closeEventCount =   CloudBusinessShared.TcpClientList[index]["Instance"].listeners("close").length;
//        var errorEventCount =   CloudBusinessShared.TcpClientList[index]["Instance"].listeners("error").length;
//
//        Runlog.WriteLog("CloudBusinessShared","监控客户端TCP连接事件数,ClientID:" +
//            CloudBusinessShared.TcpClientList[index]["Id"] +
//            "的data监听器个数:"+dataEventCount+",close监听器个数:"+closeEventCount + ",error监听器个数:"+errorEventCount);
//    }
//};

module.exports.MonitorCommandTcpEvents = function(){
    for(var index = 0;index < CloudBusinessShared.TcpCommandConnectionList.length;index ++ ){
        var dataEventCount =   CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].listeners("data").length;
        var closeEventCount =   CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].listeners("close").length;
        var errorEventCount =   CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].listeners("error").length;


        //Runlog.WriteLog("CloudBusinessShared","监控命令连接事件数,ClientID:" +
        //    CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"] +
        //    "的data监听器个数:"+dataEventCount+",close监听器个数:"+closeEventCount + ",error监听器个数:"+errorEventCount);
    }
};

module.exports.SetCommandConnection = function(filedkey,instance){
    console.log("CloudBusinessShared调用了一次 SetCommandConnection!");
    var pushCommandConnectionInstance = {};
    pushCommandConnectionInstance["ClientID"] = filedkey;
    pushCommandConnectionInstance["Instance"] = instance;
    pushCommandConnectionInstance["InstanceStatus"] = "Normal";
    CloudBusinessShared.TcpCommandConnectionList.push(pushCommandConnectionInstance);
};

module.exports.RepairCommandConnection = function(){
    while(true){

        console.log("CloudBusinessShared调用了一次 RepairCommandConnection!");

        var success = false;
        for(var index = 0;index < CloudBusinessShared.TcpCommandConnectionList.length;index ++ ){
            //剔除无效的命令连接。
            if(CloudBusinessShared.TcpCommandConnectionList[index]["Instance"] != null &&
                    CloudBusinessShared.TcpCommandConnectionList[index]["Instance"] != undefined &&
                    !CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].writable){
                try{
                    CloudBusinessShared.TcpCommandConnectionList[index]["Instance"].destroy();
                }
                catch(exception){
                }
                var ClientID = CloudBusinessShared.TcpCommandConnectionList[index]["ClientID"];
                CloudBusinessShared.TcpCommandConnectionList.splice(index,1);
                success = true;
                break;
            }
        }
        if(!success){
            break;
        }
    }
};

//调试变量
module.exports.Debug_CloseModelRouter = false;

