module.exports =
  "port": 5353
  "address": "127.0.0.1"
  "kill": [
    "SIGTERM",
    "SIGINT",
    "SIGUSR2",
    "uncaughtException"
  ]
  "plugins":
    "shutdown":
      "timeout": 3000
    "logger":
      "file": "#{process.env.PWD}/data/hotspot-dns/server.log"
    "session":
      "socket": "#{process.env.PWD}/data/redis/redis-server.sock"
