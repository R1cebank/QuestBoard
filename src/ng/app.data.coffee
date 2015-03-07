angular.module 'Questboard.web.data', []
.service 'QbData', ($q, $localStorage, QbClient, QbSession) ->

  @login = (params) ->
    if params
      QbClient.request('login', _.pick params, 'email', 'password')
        .success (data) ->
          QbSession.create(params.email, data.token, params.remember)
    else
      QbSession.guest()

  @getLastUser = -> $localStorage.email ? ''

  return @
