# Configuración

Uno de los beneficios de usar ZEN

```
protocol: http # or https
host    : localhost
port    : 8888
timezone: Europe/Amsterdam
```
Lo principal es que puedas 

```
environment: development
```

```
api:
  - index

www:
  - index

statics:
  - url     : /temp/resources
    folder  : /static
    maxage  : 60 #secods
  - url     : /img
    folder  : /static/img
  - file    : humans.txt
    folder  : /static
    maxage  : 3600
  - file    : robots.txt
    folder  : /static
```

```
session:
  # Cookie Request
  cookie: zencookie
  domain: ""
  path  : "/"
  expire: 3600 #seconds
  # HTTP Header
  authorization: zenauth
```

```
audit:
  interval: 60000 #miliseconds
```

```
headers:
  Access-Control-Allow-Origin: "*"
  Access-Control-Allow-Credentials: true
  Access-Control-Allow-Methods: GET,PUT,POST,DELETE
  Access-Control-Max-Age: 1
  Access-Control-Allow-Headers:
    - Accept
    - Accept-Version
    - Content-Length
    - Content-MD5
    - Content-Type
    - Date
    - Api-Version
    - Response-Time
    - Authorization
  Access-Control-Expose-Headers:
    - api-version
    - content-length
    - content-md5
    - content-type
    - date
    - request-id
    - response-time
```
