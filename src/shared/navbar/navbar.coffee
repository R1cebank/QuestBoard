angular.module 'Questboard.web.shared.navbar', []
.controller 'NavbarController', ($scope, $state, QbSession) ->

  $scope.user = -> QbSession.user

  $scope.logout = ->
    QbSession.destroy()
    $state.go 'login'
