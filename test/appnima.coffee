"use strict"

Test       = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push _appnima "login", 400
  tasks.push _appnima "signup", 409
  tasks

# Private methods
_appnima = (method, status) -> ->
  parameters =
    method  : method
    mail    : "javi.jimenez.villar@gmail.com"
    password: "password"
  Test "GET", "appnima", parameters, null, "Request #{method} to Appnima", status
