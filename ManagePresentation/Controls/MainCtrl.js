/**
 * Created by fnmxcl on 2016/04/01.
 */
//define([],function(){

    main.controller("MainCtrl",MainCtrl);
    MainCtrl.$inject = ['$scope', '$http', 'CloudAccessService','$modal','$state','ValidationService','Popup','RefreshModelService'];
    function MainCtrl($scope, $http, CloudAccessService,$modal,$state,ValidationService,Popup,RefreshModelService) {
            //if(ValidationService.UserInfo.UserName == undefined || ValidationService.UserInfo.UserName == null  ){
            //    $state.go("login");
            //}
        //注册函数
        $scope.ToBusinessLog = ToBusinessLog;
        $scope.SetCloudPlatformParams = SetCloudPlatformParams;
        $scope.RefreshCloudInfo = RefreshCloudInfo;
        $scope.UserDestory = UserDestory;
        $scope.CloseDialog = CloseDialog;
        $scope.PopupPressOK = PopupPressOK;
        $scope.CloseDurationPopup = CloseDurationPopup;
        $scope.FilterContent = "";


        $scope.CloudServerRunParams = [];
        $scope.CommandList_RefreshTime = 3;
        $scope.CommandList_RefreshButtonNotify = "点击自动刷新("+ $scope.CommandList_RefreshTime +"秒/次)";
        $scope.CommandList_RefreshFlag = false; //True 标识为启用了自动出刷新 ,False:停止了自动刷新
        $scope.CommandList_interval = null;
        $scope.UserInfo = ValidationService.UserInfo;
        $scope.labels = [];
        $scope.series = ['当前通道数', '正在运行'];
        $scope.data = [[],[]];
        $scope.Popup = {
            PopupShow : false,
            PopupTitle : "消息",
            PopupKey : "Default",
            PopupContent :"提示消息",
            Sender:{}
        };

        $scope.Memory_Instance = {};
        $scope.Memory_Instance.heapTotal = "0MB";
        $scope.Memory_Instance.heapUsed = "0MB";
        $scope.Memory_Instance.Rss = "0MB";

        $scope.DurationPopup = {
            PopupShow : false,
            PopupTitle : "消息",
            PopupKey : "Default",
            PopupContent :"提示消息"
        };

        $scope.$watch('FilterContent',function(newValue,oldValue, scope){
            if(newValue){
                $scope.CommandList_RefreshFlag = false;
                $scope.CommandList_RefreshButtonNotify = "点击自动刷新("+ $scope.CommandList_RefreshTime +"秒/次)";
                clearInterval($scope.CommandList_interval);
                $scope.CommandList_interval = null;
                filterClouadInfo();


            }else{
                if(!$scope.CommandList_interval){
                    RefreshCloudInfo();
                }
            }
        });

        //筛选模式
        function filterClouadInfo(){
            CloudAccessService.MonitoringCloudClient().then(function(data){
                $scope.gridOptions = { data: []};
                $scope.labels = [];
                $scope.data = [[],[]];
                if(data && data.length > 0){
                    for(var index = 0 ;index < data.length ;index ++ ){
                        if(data[index]["ClientName"].indexOf($scope.FilterContent) >=0){
                            $scope.gridOptions.data.push(data[index]);
                            $scope.labels.push(data[index]["ClientName"]);
                            $scope.data[0].push(data[index]["CommandNumber"]);
                            $scope.data[1].push(data[index]["OperationChannel"]);
                        }
                    }
                }
            },function(error){

                if(error.Message == "身份无效"){
                    //alert(JSON.stringify(error.Message));
                    clearInterval($scope.CommandList_interval);
                    $state.go("login");
                }else{
                    console.log("call RefreshCloudInfo:"+JSON.stringify(error));
                }

            });
        }

        $scope.gridOptions = { data: [],
            columnDefs: [{ field: 'Id', displayName: '客户端编号',width: "30%"  },
                { field: 'ClientName', displayName: '单位',width: "20%"  },
            { field: 'ConnectionTime', displayName: '创建时间' },
            { field: 'ACKTime', displayName: 'ACK时间'},
                { field: 'CommandNumber', displayName: '总通道数'},
                { field: 'OperationChannel', displayName: '正在使用'},
                {name:' ',cellTemplate:'<div><a href=""  ng-click="grid.appScope.toggle(row)">刷新模型</a></div>'}
            ],
            paginationPageSizes:[10,50,100]
            //rowsPerPage:15,
            //enableScrollbars:false
            //rowTemplate: '<div ng-style="{ 'cursor': row.cursor }" ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell {{col.cellClass}}"><div class="ngVerticalBar" ng-style="{height: rowHeight}" ng-class="{ ngVerticalBarVisible: !$last }">&nbsp;</div><div ng-cell></div></div>'
        };

        $scope.toggle = function(row) {
            ShowTip("重启云平台客户端","您是否要重新刷新客户名为: '"+row.entity.ClientName +"' 的云平台客户端?","RefreshModel",row);
            //ngDialog.open({template:'views/Test.html',className:'ngdialog-theme-plain',scope:$scope});

            //$scope.MSQList =[];
            //$scope.ErrorTip = "";
            //$scope.ShowMsq = true;
            //$scope.Title = { Text:( row.entity.NickName !==undefined ? row.entity.NickName: row.entity.DeviceId)  + "的消息" };
            //$scope.CurrentSelectRow = row;
            //new MessagePageInit();
            //callServiceFunction($scope.CurrentSelectRow, $scope.MessagePage);
            //if(confirm('您确定要删除吗？')){
            //    alert('点击了刷新模型!');
            //}
        };


        function refreshPlatformInfo(){
            CloudAccessService.GetPlatformInformation().then(function(platformInfo){
                $scope.Memory_Instance.heapTotal =  platformInfo[0].Property[0].Value;
                $scope.Memory_Instance.heapUsed = platformInfo[0].Property[1].Value;
                $scope.Memory_Instance.Rss =   platformInfo[0].Property[2].Value;
            },function(error){
                if(error.Message == "身份无效"){
                    //alert(JSON.stringify(error.Message));
                    $state.go("login");
                }else{
                    console.log(JSON.stringify(error));
                }
            });
        }

        function CloseDialog(){
            $scope.Popup.PopupShow = false;
        }

        function PopupPressOK(envent){
            $scope.Popup.PopupShow = false;
            RefreshModelService.RefreshModel($scope.Popup.Sender.entity.Id).then(function(data){
                //调用是刷新的服务。
                ShowDurationTip(null,"已返回信息:"+"命令类型:"+data.PackageType + "    状态:"+data.Status);
            },function(error){
                ShowDurationTip(null,error);
            });

        }

        function ShowTip(Title,Content,Key,sender){
            if(Title){
                $scope.Popup.PopupTitle = Title;//"重启云平台客户端";
            }
            if(Content){
                $scope.Popup.PopupContent = Content;//"您是否要重新刷新客户名为: '"+row.entity.ClientName +"' 的云平台客户端?";
            }
            if(Key){
                $scope.Popup.PopupKey = Key;//"RefreshModel";
            }
            if(sender){
                $scope.Popup.Sender = sender;
            }
            $scope.Popup.PopupShow = true;

        }

        function ShowDurationTip(Title,Content,Key){
            if(Title){
                $scope.DurationPopup.PopupTitle = Title;//"重启云平台客户端";
            }
            if(Content){
                $scope.DurationPopup.PopupContent = Content;//"您是否要重新刷新客户名为: '"+row.entity.ClientName +"' 的云平台客户端?";
            }
            if(Key){
                $scope.DurationPopup.PopupKey = Key;//"RefreshModel";
            }
            $scope.DurationPopup.PopupShow = true;
        }

        function CloseDurationPopup(){
            $scope.DurationPopup.PopupShow = false;
        }



        refreshData();
        function refreshData() {
            CloudAccessService.GetCloudPlatformParams().then(function(data){
                var paramStruct = [];
                for (var item in data) {
                    //if(item !="ParamsComment"){
                        var currentParam = {};
                        currentParam["ParamKey"] = item;
                        currentParam["ParamValue"] = data[item];
                        for(var item in data.ParamsComment){
                            if(item == currentParam["ParamKey"]){
                                currentParam["Discription"] = data.ParamsComment[item];
                            }
                        }
                        paramStruct.push(currentParam);
                    //}
                }
                $scope.CloudServerRunParams = paramStruct;
            },function(error){
                if(error.Message == "身份无效"){
                    //alert(JSON.stringify(error.Message));
                    $state.go("login");
                }else{
                    console.log(JSON.stringify(error));
                }
            });
            RefreshCloudInfo();
        }


        function SetCloudPlatformParams(control) {
            if(control){
                control.target.innerText = "正在保存参数并重启云服务...";
            }
            CloudAccessService.SetCloudPlatformParams($scope.CloudServerRunParams).then(function(data){
                var aaa = data;
                control.target.innerText = "保存参数并重启云平台";
            },function(error){
                if(error.Message == "身份无效"){
                    //alert(JSON.stringify(error.Message));
                    $state.go("login");
                }else{
                    console.log(JSON.stringify(error));
                }
            });
        }
        //刷新云平台信息
        function RefreshCloudInfo(control){
            //var that = this;
            //that.ClientName = control;
            if($scope.CommandList_RefreshTime == undefined || $scope.CommandList_RefreshTime ==null ||  !($scope.CommandList_RefreshTime % 1 === 0)){
                $scope.CommandList_RefreshTime = 3;
            }
            if( ! $scope.CommandList_RefreshFlag){
                $scope.CommandList_RefreshFlag = true;
                $scope.CommandList_RefreshButtonNotify = "自动刷新中(点击停止)";
                $scope.CommandList_interval = setInterval(function() {

                    //刷新取值云平台内存信息
                    refreshPlatformInfo();

                    CloudAccessService.MonitoringCloudClient().then(function(data){
                        $scope.gridOptions = { data: data};
                        $scope.labels = [];
                        $scope.data = [[],[]];
                        if(data && data.length > 0){
                            for(var index = 0 ;index < data.length ;index ++ ){
                                $scope.labels.push(data[index]["ClientName"]);
                                $scope.data[0].push(data[index]["CommandNumber"]);
                                $scope.data[1].push(data[index]["OperationChannel"]);
                            }
                        }
                    },function(error){

                        if(error.Message == "身份无效"){
                            //alert(JSON.stringify(error.Message));
                            clearInterval($scope.CommandList_interval);
                            $state.go("login");
                        }else{
                            console.log("call RefreshCloudInfo:"+JSON.stringify(error));
                        }

                    });
                }, $scope.CommandList_RefreshTime * 1000);
            }else{
                $scope.CommandList_RefreshFlag = false;
                $scope.CommandList_RefreshButtonNotify = "点击自动刷新("+ $scope.CommandList_RefreshTime +"秒/次)";
                clearInterval($scope.CommandList_interval);
                $scope.CommandList_interval = null;
            }
        }

        $scope.$on("$destroy", function() {
            //清除配置
            $scope.CloudServerRunParams = [];
            $scope.CommandList_RefreshTime = 3;
            $scope.CommandList_RefreshButtonNotify = "点击自动刷新("+ $scope.CommandList_RefreshTime +"秒/次)";
            $scope.CommandList_RefreshFlag = false; //True 标识为启用了自动出刷新 ,False:停止了自动刷新
            clearInterval($scope.CommandList_interval);
            $scope.CommandList_interval = null;
        });

        function UserDestory(){
            ValidationService.UserInfo = {};
            $state.go("login");
        }

        //
        //
        //$scope.items = [ 'angularjs', 'backbone', 'canjs', 'Ember', 'react' ];
        //// open click
        //$scope.open = function(size) {
        //    var modalInstance = $modal.open({
        //        templateUrl : '../views/ModelPop.html',
        //        controller : 'ModalInstanceCtrl', // specify controller for modal
        //        size : size,
        //        resolve : {
        //            items : function() {
        //                return $scope.items;
        //            }
        //        }
        //    });
        //    // modal return result
        //    modalInstance.result.then(function(selectedItem) {
        //        $scope.selected = selectedItem;
        //    }, function() {
        //        $log.info('Modal dismissed at: ' + new Date())
        //    });
        //}
        //跳转到日志界面
        function ToBusinessLog(){
            $state.go("log");
        }

    };

//
//main.controller("ModalInstanceCtrl",function($scope, $modalInstance, items) {
//    $scope.items = items;
//    $scope.selected = {
//        item : $scope.items[0]
//    };
//    // ok click
//    $scope.ok = function() {
//        $modalInstance.close($scope.selected.item);
//    };
//    // cancel click
//    $scope.cancel = function() {
//        $modalInstance.dismiss('cancel');
//    }
//});
