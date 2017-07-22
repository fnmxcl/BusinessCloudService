/**
 * Created by fnmxcl on 2016/01/06.
 */
var schedule = require("node-schedule");
var CloudBusinessShared = require('../Shared/CloudBusinessShared.js');
var Config = require('../Config/Config');

module.exports.Start = function(){
    var rule = new schedule.RecurrenceRule();
    //设置自动执行分钟判定
    var configMinute =  Config.AutoTaskScheduleConfig.Minute > 0 ? Config.AutoTaskScheduleConfig.Minute>59 ? 59 : Config.AutoTaskScheduleConfig.Minute : 0;
    if(configMinute > 0 ){
        var times = [];
        for(var i= 1; i < 60; i+= configMinute) {
            times.push(i);
        }
        rule.minute = times;
    }
    //设置自动执行秒判定
    var configSecond = Config.AutoTaskScheduleConfig.Second > 0 ? Config.AutoTaskScheduleConfig.Second>59 ? 59 : Config.AutoTaskScheduleConfig.Second : 0;
    if(configSecond > 0 ){
        rule.second = configSecond;
    }
    //TODO: 此自动任务应按具体场景进行划分执行时间。
    var j = schedule.scheduleJob(rule, function(){
        console.log("执行了一次自动任务!");
        CloudBusinessShared.TcpClientACKTimeRepair();
        //CloudBusinessShared.MonitorClientTcpEvents();
        CloudBusinessShared.MonitorCommandTcpEvents();
        CloudBusinessShared.RepairHttpContextInstance();
        CloudBusinessShared.RepairCommandConnection();
    });
};