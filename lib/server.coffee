{ resolve } = require 'path'

{ waterfall } = require 'async'

{ createServer } = require 'dnsd'

module.exports = class Server

  constructor: (next, config) ->

    plugins = []

    Object.defineProperty @, "config", value: config or

      require('a-npm-config')(

        resolve(__dirname, '.', 'config'), ['plugins']

      )

    Object.defineProperty @, "server", value: createServer @main.bind @

    @server.listen @config.port, @config.address

    Object.keys(config.plugins or {}).map (plugin) =>

      if config.plugins[plugin]

        plugin = require resolve ".", "lib", "plugins", "#{plugin}"

        plugins.push plugin.bind @

    waterfall plugins, (err) =>

      process.emit "hotspot-dns:started"

      next err, @

  main: (req, res) ->

    { remoteAddress } = req.connection

    res.end @config.address

    ###

    @session.get remoteAddress, (err, res) =>

      res.end @config.address

    ###
