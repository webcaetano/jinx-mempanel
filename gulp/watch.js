'use strict';

var gulp = require('gulp');
var jinxCompiler = require('gulp-jinx-compiler');
var browserSync = require('browser-sync');
var path = require('path');
var through = require('through2');

function isOnlyChange(event) {
	return event.type === 'changed';
}

module.exports = function(options) {
	gulp.task('watch', ['scripts:watch'], function () {

		gulp.watch([options.src + '/*.html', 'bower.json'],function(){
			gulp.start('inject',function(){
				browserSync.reload();
			});
		});

		gulp.watch(options.src + '/{app,components}/**/*.html', function(event) {
			browserSync.reload(event.path);
		});
	});

	gulp.task('build', function () {
		var mainFile = path.join(options.src,'app/test.jinx');
		return gulp.src(mainFile)
		.pipe(jinxCompiler(options.src+'/app/flash/dist',{
			'library-path': [
				'lib'
			]
		}))
	});

	gulp.watch([options.src + '/app/**/*.{as,swc,jinx}','index.jinx'], function(event) {
		gulp.start('build',function(){
			browserSync.reload(event.path);
		});
	});
};
