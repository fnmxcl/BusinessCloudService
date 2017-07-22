/**
 * Created by fnmxcl on 2016/06/15.
 */
/**
 * Created by fnmxcl on 2015/12/1.
 */
var domain = require('domain');
var CompileEppService = require('./Service/CompileEppService.js');

//捕获模块中未处理的异常，防止进程终端
var d = domain.create();
d.on('error', function (err) {
    console.log(err);
});
d.run(start);
function start() {
    CompileEppService.Start();
}
