angular.module 'Questboard.web', [

  'ui.router'
  'ngStorage'

  'Questboard.api'

  'Questboard.web.shared'
  'Questboard.web.const'
  'Questboard.web.routes'
  'Questboard.web.session'
  'Questboard.web.data'
  'Questboard.web.directives'

  'Questboard.web.views.login'
  'Questboard.web.views.home'

]


.config ($provide) ->
  $provide.decorator '$q', ($delegate) ->
    defer = $delegate.defer
    _when = $delegate.when
    reject = $delegate.reject
    all = $delegate.all
    # Extend promises with non-returning handlers

    decoratePromise = (promise) ->
      promise._then = promise.then

      promise.then = (thenFn, errFn, notifyFn) ->
        p = promise._then(thenFn, errFn, notifyFn)
        decoratePromise p

      promise.success = (fn) ->
        promise.then (value) ->
          fn value
          return
        promise

      promise.error = (fn) ->
        promise.then null, (value) ->
          fn value
          return
        promise

      promise

    $delegate.defer = ->
      deferred = defer()
      decoratePromise deferred.promise
      deferred

    $delegate.when = ->
      p = _when.apply(this, arguments)
      decoratePromise p

    $delegate.reject = ->
      p = reject.apply(this, arguments)
      decoratePromise p

    $delegate.all = ->
      p = all.apply(this, arguments)
      decoratePromise p

    $delegate
  return
