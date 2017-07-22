/* 以下为SBE.AppFrame方面引用。--------------------------------------------------------------------------*/
var APPModelManage = require("SBE.AppFrame/Model/ModelManage/APPModelManage");
var path = require('path');

function Start(){
    console.log("调用编译EPP环境开始");
    var beginTime = new Date();
    var APPModelPath = path.join(__dirname,"./../ModelAppFiles");
    var compiledModelPath = path.join(__dirname,"./../Data/");
    APPModelManage.compile(APPModelPath,compiledModelPath).then(function(data){
        global.process.exit(0);
    },function(error){
        console.error(error);
        console.error(error.stack);
    });
}
module.exports.Start = Start;