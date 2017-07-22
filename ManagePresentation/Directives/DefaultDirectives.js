/**
 * Created by fnmxcl on 2016/04/29.
 */
main.directive('setFocus', function(){
    return function(scope, element){
        element[0].focus();
    };
});