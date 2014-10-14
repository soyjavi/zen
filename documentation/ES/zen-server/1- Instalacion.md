# 1. Inicio


## 1.1 Instalación

Para instalar una nueva instancia de ZEN-server únicamente tienes que ejecutar el comando:

```
npm install zenserver --save-dev
```

De esta manera tendrás todo lo necesario para comenzar con el proyecto. Otra manera, algo más rudimentaria, es modificar el fichero `package.json` incluyendo esta nueva dependencia:

```
{
  "name"            : "zen-server-instance",
  "version"         : "1.0.0",
  "dependencies": {
    "coffee-script" : "*",
    "zenserver"     : "*" },
  "scripts"         : {"start": "node zen.js"},
  "engines"         : {"node": "*"}
}
```

Como puedes ver además del *package* `zenserver` hemos añadido también el package `coffee-script`, esto es así porque todos los ejemplos que vamos a ver lo vamos a realizar con este lenguaje. Esto no quiere decir que no puedas desarrollar con `JavaScript`, pero creemos que `CoffeeScript` es un *lenguaje* mucho más mantenible y legible. Si deseas aprender más sobre este lenguaje puedes descargarte el libro gratuito [CoffeeScript](https://leanpub.com/coffeescript).


## 1.2 Configuración 
Uno de los beneficios de usar ZEN es que el fichero de configuración (`zen.yml`) cobra una gran importancia a la hora de configurar los servicios disponibles en tu *server*. Vamos a ir analizando cada una de las opciones que nos permite establecer el fichero `zen.yml`:

```
protocol: http # or https
host    : localhost
port    : 8888
timezone: Europe/Amsterdam
```

Esta sección te permite establecer la configuración de tu servidor; el **protocolo** que vas a utilizar (`http` o `https`), el **nombre** del host, **puerto** y **zona horaria**.

```
environment: development
```

El atributo **environment** sirve para crear diferentes ficheros de configuración por ejemplo para utilizarlo en diferentes entornos (desarrollo, preproducción, producción...). En este caso hemos establecido el valor `development` por lo que buscará un fichero en la ruta *environments/development.yml* para sobreescribir los atributos que tengas establecidos en el fichero */zen.yml*.

```
api:
  - index

www:
  - index
```

Los atributos **api** y **www** contienen los *endpoints* de tu servidor. Estos podrán ser de dos tipos; `api` para los servicios REST y *www* para el resto de resultados (HTML, images...). En este caso ZENserver buscará los endpoints `/api/index.coffee` y `/www/index.coffee` y los cargará en el enrutador para su posterior tratamiento. En el capítulo 2 veremos como se crean los endpoints y las diferentes posibilidades que nos ofrece.

```
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

El atributo **statics** nos ofrece una forma sencilla de ofrecer ficheros estáticos en nuestro servidor. Podemos ofrecer directorios completos por medio del atributo `url` o un fichero determinado mediante `file`. Para ambos casos debemos establecer la ruta física y relativa al directorio del proyecto mediante el atributo `folder`. En el caso de que necesitemos que los recursos tenga *cache* simplemente tenemos que establecer el numero de segundos mediante el atributo condicional `maxage`.

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

El atributo **session** nos permite establecer y obtener de una manera sencilla la variable de sesión de un determinado cliente. Esta puede obtenerse mediante *cookie*, donde podemos establecer el **nombre** de la misma, el **dominio**, **ruta** y **expiración**... así como por cabecera en una petición http que en este caso tiene el valor `zenauth`.

```
audit:
  interval: 60000 #miliseconds
```

El atributo **audit** nos permite que ZENserver cree una pequeña auditoria de lo que sucede en nuestro servidor mientras se está ejecutando. Genera un fichero por día en el directorio */logs* con información de todas las peticiones que le llegan al servidor. Por cada petición obtenemos los siguientes datos:

+ Endpoint que se esta solicitando
+ Método: GET, POST, PUT...
+ Tiempo de proceso en milisegundos
+ Código HTTP de respuesta
+ Tamaño de respuesta en bytes
+ Cliente (proximamente)

De esta manera podrás analizar como están usando los usuarios tu servidor e incluso poder identificar *errores*, *bottlenecks* o puntos de mejora. En el caso de que queramos auditar nuestro servidor únicamente tenemos que establecer el atributo interval  con el numero de milisegundos que queremos que tenga en memoria los datos (antes de volcar en el fichero de logs). Esto es así para no sobrecargar el numero de escrituras en disco.

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

Por último podemos establecer el tipo de respuesta de nuestros *endpoints*, pudiendo limitar el acceso a los mismos con los típicos parámetros para el control *cross-origin*, filtrado de métodos, etc...

## 1.2 Servidor HTTPs
alsk

## 1.3 Commands
Como has podido comprobar el fichero de configuración `zen.yml` te permite establecer los valores básicos de tu servidor. En el caso de que quieras hacer un arranque de tu servidor enviando atributos y sobreescribiendo (en el caso de que existan) los del fichero `zen.yml`. Puedes hacerlo de la siguiente manera:

```
node zen.js file.yml production 1980
```

En este ejemplo estamos diciendo a NodeJS que ejecute el fichero zen.js (instanciador de servidor Zenserver) además le enviamos 3 parámetros más:

+ **file.yml**: Es el nombre del fichero de configuración, sustituyendo el por defecto zen.yml.
+ **production**: El nombre del *environment* (entorno) que utilizará sustituyendo al atributo `environment` existente en el fichero de configuración.
+ **1980**: El numero de puerto a utilizar por la instancia de ZENserver sustituyendo al atributo `port` existente en el fichero de configuración.
 
Señalar que no es obligatorio tener que asignar todos los parámetros pero si respetar el orden de los mismos. Con esto en el caso de que queramos asignar un nuevo numero de puerto, deberemos asignar los parámetros anteriores.