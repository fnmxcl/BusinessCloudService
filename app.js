/**
 * Created by fnmxcl on 2015/12/1.
 */
var domain = require('domain');
var BusinessCloudService = require('./Service/BusinessCloudService.js');
var businessLog = require('./Service/BusinessLog.js');

process.on('uncaughtException', function (err) {
    businessLog.WriteLog("Application",err);
});
//捕获模块中未处理的异常，防止进程终端
var d = domain.create();
d.on('error', function (err) {
    console.log(err);
});
d.run(start);
function start() {
    BusinessCloudService.Start();//启动云平台业务系统
}
