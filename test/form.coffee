"use strict"

Test       = require("zenrequest").Test

module.exports = ->

  tasks = []
  tasks.push ->
    parameters =
      field1: "Javi"
      field2: "@soyjavi"
      extra : true
    Test "POST", "form", parameters, null, "Send parameters via POST"
  tasks

# Private methods
_appnima = (method, status) -> ->
  parameters =
    method  : method
    mail    : "javi.jimenez.villar@gmail.com"
    password: "password"
  Test "GET", "appnima", parameters, null, "Request #{method } to Appnima", status
