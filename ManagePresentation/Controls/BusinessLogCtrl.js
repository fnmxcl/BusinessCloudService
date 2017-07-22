/**
 * Created by fnmxcl on 2016/04/01.
 */
//define([],function(){

main.controller("BusinessLogCtrl",BusinessLogCtrl);
BusinessLogCtrl.$inject = ['$scope', '$http', 'CloudAccessService','$modal','$state','ValidationService'];
function BusinessLogCtrl($scope, $http, CloudAccessService,$modal,$state,ValidationService) {
    //if(ValidationService.UserInfo.UserName == undefined || ValidationService.UserInfo.UserName == null ){
    //    $state.go("login");
    //}
    $scope.ToHome = ToHome;

    $scope.onClick = function (points, evt) {
        console.log(points, evt);
    };
    function ToHome(){
        $state.go("main");
    }
};

