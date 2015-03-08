angular.module 'Questboard.web.session', []
.service 'QbSession', ($localStorage, $rootScope) ->

  @create = (email, token, remember) ->
    @token = token
    @isGuest = no
    $rootScope.loggedIn = yes
    if remember
      $localStorage.token = token
      $localStorage.email = email

  @guest = ->
    @token = null
    @isGuest = yes
    $rootScope.loggedIn = yes

  @destroy = ->
    @token = null
    $localStorage.token = null
    $rootScope.loggedIn = no

  return @
