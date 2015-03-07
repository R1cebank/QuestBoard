angular.module 'Questboard.web.views.home', []
.controller 'HomeController', ($scope, snapRemote, QbSession, QbData) ->

  snapRemote.disable()

  QbSession.guest()
  QbData.loadUserData()

  $scope.tasks = -> QbData.tasks

  $scope.openDrawer = ->
    snapRemote.toggle('right')

  undefined
