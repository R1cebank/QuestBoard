angular.module 'Questboard.web.views.home.signup', []
.controller 'SignupController', ($scope, $state, QbData) ->

  $scope.data =
    name: ''
    email: ''
    phone: ''
    pass: ''
    verify: ''

  $scope.submitButton =
    'loading':
      class: 'loading disabled'
    'success':
      class: 'success disabled'
      callback: -> setTimeout((=> @state 'default'), 3000)
    'error':
      class: 'error disabled'
      callback: -> setTimeout((=> @state 'default'), 3000)

  $scope.errmsg = null

  $scope.submit = ->
    u = $scope.data

    $scope.errmsg = null
    console.log u
    if u.pass isnt u.verify
      $scope.errmsg = 'Your passwords do not match.'
      return

    QbData.signup($scope.data)
      .success -> $state.go 'login'
      .error (error) -> $scope.errmsg = error
