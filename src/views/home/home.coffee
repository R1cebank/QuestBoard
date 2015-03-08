angular.module 'Questboard.web.views.home', [
  'Questboard.web.views.home.post-detail'
  'Questboard.web.views.home.signup'
  'Questboard.web.views.home.edit'
]
.controller 'HomeController',
($scope, $rootScope, snapRemote, QbSession, QbData) ->

  snapRemote.disable()

  $scope.tasks = -> QbData.posts

  $scope.openDrawer = ->
    snapRemote.toggle('right')

  $scope.user = -> QbSession.user

  $rootScope.$on '$stateChangeSuccess', (e, toState, toParams, fromState) ->
    bp = window
          .getComputedStyle(document.body,":after")
            .getPropertyValue("content")

    if (toState.name is 'home.post' or
        toState.name is 'home.signup') and bp is 'xs'
      snapRemote.expand('right')

    if (fromState.name is 'home.post' or
        fromState.name is 'home.signup') and toState.name isnt 'home.signup'
      snapRemote.close()
