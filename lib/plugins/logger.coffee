{ resolve } = require 'path'

logger = require 'a-file-logger-property'

module.exports = (next) ->

  file = @config?.plugins?.logger?.file or resolve(

    "#{process.env.pwd}", "data", "log", "hotspot-dns.log"

  )

  process.on "hotspot-dns:shutdown:dettach", () ->

    process.emit "hotspot-dns:shutdown:dettached", "logger"

  logger.bind(@) { file: file }, (err) ->

    if err then return next err

    process.emit "hotspot-dns:shutdown:attach", "logger"

    next null
