server = require 'gulp-server-livereload'

module.exports = (gulp, config) ->

  gulp.task 'server', ->

    gulp.src './dist'
      .pipe server livereload: yes, directoryListing: no

    gulp.watch ['src/**/*.coffee', 'src/**/*.js'], ['scripts']
    gulp.watch ['src/**/*.less', 'src/**/*.css'], ['styles']
    gulp.watch ['src/**/*.html'], ['html']
    gulp.watch ['src/**/*.jade'], ['jade']
    gulp.watch ['assets/**/*'], ['assets']
