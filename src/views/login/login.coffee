angular.module 'Questboard.web.views.login', []
.controller 'LoginController', ($scope, QbData) ->

  # Login form multistate
  $scope.loginForm =
    'shake':
      class: ''
      callback: ->
        @state()
        $(@element).removeClass('shake').animate nothing:null, 1, ->
          $(@).addClass('shake')

  # Login Model
  $scope.credentials =
    email: ''
    password: ''
    remember: yes

  # Detect last user to log in
  $scope.credentials.email = QbData.getLastUser()

  # Submit login form
  $scope.login = ->
    QbData.login $scope.credentials
      .success (data) -> console.log data
      .error (data) ->
        $scope.loginForm.state 'shake'
        $scope.credentials.password = ''
