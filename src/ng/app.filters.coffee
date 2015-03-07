angular.module 'Questboard.web.filters', []

.filter 'ago', ->
  return (input) ->
    return moment(input).fromNow()
