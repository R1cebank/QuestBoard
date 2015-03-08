angular.module 'Questboard.web.data', []
.service 'QbData',
($q, $state, $rootScope, $localStorage, QbClient, QbSession) ->

  self = @

  $rootScope.isGuest = ->
    $rootScope.loggedIn and !QbSession.token

  QbClient.socket.on 'update', -> self.loadUserData()

  @login = (params) ->
    if params
      QbClient.request('login', _.pick params, 'email', 'password')
        .success (data) ->
          QbSession.create(params.email, data.data, params.remember)
          self.loadUserData().then -> console.log self.posts
    else
      QbSession.guest()
      self.loadUserData()

  @reauth = ->
    if not $localStorage.token then return $q.reject()
    QbClient.request 'reauth', token: $localStorage.token
      .success (data) ->
        QbSession.create($localStorage.email, data.data, yes)
        self.loadUserData()


  @loadUserData = ->
    promises = { }
    if not $rootScope.isGuest()
      promises.user = QbClient.request('whoami', token: QbSession.token)
        .then (data) ->
          QbSession.user = data.data
        .error (error) -> console.log error

    param =
      type: 'Point'
      coordinates: [-86.91024, 40.42601]

    promises.tasks = QbClient.request('geosearch', {location: param, maxDist: 3000})
      .then (data) ->
        self.posts = _.indexBy data.data, 'postid'
      .error (error) -> console.log error

    return $q.all(promises)

  @getLastUser = -> $localStorage.email  ? ''

  @signup = (params) ->
    QbClient.request('register', _.omit params, 'verify')

  @accept = (postid) ->
    QbClient.request('accept', postid: postid, token: QbSession.token)
      .success (data) ->
        QbSession.user.accepted.push(postid)
        $scope.accepted = yes
      .error (error) -> console.log error

  return @
