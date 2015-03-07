
module.exports = (gulp, config) ->

  gulp.task 'scripts', ->

    # add the necessary dependencies
    path = require 'path'
    lint = require 'gulp-coffeelint'
    addsrc = require 'gulp-add-src'
    gulpif = require 'gulp-if'
    concat = require 'gulp-concat'
    coffee = require 'gulp-coffee'
    uglify = require 'gulp-uglify'
    plumber = require 'gulp-plumber'
    sourcemaps = require 'gulp-sourcemaps'
    ngAnnotate = require 'gulp-ng-annotate'

    # gather all coffeescript source files in /app/...
    gulp.src ['src/**/*.coffee'], base: './src'

      # handle and prevent crashes
      .pipe plumber()

      # check for script mistakes
      .pipe lint()
      .pipe lint.reporter()

      # compile coffescript source
      .pipe sourcemaps.init()
      .pipe coffee()

      # add javascript files to bundle
      .pipe addsrc('src/**/*.js')

      # bring everything together with index.js (concat)
      .pipe gulpif config.concat, concat 'index.js'

      # Angular.js annotations pre-processing...
      .pipe ngAnnotate add: yes, remove: yes, single_quotes: yes

      # Parse js files and make them "nicer" (Uglify)
      .pipe gulpif config.minify, uglify()

      # write out product
      .pipe gulpif config.sourcemaps, sourcemaps.write()
      .pipe gulp.dest path.join config.paths.dest
