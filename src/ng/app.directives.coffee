angular.module 'Questboard.web.directives', []

# --------------------------------------------------------------------------- #
# Angular.js directive version of Kernite.Multistate                          #
# --------------------------------------------------------------------------- #
.directive 'qbMultistate', ->
  restrict: 'A'
  scope:
    config: '=qbMultistate'
  link: (scope, element, attr) ->
    config = scope.config
    # Add default state to the config (if not already present)
    if not config.default
      config.default = class: '',  callback: null
    # Construct unique class table
    scope.classes = _.chain(config).map((v) -> (v.class ? '').split(' ')).
      flatten().uniq().compact().value().join(' ')
    # Save current state
    scope.state = 'default'

    # Make element accessible from config object
    config.element = element

    # Attach state method to the config variable
    config.state = (name, force) ->
      # Do not change state if already in the state; unless forced
      if (not force) and (scope.state is name) then return
      # if state not found, go to default
      if not config[name] then name = 'default'
      # Save current state
      scope.state = name
      # transition
      element.removeClass(scope.classes).addClass(config[name].class)
      if (config[name].callback) then config[name].callback.call(config)

# --------------------------------------------------------------------------- #
# You shall not drag!!                                                        #
# --------------------------------------------------------------------------- #
.directive 'qbNoDrag', ->
  restrict: 'A'
  link: (scope, element) ->
    $(element).on 'dragstart', -> no

# --------------------------------------------------------------------------- #
# Automatically focus whenever needed.                                        #
# --------------------------------------------------------------------------- #
.directive 'qbAutoFocus', ($timeout, $parse) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    model = $parse(attrs.ckAutoFocus)
    scope.$watch model, (value) ->
      if value then $timeout(-> element[0].focus())

# --------------------------------------------------------------------------- #
# UUID -> Email Hash -> Profile Image                                         #
# --------------------------------------------------------------------------- #
.directive 'qbProfileImg', (QbClient) ->
  restrict: 'A'
  scope:
    src: '@qbProfileImg'
  link: (scope, element, attr) ->

    QbClient.request('emailhash', uuid: scope.src)
      .success (data) ->
        url = "http://www.gravatar.com/avatar/#{data.data}?size=64"
        $(element).attr 'src', url
      .error (error) ->
        $(element).attr 'src', 'assets/default-profile.png'


.directive 'qbGreeting', (QbGreetings) ->
  restrict: 'A'
  scope:
    seed: '@qbGreeting'
  link: (scope, element, attr) ->
    Math.seedrandom(scope.seed)

    str = ''
    # Append the greeting
    str += QbGreetings.greets[Math.floor(
      Math.random() * QbGreetings.greets.length)] + ', '
    # Append the adjective
    str += QbGreetings.adjs[Math.floor(
      Math.random() * QbGreetings.adjs.length)] + ' '
    # Append the subject
    str += QbGreetings.subs[Math.floor(
      Math.random() * QbGreetings.subs.length)] + '!'

    $(element).text(str)

.directive 'compareTo', ->
  require: 'ngModel'
  scope:
    other: '=compareTo'
  link: (scope, element, attr, model) ->
    model.$validators.compareTo = (val) ->
      scope.other is val

    scope.$watch 'other', -> model.$validate()

.directive 'qbFloatLabel', ->
  restrict: 'A'
  link: (scope, element) ->
    $(element).addClass 'float-label'
    $(element).find('> input, > textarea').change ->
      if not $(@).val()
        $(@).removeClass 'has-value'
      else
        $(@).addClass 'has-value'
