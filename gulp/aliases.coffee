module.exports = (gulp, config) ->

  gulp.task 'default', ['scripts', 'styles', 'html', 'jade', 'bower']

  gulp.task 'bower', ['bower:scripts', 'bower:styles', 'bower:fonts']
