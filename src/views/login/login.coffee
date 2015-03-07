angular.module 'Questboard.web.views.login', []
.controller 'LoginController', ($scope, QbClient) ->

  # Login Model
  $scope.credentials =
    email: ''
    password: ''
    remember: yes

  $scope.click = ->
    #console.log $scope.credentials
    #QbClient.connect()
    #QbClient.socket.emit('ping')
    QbClient.request('login', _.pick $scope.credentials, 'email', 'password')
      .success (data) -> console.log data
      .error (data) -> console.log data
