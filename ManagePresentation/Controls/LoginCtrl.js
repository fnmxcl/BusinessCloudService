/**
 * Created by fnmxcl on 2016/04/27.
 */
main.controller("LoginCtrl",LoginCtrl);
LoginCtrl.$inject = ['$scope', '$http', 'CloudAccessService','$modal','$state','ValidationService',"$state"];
function LoginCtrl($scope, $http, CloudAccessService,$modal,$state,ValidationService){
    $scope.LoginInfo = {"UserName":"","PassWord":""};
    $scope.Login = Login;
    $scope.ErrorInfo = "";
    function Login(){
        $scope.Show = true;

        $scope.ErrorInfo = "";
        var a =  $scope.LoginInfo;
        ValidationService.CheckLogin($scope.LoginInfo).then(function(data){
            if(data.LoginInfo){
                ValidationService.UserInfo = data.LoginInfo;
                $state.go("main");
            }else{
                $scope.ErrorInfo = data.Message;
            }
        },function(err){
            if(err.Message){
                $scope.ErrorInfo = err.Message;
            }else{
                $scope.ErrorInfo = err
            }

        });
    }
};