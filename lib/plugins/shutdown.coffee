module.exports = (next) ->

  shutdown = {}

  process.on "hotspot-dns:shutdown:attach", (plugin) ->

    shutdown[plugin] = 1

  process.on "hotspot-dns:shutdown:dettached", (plugin) ->

    shutdown[plugin] = 0

    done = !!!Object.keys(shutdown).reduce (sum, plugin) ->

      sum += shutdown[plugin]

    , 0

    if done then process.emit "hotspot-dns:shutdown"

  process.on "hotspot-dns:shutdown:dettach", () ->

    process.emit "hotspot-dns:shutdown:dettached", "shutdown"

  process.on "hotspot-dns:shutdown", =>

    @server.close()

    @console.info "shutdown"

    setTimeout () =>

      @console.error "forcefull shutdown"

      process.exit 1

    , @config?.plugins?.shutdown?.timeout or 3000

    process.exit 0

  Object.defineProperty @, "shutdown", value: =>

    process.emit "hotspot-dns:shutdown:dettach"

  process.emit "hotspot-dns:shutdown:attach", "shutdown"

  next null
