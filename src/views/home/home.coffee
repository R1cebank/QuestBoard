angular.module 'Questboard.web.views.home', [
  'Questboard.web.views.home.post-detail'
  'Questboard.web.views.home.signup'
]
.controller 'HomeController', ($scope, snapRemote, QbSession, QbData) ->

  snapRemote.disable()

  $scope.tasks = -> QbData.posts

  $scope.openDrawer = ->
    snapRemote.toggle('right')

  $scope.user = -> QbSession.user
