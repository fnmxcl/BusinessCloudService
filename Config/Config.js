var fs = require('fs');
var MainConfig = JSON.parse(fs.readFileSync('./Config/BusinessCloudServiceConfig.json').toString().trim());
//后台数据服务相关配置
var DataService = MainConfig.DataService;
DataService.RemoteServerURL = "http://" + DataService.Address + ":" + DataService.Port;
//云服务平台配置
var BusinessCloudServiceConfig = MainConfig.BusinessCloudServiceConfig;
var AutoTaskScheduleConfig = MainConfig.AutoTaskScheduleConfig;
var ManageUserConfig = MainConfig.ManageUserConfig;

module.exports.BusinessCloudServiceConfig = BusinessCloudServiceConfig;
module.exports.AutoTaskScheduleConfig = AutoTaskScheduleConfig;
module.exports.DataService = DataService;
module.exports.ManageUserConfig = ManageUserConfig;
