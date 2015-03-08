angular.module 'Questboard.web.views.home.post-detail', []
.controller 'PostDetailController', ($scope, $state, $stateParams, QbData, QbSession) ->

  # Go back to /home if post id is unefined
  if not $stateParams.post or not QbData.posts
    $state.go 'home'
    return

  # ..otherwise, display
  $scope.post = QbData.posts[$stateParams.post]

  $scope.ownedByMe = ->
    $scope.post?.uuid is QbSession.user?.uuid
