angular.module 'Questboard.web.views.home', [
  'Questboard.web.views.home.post-detail'
]
.controller 'HomeController', ($scope, snapRemote, QbSession, QbData) ->

  snapRemote.disable()

  QbSession.guest()
  QbData.loadUserData()

  $scope.tasks = -> QbData.posts

  $scope.openDrawer = ->
    snapRemote.toggle('right')

  undefined
