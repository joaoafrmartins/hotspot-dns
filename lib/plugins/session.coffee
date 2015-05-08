{ createClient } = require 'redis'

module.exports = (next) ->

  socket = @config.plugins.session.socket

  client = createClient socket

  process.on "hotspot-dns:shutdown:dettach", () ->

    client.end()

    process.emit "hotspot-dns:shutdown:dettached", "session"

  client.on "end", () =>

    @console.info "redis", "end", socket

    process.emit "hotspot-dns:shutdown:dettached", "session"

  client.on "error", (err) =>

    @console.error "redis", err

  client.on "connect", () =>

    { host, port } = @config.plugins.session

    @console.info "redis", "connected", socket

    process.emit "hotspot-dns:shutdown:attach", "session"

  Object.defineProperty @, "session", value:

    put: ->

    get: ->

    del: ->

  next null
