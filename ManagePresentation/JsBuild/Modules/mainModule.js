function stateModifyProcess($rootScope,ValidationService,$location){$rootScope.$on("$stateChangeStart",function(evt,toState,roParams,fromState,fromParams){void 0!=ValidationService.UserInfo.UserName&&null!=ValidationService.UserInfo.UserName||$location.path("/login")})}var main=angular.module("Business.MainApp",["angular-popups","chart.js","ngGrid","ui.grid","ui.grid.i18n","ui.grid.selection","ui.grid.grouping","ui.grid.exporter","ui.grid.pagination","ui.grid.resizeColumns","ui.grid.autoResize","ngAnimate","ui.router","ui.bootstrap"]);main.config(function(PopupProvider){PopupProvider.title="提示",PopupProvider.okValue="确定",PopupProvider.cancelValue="取消"}),main.run(stateModifyProcess),stateModifyProcess.$inject=["$rootScope","ValidationService","$location"],main.config(function($stateProvider,$urlRouterProvider){$stateProvider.state("login",{url:"/login",templateUrl:"views/login.html",controller:"LoginCtrl"}).state("main",{url:"/main",templateUrl:"views/main.html",controller:"MainCtrl"}).state("log",{url:"/log",templateUrl:"views/businessLog.html",controller:"BusinessLogCtrl"}),$urlRouterProvider.otherwise("login")});
//# sourceMappingURL=mainModule.js.map
