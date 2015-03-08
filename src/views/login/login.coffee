angular.module 'Questboard.web.views.login', [
]
.controller 'LoginController', ($scope, $state, QbData) ->

  # Login form multistate
  $scope.loginForm =
    'shake':
      class: ''
      callback: ->
        @state()
        $(@element).removeClass('shake').animate nothing:null, 1, ->
          $(@).addClass('shake')

  $scope.loginButton =
    'loading':
      class: 'loading disabled'
    'success':
      class: 'success disabled'
      callback: -> setTimeout((=> @state 'default'), 3000)
    'error':
      class: 'error disabled'
      callback: -> setTimeout((=> @state 'default'), 3000)

  # Login Model
  $scope.credentials =
    email: ''
    password: ''
    remember: yes

  # Detect last user to log in
  $scope.credentials.email = QbData.getLastUser()

  QbData.reauth().then -> $state.go 'home'

  # Submit login form
  $scope.login = ->
    $scope.loginButton.state 'loading'
    QbData.login $scope.credentials
      .success (data) ->
        $scope.loginButton.state()
        $state.go 'home'
      .error (data) ->
        $scope.loginButton.state()
        $scope.loginForm.state 'shake'
        $scope.credentials.password = ''

  $scope.guest = ->
    QbData.login()
    $state.go 'home'
