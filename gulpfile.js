/**
 * Created by fnmxcl on 2016/09/05.
 */
var minifycss = require('gulp-minify-css'); // CSS压缩
var uglify = require('gulp-uglify');        // js压缩
var concat = require('gulp-concat');        // 合并文件
var rename = require('gulp-rename');        // 重命名
var clean = require('gulp-clean');          //清空文件夹
var gulp = require('gulp');
var del = require('del');
var vinylPaths = require('vinyl-paths');
var sourcemaps = require('gulp-sourcemaps');


gulp.task('default', ['del-dir','clean-scripts'],function() {
    // 将你的默认的任务代码放在这
   return gulp.src('./ManagePresentation/**/*.js') // 匹配 'client/js/somedir/somefile.js' 并且将 `base` 解析为 `client/js/`
        .pipe(uglify( {
            sourceMap: true,
            mangle: false, //混淆变量名
            preserveComments: 'false', //删除注释，还可以为 false（删除全部注释），some（保留@preserve @license @cc_on等注释）
        }))
        .pipe(sourcemaps.init({loadMaps: true}))
        .pipe(sourcemaps.write("."))
        .pipe(gulp.dest('./ManagePresentation/JsBuild/'));  // 写入 'build/somedir/somefile.js'
});

gulp.task('clean-scripts',function () {
    return gulp.src('./ManagePresentation/JsBuild/*.js', {read: false})
        .pipe(clean({force: true}));
});

gulp.task('del-dir', function () {
    return gulp.src('./ManagePresentation/JsBuild/', {read: false})
        .pipe(vinylPaths(del));
});