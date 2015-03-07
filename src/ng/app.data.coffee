angular.module 'Questboard.web.data', []
.service 'QbData', ($q, $localStorage, QbClient, QbSession) ->

  self = @

  @login = (params) ->
    if params
      QbClient.request('login', _.pick params, 'email', 'password')
        .success (data) ->
          QbSession.create(params.email, data.data, params.remember)
          self.loadUserData().then -> console.log self.tasks
    else
      QbSession.guest()

  @loadUserData = ->
    promises = { }
    if not QbSession.isGuest
      promises.user = QbClient.request('whoami', token: QbSession.token)
        .then (data) -> QbSession.user = data.data
        .error (error) -> console.log error

    promises.tasks = QbClient.request('queryall')
      .then (data) -> self.tasks = data.data
      .error (error) -> console.log error

    return $q.all(promises)

  @getLastUser = -> $localStorage.email ? ''

  return @
