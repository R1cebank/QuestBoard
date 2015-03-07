module.exports = (gulp, config) ->

  gulp.task 'watch', ->

    gulp.watch ['src/**/*.coffee', 'src/**/*.js'], ['scripts']
    gulp.watch ['src/**/*.less', 'src/**/*.css'], ['styles']
    gulp.watch ['src/**/*.jade', 'src/**/*.html'], ['markup']
    gulp.watch ['assets/**/*'], ['assets']
    
