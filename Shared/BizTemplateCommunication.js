/**
 * Created by fnmxcl on 2015/12/7.
 */
var CloudBusinessShared = require('./../Shared/CloudBusinessShared.js');
var mPackageSystem = require('./../Shared/BinaryPackage.js');
var async = require('async');

var BizTemplateCommunication  = function BizTemplateInstance(sessionID,tcpCient,res,bizTemplateParams){
    this.Client = tcpCient;
    this.SessionID = sessionID;
    this.Response = res;
    this.BizTemplateParams = bizTemplateParams;
    this.exBuffer = new mPackageSystem().uint32Head().littleEndian();
}

BizTemplateCommunication.prototype.SendMessage = function(bizTemplate){

    if (this.Client.listeners("data") != null &&
        this.Client.listeners("data") != undefined &&
        this.Client.listeners("data").length > 0) {

        for (var index = 0; index < this.Client.listeners("data").length; index++) {
            this.Client.removeListener("data", this.Client.listeners("data")[index]);
        }
    }

    var modifyJSONValue = JSON.parse(this.BizTemplateParams);
    modifyJSONValue["bizTemplateName"] = bizTemplate;

    this.BizTemplateParams = JSON.stringify(modifyJSONValue)

    var charsLength = Buffer.byteLength(this.BizTemplateParams, "UTF-8");
    var calcBuffer = new Buffer(4);
    calcBuffer[0] = (charsLength & 0x000000FF);
    calcBuffer[1] = ((charsLength >> 8) & 0x000000FF);
    calcBuffer[2] = ((charsLength >> 16) & 0x000000FF);
    calcBuffer[3] = ((charsLength >> 24) & 0x000000FF);



    //发送头信息只包含本条信息的数据长度
    //发送正文信息（发送正文信息包含需要查询的模版内容等）
    var sendFlag = this.Client.write(calcBuffer);
    if (sendFlag) {
        this.Client.write(this.BizTemplateParams);
    }
    onData(this);
    onReceive(this);
}

function onData(thisInstance){
    thisInstance.Client.on("data",function(data){
        thisInstance.exBuffer.put(data);//只要收到数据就往ExBuffer里面put
    });
}

function onReceive(thisInstance){
    thisInstance.exBuffer.on('data',function(data){
        var receive_data=data.toString();
        //console.log(receive_data);
        if(receive_data)
        {
            try
            {
                var returnStr = JSON.parse(receive_data);
                returnStr["CloudLogId"] = 12315001;
                thisInstance.Response.send(returnStr);
            }catch(exception){
                console.log("response.send,ERROR:"+exception);
            }
        }
    });
}

exports.BizTemplateCommunication = BizTemplateCommunication;
