angular.module 'Questboard.web.views.home.post-detail', []
.controller 'PostDetailController',
($scope, $state, $stateParams, QbData, QbSession) ->

  # Go back to /home if post id is unefined
  if not $stateParams.post or not QbData.posts
    $state.go 'home'
    return

  $scope.acceptButton =
    'loading':
      class: 'loading disabled'
    'success':
      class: 'success disabled'
      callback: -> setTimeout((=> @state 'default'), 3000)
    'error':
      class: 'error disabled'
      callback: -> setTimeout((=> @state 'default'), 3000)


  # ..otherwise, display
  $scope.post = QbData.posts[$stateParams.post]

  $scope.accepted = QbSession.user.accepted.indexOf($scope.post.postid) != -1;

  $scope.ownedByMe = ->
    $scope.post?.uuid is QbSession.user?.uuid

  $scope.accept = ->
    if not $scope.accepted
      $scope.acceptButton.state 'loading'
      QbData.accept($scope.post.postid)
        .success ->
          $scope.acceptButton.state 'success'
        .error ->
          $scope.acceptButton.state 'error'
    
