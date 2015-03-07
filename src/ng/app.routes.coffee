angular.module 'Questboard.web.routes', []
.config ($stateProvider) ->

  $stateProvider
    .state(
      'login',
      url: '/login',
      templateUrl: 'views/login/login.html',
      controller: 'LoginController'
    )
