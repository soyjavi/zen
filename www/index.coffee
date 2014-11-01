"use strict"

module.exports = (zen) ->

  # Basic request with mustache page (with partials)
  zen.get "/www/:subdomain", (request, response, next) ->
    bindings =
      title : "zenserver"
      example:
        subdomain: request.parameters.subdomain
      session: request.session
      mobile : request.mobile
      ip     : request.ip
    response.page "index", bindings, ["partial.example", "partial.session"]


  # Basic Redirect
  zen.get "/user/:id", (request, response) ->
    response.redirect "/www/#{request.parameters.id}"


  # Authentication via cookie and redirect
  zen.get "/session/:context", (request, response, next) ->
    if request.parameters.context is "login"
      response.session (new Date()).toString()
    else
      response.logout()
    response.redirect "/www/#{request.parameters.context}"


  # form-data and HTML response
  zen.get "/form", (request, response, next) ->
    response.html """
      <form action="/form" method="post" enctype="multipart/form-data">
        <input type="text" name="field1">
        <input type="text" name="field2">
        <input type="file" name="media">
        <input type="submit" value="Submit">
      </form>
    """

  zen.post "/form", (request, response, next) ->
    if request.parameters.media
      response.file request.parameters.media.path
    else
      response.json request.parameters
