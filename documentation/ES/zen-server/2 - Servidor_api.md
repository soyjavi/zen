# 2. Servidor API

En esa sección aprenderás a crear tu primera API con las diferentes funcionalidades y capacidades que te ofrece ZENserver. Como vimos en el capítulo 1, los endpoints de tipo API debemos alojarlos en la carpeta */api*.


## 2.1 Nuestro primer API endpoint
Vamos a crear nuestro primer API endpoint para ello vamos a crear un fichero `hello.coffee` en la carpeta */api*:

```
"use strict"

module.exports = (zen) ->

  zen.get "/hello", (request, response) -> 
  	response.json hello: "world"
```

Como podemos ver al codificar con CoffeeScript ganamos en legibilidad y mantenibilidad. En este caso el fichero `hello.coffee` exporta un único endpoint de tipo `GET` y que tiene como ruta de acceso `/hello`, el *callback* que se ejecuta cada vez que se acceda a la misma nos devuelve dos parámetros:

 + **request**: Es el objeto nativo de NodeJS pero sobrevitaminado con ZENserver. En posteriores apartados veremos las 
 + **response**: Al igual que el anterior es el objeto nativo, pero como podemos ver con la función `json` (no existente en NodeJS) viene con funcionalidades extra.

En este endpoint únicamente estamos devolviendo un objeto json `{"hello": "world"}` gracias al método `.json()` de ZENserver.

En el caso de que quisiesemos capturar otros métodos http podríamos hacerlo en el mismo fichero `hello.coffee`. Veamos como podríamos capturar otros métodos además del `GET`:

```
"use strict"

module.exports = (zen) ->

  zen.get "/hello", (request, response) -> 
  	response.json hello: "world"
  	
  zen.post "/hello", (request, response) -> 
    response.json method: "POST"

  zen.put "/api", (request, response) -> 
    response.json method: "PUT"

  zen.delete "/api", (request, response) -> 
    response.json method: "DELETE"

  zen.head "/api", (request, response) -> 
    response.json method: "HEAD"

  zen.options "/api", (request, response) -> 
    response.json method: "OPTIONS"
```

El resto de métodos están en la ruta `/api` y devuelven como respuesta otro objeto json con el tipo de método como valor.


## 2.2 URLs
En el caso de que necesitemos tener URLs condicionales y que sean manejadas por el mismo endpoint podemos usar el enrutador condicional de ZENserver. 

Por ejemplo, necesitamos un endpoint que capture cuando se accede a un usuario y a un determinada area del mismo: */user/soyjavi/messages* o */user/cataflu/followers*, para ello podríamos utilizar la URL condicional `/user/:id/:context`:
 
```
zen.get "/user/:id/:context", (request, response) ->
  response.json request.parameters
```

Como vemos devolvemos como respuesta un objeto json contenido en `request.parameters`. En el siguiente capítulo veremos con más detalle el tratamiento de parámetros, pero como adelanto este método devolvería: `{id: "soyjavi", context: "messages"}` y `{id: "cataflu", context: "followers"}`


## 2.3 Parametros
Si continuamos con el endpoint anterior `/user/:id/:context` vamos a realizar ciertos ejercicios con los parámetros que nos lleguen. Como vimos `request.parameters` contiene un objeto con todos los parámetros que se envién. Por ejemplo para la url: 

`http://domain.com/user/soyjavi/messages?order_by=date&page=20`

Obtendríamos automáticamente: 

```
{
	id: "soyjavi",
	context: "messages",
	order_by: "date",
	page: 20}
```

Evidentemente podemos acceder a cada uno de los valores de manera independiente, por ejemplo `request.parameters.id` tendría como valor `"soyjavi"`. En el caso de que queramos testear si existe un determinado parámetros podemos utilizar el método `request.required` al cual debemos enviarle un array de parámetros a testear:

```
zen.get "/domain/:id/:context", (request, response) ->
  if request.required ["name"]
    response.json request.parameters
```
En el caso de que name no fuese enviado ZENserver devolverá una respuesta con código *httpstatus* `400` indicando el primer parámetro no encontrado: `{message: "name is required."}`


## 2.4 Control de sesión
En el caso de que queramos controlar si las peticiones que llegan a nuestro endpoint tienen sesión podemos utilizar el objeto `request.session` el cual en el caso de que exista nos devolverá el valor de la sesión. Esta podrá ser via *cookie* o via autenticación http. 

Veamos como establecer una nueva sesión via cookie, para ello vamos a crear un nuevo endpoint `/login`:

```
zen.get "/login", (request, response) ->
  response.session "10293sjad092a"
  response.json "cookie": true
```

Como vemos antes de devolver una respuesta establecemos una nueva cookie con el valor `"10293sjad092a"` mediante el método `response.session`. Hay que señalar que la persistencia de la cookie que acabas de crear viene dada por la parametrización establecida en el fichero de configuración. Ahora veamos como eliminar esa cookie por medio de otro endpoint `/logout`:

```
zen.get "/logout", (request, response) ->
  response.logout()
  response.json "cookie": false
```
Como vemos no difiere mucho a la creación, únicamente tenemos que llamar al método `response.logout` antes de devolver una respuesta.

Si retomamos el endpoint del capítulo anteriores podríamos unir la sesión (en el caso de que exista) con los parámetros:
```
zen.get "/domain/:id/:context", (request, response) ->
  if request.required ["name"]
    request.parameters.session = request.session
    response.json request.parameters
```

## 2.5 HTTP Status Messages
Por ahora solo conocemos el método json de manera superficial, además de establecer el objeto que queremos devolver podemos, indicar un *HTTPStatusCode* (por defecto 200) y unas *HTTPHeaders*. Por ejemplo:

```
values = 
  username: "cataflu",
  name    : "Catalina"headers =
  domain  : "http://domain.com"

response.json values, 201, headers
```

Como puedes comprobar es realmente sencillo, pero para facilitar aún más las cosas ZENserver te ofrece *HTTPStatus* ya predefinidos. Por ejemplo si en un determinado endpoint queremos devolver que el cliente no tiene permiso simplemente tendríamos que llamar al método `response.badRequest()` y ZENServer se ocupará de crear una respuesta `401` con el mensaje `"Bad Request"`. 

Si quieres conocer todos los mensajes predefinidos:
**2xx Successful**

```
200: "ok"
201: "created"
202: "accepted"
204: "noContent"
```
**4xx Client Error**

```
400: "badRequest"
401: "unauthorized"
402: "paymentRequired"
403: "forbidden"
404: "notFound"
405: "methodNotAllowed"
406: "notAcceptable"
407: "proxyAuthenticationRequired"
408: "requestTimeout"
409: "conflict"
```
**5xx Server Error**

```
500: "internalServerError"
501: "notImplemented"
502: "badGateway"
503: "serviceUnavailable"
504: "gatewayTimeout"
505: "HTTPVersionNotSupported"
```
