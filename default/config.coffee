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
      "file": "#{process.env.PWD}/log/hotspot-dns.log"
    "session":
      "socket": ""
