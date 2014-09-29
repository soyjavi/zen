"use strict"

Test       = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _method "GET"
  tasks.push _method "POST"
  tasks.push _method "PUT"
  tasks.push _method "DELETE"
  # tasks.push _method "HEAD"
  # tasks.push _method "OPTIONS"
  tasks.push _required "user", "soyjavi", null, 400
  tasks.push _required "user", "soyjavi", name: "Javi", 200
  tasks.push _auth "user", "soyjavi", {name: "Javi"}, {zenauth: "tapquo"}, 200
  tasks

# Private methods
_method = (method) -> ->
  Test method, "api", null, null, "Request to /api with #{method} method", 200

_required = (id, context, parameters, status) -> ->
  url = "domain/#{id}/#{context}"
  Test "GET", url, parameters, null, "Request to #{url} with #{parameters?} parameters", status

_auth = (id, context, parameters, headers, status) -> ->
  url = "domain/#{id}/#{context}"
  Test "GET", url, parameters, headers, "Request to #{url} with http auth", status
