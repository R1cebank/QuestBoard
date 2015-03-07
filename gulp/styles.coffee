module.exports = (gulp, config) ->

  gulp.task 'styles', ->

    path       = require 'path'
    less       = require 'gulp-less'
    addsrc     = require 'gulp-add-src'
    gulpif     = require 'gulp-if'
    concat     = require 'gulp-concat'
    cssmin     = require 'gulp-cssmin'
    plumber    = require 'gulp-plumber'
    autoprefix = require 'gulp-autoprefixer'
    sourcemaps = require 'gulp-sourcemaps'

    gulp.src ['src/**.less', '!**.import.less']

      # Prevent crashes
      .pipe plumber()

      # Begin by compiling .less files
      .pipe sourcemaps.init()
      .pipe less()

      # Add CSS to the stream
      .pipe addsrc 'src/**.css'

      # Add vendor prefixes
      .pipe autoprefix()

      # Concat/minify if needed
      .pipe gulpif config.concat, concat 'index.css'
      .pipe gulpif config.minify, cssmin()

      # Write out
      .pipe gulpif config.sourcemaps, sourcemaps.write()
      .pipe gulp.dest path.join config.paths.dest
