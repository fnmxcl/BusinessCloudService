"use strict";
/**
 * Created by fnmxcl on 2015/11/26.
 */
var uuid = require('node-uuid');
var fs = require('fs');
var fileBaseUrl = './Log/';
var Config = require('../Config/Config');



function WriteLog(type,logcontent,level) {
    var currentDate =  new Date();
    var prefix = "LogType:" + type +" AT Time:"  + currentDate.toLocaleDateString() + " "+ currentDate.toLocaleTimeString() + " >> ";
    if(type == null || type == undefined || type==""){
        type = "undefined";
    }
    if(level == undefined || level == null || level == ""){
        level = "Normal";
    }
    console.log(prefix + logcontent +" \r\n");
    var logFile =   type + currentDate.toLocaleDateString()  +".txt";
    fs.appendFile(fileBaseUrl + logFile, prefix + logcontent +" \r\n",function (err) {
        if(err){
            console.log("BusinessLog Error!");
        }
    });
}

module.exports.WriteLog = WriteLog;