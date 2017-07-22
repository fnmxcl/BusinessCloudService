    /**
     * Created by fnmxcl on 2016/04/14.
     */
//require.config({
//    paths: {
//        "jquery":  "../lib/jquery/dist/jquery",
//        // angular
//        "angular": "../lib/angular/angular",
//        "angular-ui-grid":"../lib/angular-ui-grid/ui-grid.min",
//        "bootstrap":"../lib/bootstrap/dist/js/bootstrap.min",
//        "ng-grid-debug":"../lib/ng-grid/build/ng-grid.debug",
//        // angular-ui
//        "angular-ui-router": "../lib/angular-ui-router/release/angular-ui-router.min",
//        "ngAnimate":"../lib/ngAnimate/js/angular-animate.min",
//        // angularAMD
//        "angularAMD": "../lib/angularAMD/angularAMD",
//        "ngload": "../lib/angularAMD//ngload"
//    }
//    ,
//    shim: {
//        'angular': {
//            exports: 'angular',
//            deps: ['jquery']
//        },
//        "angular-ui-grid": ['angular'],
//
//        'angular-ui-route': ['angular'],
//        'ng-grid-debug':['angular'],
//        'bootstrap': ['jquery'],
//        "angularAMD": ["angular"],
//        "ngAnimate":["angular" ,"angular-ui-route"],
//        "ngload": ["angularAMD"]
//    }
//});

//define(["angular","angularAMD","ngload"], function (angular,angularAMD,ngload) {
//        window.angularAMD = angularAMD;
    var main = angular.module('Business.MainApp', ['angular-popups', 'chart.js', 'ngGrid', 'ui.grid',
        'ui.grid.i18n',
        'ui.grid.selection',
        'ui.grid.grouping',
        'ui.grid.exporter',
        'ui.grid.pagination',
        'ui.grid.resizeColumns',
        'ui.grid.autoResize', 'ngAnimate', 'ui.router', 'ui.bootstrap']);

//
//(function (ChartJsProvider) {
//    ChartJsProvider.setOptions({ colours : [ '#803690', '#00ADF9', '#DCDCDC', '#46BFBD', '#FDB45C', '#949FB1', '#4D5360'] });
//});

    main.config(function (PopupProvider) {
        PopupProvider.title = '提示';
        PopupProvider.okValue = '确定';
        PopupProvider.cancelValue = '取消';
    });

    main.run(stateModifyProcess);
    stateModifyProcess.$inject = ['$rootScope', 'ValidationService', '$location'];
    function stateModifyProcess($rootScope, ValidationService, $location) {
        //alert('123');
        //$rootScope.$on('$routeChangeStart', function(evt, next, current) {
        //    // 如果用户未登录
        //    //if (!AuthService.userLoggedIn()) {
        //    //}
        //
        //})
        $rootScope.$on('$stateChangeStart',
            function (evt, toState, roParams, fromState, fromParams) {
                // 可以阻止这一状态完成       evt.preventDefault();
                //alert('456');
                if (ValidationService.UserInfo.UserName == undefined || ValidationService.UserInfo.UserName == null) {
                    $location.path("/login");
                }

            });
    };

    main.config(function ($stateProvider, $urlRouterProvider) {
        $stateProvider.state('login', {
                url: '/login',
                templateUrl: 'views/login.html',
                controller: 'LoginCtrl'
            })
            // route to show our basic form (/form)
            .state('main', {
                url: '/main',
                templateUrl: 'views/main.html',
                controller: 'MainCtrl'
            }).state('log', {
            url: '/log',
            templateUrl: 'views/businessLog.html',
            controller: 'BusinessLogCtrl'
        });
        // catch all route
        // send users to the form page
        $urlRouterProvider.otherwise('login');
    });
//
//        return angularAMD.bootstrap(main);
//    }
//);