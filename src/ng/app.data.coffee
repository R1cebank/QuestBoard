angular.module 'Questboard.web.data', []
.service 'QbData', ($localStorage, QbClient, QbSession) ->

  @login = (params) ->
    QbClient.request('login', _.pick params, 'email', 'password')
      .success (data) ->
        QbSession.create(params.email, data.token, params.remember)
        alert('Success')


  @getLastUser = -> $localStorage.email ? ''
  
  return @
