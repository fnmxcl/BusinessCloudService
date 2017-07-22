"use strict";
/**
 * Created by fnmxcl on 2015/11/25.
 */
var express = require('express');
var router = express.Router();
var Runlog = require('../Service/BusinessLog.js');
var CloudBusinessShared = require('./../Shared/CloudBusinessShared.js');
var util = require('./../Shared/util.js');


// GetClientDataSource
router.get('/GetClientDataSource', function(req, res) {
    if(!CloudBusinessShared.Debug_CloseModelRouter){
        var dataSouceTimeOutInstance =  setTimeout(function(){
            let jsonParam =   util.ReadUrlJsonParams(req.url);
            //[SBE_Cloud10].[dbo].[Client] 根据ClinetID 获取模型
            if(req.query["client"] == undefined || req.query["client"] == null || req.query["client"] == ""  ){
                res.status(500).send("client is null" );
                res.end();
                clearTimeout(dataSouceTimeOutInstance);
                return;
            }
            Runlog.WriteLog("CWSModelRouter", "客户端:"+jsonParam.client +" 请求下载模型!" );
            let currentClient = CloudBusinessShared.GetCloudClient("No",req.query["client"]);
            //存在此客户端
            if(currentClient){
                //查找此客户编号对应的数据源信息
                let currentDataSource = CloudBusinessShared.GetDataSource("Id",currentClient["DataSource"] );
                Runlog.WriteLog("CWSModelRouter", "客户端:" + req.query["client"] + "下载数据源成功!");
                var reply = {};
                reply["Model"] = currentDataSource["Model"];
                reply["Database"] = currentClient["Database"];
                reply["ConnectionString"] = currentClient["ConnectionString"];
                res.end(JSON.stringify(reply));
            }
            else{
                res.status(500).send("Can't find client:" + req.query["client"]);
                res.end();
                Runlog.WriteLog("CWSModelRouter",  "Can't find client:" + req.query["client"]);
            }
            clearTimeout(dataSouceTimeOutInstance);
        },1000);
    }else{
        res.status(500).send("Service is Stoped" );
        res.end();
    }
});

router.get('/GetCloudModel', function(req, res) {
    if(!CloudBusinessShared.Debug_CloseModelRouter) {
        var modelTimeOutInstance = setTimeout(function () {
            var DefaultDataSourceModel = null;
            DefaultDataSourceModel = CloudBusinessShared.GetDataSource("IsDefault", true);
            if (DefaultDataSourceModel) {
                res.end(JSON.stringify(DefaultDataSourceModel["Model"]), "UTF-8");
            }
            else if (DefaultDataSourceModel == null) {
                res.end(JSON.stringify(""), "UTF-8");
            }
            clearTimeout(modelTimeOutInstance);
        }, 1000);
    }else{
        res.status(500).send("Service is Stoped" );
        res.end();
    }
});

module.exports = router;
