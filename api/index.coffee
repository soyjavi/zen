"use strict"

Appnima = require("zenserver").Appnima

module.exports = (zen) ->

  # RESTful
  zen.get "/api", (request, response) -> response.json method: "GET"

  zen.post "/api", (request, response) -> response.json method: "POST"

  zen.put "/api", (request, response) -> response.json method: "PUT"

  zen.delete "/api", (request, response) -> response.json method: "DELETE"

  zen.head "/api", (request, response) -> response.json method: "HEAD"

  zen.options "/api", (request, response) -> response.json method: "OPTIONS"


  # Required parameters & Authentication via header
  zen.get "/domain/:id/:context", (request, response) ->
    if request.required ["name"]
      request.parameters.session = request.session
      response.json request.parameters


  # Example of REST status
  zen.get "/status/201", (request, response) -> response.created()

  zen.get "/status/401", (request, response) -> response.unauthorized()

  zen.get "/status/501", (request, response) -> response.notImplemented()


  # Appnima login/signup
  zen.get "/appnima", (request, response) ->
    if request.required ["method", "mail", "password"]
      method = request.parameters.method
      Appnima[method](request.parameters, agent = null).then (error, value) ->
        if error
          code = error.code
          value = message: error.message
        response.json value, code
