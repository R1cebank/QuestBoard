angular.module 'Questboard.web.routes', []
.config ($stateProvider, $urlRouterProvider) ->

  $stateProvider
    .state(
      'login',
      url: '/login',
      templateUrl: 'views/login/login.html',
      controller: 'LoginController'
    )
    .state(
      'home',
      url: '/',
      templateUrl: 'views/home/home.html',
      controller: 'HomeController'
    )
    .state(
      'home.post',
      url: 'view?post',
      templateUrl: 'views/home/post-detail/post-detail.html',
      controller: 'PostDetailController'
    )
    .state(
      'home.signup',
      url: 'signup',
      templateUrl: 'views/home/signup/signup.html',
      controller: 'SignupController'
    )

  $urlRouterProvider.otherwise ''


.run ($rootScope, $state) ->

  $rootScope.$on '$stateChangeStart', (e, to) ->
    if to.name isnt 'login' and not $rootScope.loggedIn
      e.preventDefault()
      $state.go 'login'
