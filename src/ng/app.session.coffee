angular.module 'Questboard.web.session', []
.service 'QbSession', ($localStorage) ->

  @create = (email, token, remember) ->
    @token = token
    if remember
      $localStorage.token = token
      $localStorage.email = email

  @destroy = ->
    @token = null
    $localStorage.token = null

  return @
