angular.module 'Questboard.api', [
  'Questboard.web.const'
]

.run (QbClient) ->

  QbClient.connect()

.service 'QbClient', ($q, QbApiConfig) ->

  # Promise Map (nonce -> promise)
  promises = { }

  # Establish connection
  @connect = ->
    @socket = io.connect(QbApiConfig.base)
    @socket.on 'response', @on

  # Client -> Server
  @request = (event, data) ->
    data     = _.extend {}, data, nonce: lil.uuid()
    deferred = $q.defer()
    @socket.emit(event, data)
    promises[data.nonce] = deferred
    deferred._qb_event = event
    return deferred.promise

  # Server -> Client
  @on = (data) ->
    if not data then return
    deferred = promises[data.nonce]
    if not deferred
      console.log "Unrecognized promise: #{data.nonce}"
      return
    if data.errorcode
      console.log deferred._qb_event, data
      deferred.reject data
    else
      deferred.resolve data

  return @
