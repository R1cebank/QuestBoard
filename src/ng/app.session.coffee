angular.module 'Questboard.web.session', []
.service 'QbSession', ($localStorage, $rootScope) ->

  @create = (email, token, remember) ->
    @token = token
    $rootScope.loggedIn = yes
    if remember
      $localStorage.token = token
      $localStorage.email = email

  @guest = ->
    @token = null
    $rootScope.loggedIn = yes

  @destroy = ->
    @token = null
    $localStorage.token = null
    $rootScope.loggedIn = no

  return @
