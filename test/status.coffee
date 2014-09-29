"use strict"

Test       = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _method "201", 201
  tasks.push _method "401", 401
  tasks.push _method "501", 501
  tasks

# Private methods
_method = (endpoint, status) -> ->
  Test "GET", "status/#{endpoint}", null, null, "Request to /status/#{endpoint} with GET method", status
