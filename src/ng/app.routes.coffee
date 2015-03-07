angular.module 'Questboard.web.routes', []
.config ($stateProvider) ->

  $stateProvider
    .state(
      'login',
      url: '/login',
      templateUrl: 'views/login/login.html',
      controller: 'LoginController'
    )
    .state(
      'home',
      url: '/home',
      templateUrl: 'views/home/home.html',
      controller: 'HomeController'
    )
    .state(
      'home.post',
      url: '/view?post',
      templateUrl: 'views/home/post-detail/post-detail.html',
      controller: 'PostDetailController'
    )
