/**
 * Created by fnmxcl on 2016/04/15.
 */





main.factory("CloudAccessService", CloudAccessService);
CloudAccessService.$inject = ["$http", "$location", '$q'];
function CloudAccessService($http, $location, $q) {
    var baseAddress = "http://" + $location.$$host + ":" + $location.$$port;
    return {
        GetCloudPlatformParams: function () {
            var d = $q.defer();
            var url = baseAddress + "/WebSiteAccess/GetCloudPlatformParams";
            $http({
                url: url,
                dataType: 'JSONP',
                method: 'GET'

            }).success(function (data, header, config, status) {
                if (data) {
                    d.resolve(data);
                }
            }).error(function (data, header, config, status) {
                //出现错误
                d.reject(data);
            });
            return d.promise;
        },
        MonitoringCloudClient:function () {
            var d = $q.defer();
            var url = baseAddress + "/WebSiteAccess/MonitoringCloudClient";
            $http({
                url: url,
                dataType: 'JSONP',
                method: 'GET'

            }).success(function (data, header, config, status) {
                if (data) {
                    d.resolve(data);
                }
            }).error(function (data, header, config, status) {
                //出现错误
                d.reject(data);
            });
            return d.promise;
        },
        SetCloudPlatformParams:function(params){
            var d = $q.defer();
            var url = baseAddress + "/WebSiteAccess/SetCloudPlatformParams";
            $http({
                url: url,
                dataType: 'JSONP',
                method: 'GET',
                params: {
                    request: JSON.stringify(params)
                }

            }).success(function (data, header, config, status) {
                if (data) {
                    d.resolve(data);
                }
            }).error(function (data, header, config, status) {
                //出现错误
                d.reject(data);
            });
            return d.promise;
        },
        GetPlatformInformation:function(){
            var d = $q.defer();
            var url = baseAddress + "/WebSiteAccess/GetPlatformInformation";
            $http({
                url: url,
                dataType: 'JSONP',
                method: 'GET'
                //,
                //params: {
                //    request: JSON.stringify(params)
                //}

            }).success(function (data, header, config, status) {
                if (data) {
                    d.resolve(data);
                }
            }).error(function (data, header, config, status) {
                //出现错误
                d.reject(data);
            });
            return d.promise;
        }
    };
};


main.factory("ValidationService",ValidationService);
CloudAccessService.$inject = ["$http", "$location", '$q'];
function ValidationService($http, $location, $q){
    var baseAddress = "http://" + $location.$$host + ":" + $location.$$port;
    return{
        CheckLogin:function(loginInfo){
            var d = $q.defer();
            var url = baseAddress + "/WebSiteAccess/Login";
            $http({
                url: url,
                dataType: 'JSONP',
                method: 'GET',
                params: {
                    request: JSON.stringify(loginInfo)
                }
            }).success(function (data, header, config, status) {
                if (data.LoginInfo) {
                    //this.UserInfo = data.LoginInfo;
                    d.resolve(data);

                }else{
                    d.reject(data);
                }
            }).error(function (data, header, config, status) {
                //出现错误
                d.reject("登录连接失败!");
            });
            return d.promise;
        },
        UserInfo:{}
    }
};

main.factory("RefreshModelService",RefreshModelService);
RefreshModelService.$inject = ["$http", "$location", '$q'];
function RefreshModelService($http, $location, $q){
    var baseAddress = "http://" + $location.$$host + ":" + $location.$$port;
    return{
        RefreshModel:function(clientID){
            var d = $q.defer();
            var url = baseAddress +"/CloudAPI/ExecuteBizTemplate?client=" +clientID +"&PackageType=UpdateModel";
            $http({
                url: url,
                dataType: 'JSONP',
                method: 'GET'
                //,
                //params: {
                //    request: JSON.stringify(loginInfo)
                //}
            }).success(function (data, header, config, status) {
                if (data) {
                    //this.UserInfo = data.LoginInfo;
                    d.resolve(data);
                }else{
                    d.reject(data);
                }
            }).error(function (data, header, config, status) {
                //出现错误
                d.reject("刷新模型出现异常!");
            });
            return d.promise;
        }
    }
};