module.exports = (gulp, config) ->

  gulp.task 'assets', ->

    path = require 'path'

    gulp.src ['assets/**'], base: './assets'
      .pipe gulp.dest path.join config.paths.dest, 'assets'
