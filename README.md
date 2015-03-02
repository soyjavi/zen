ZEN
===

Este es un ejemplo de cómo utilizar los diferentes módulos de ZEN:

  - [ZEN-server](https://github.com/soyjavi/zen-server): Servidores Web con NodeJS
  - [ZEN-proxy](https://github.com/soyjavi/zen-proxy): Tareas de reverse-proxy y balanceo de carga
  - [ZEN-request](https://github.com/soyjavi/zen-request): Requests tanto para endpoints de ZENserver otros servicios en internet

Además, gracias a [ZEN-monitor](https://github.com/soyjavi/zen-monitor/tree/master/documentation/ES), puedes visualizar la auditoría que ofrece ZEN-server.

## 1. Inicio

Con este ejemplo vamos a utilizar varios de los servicios disponibles de los módulos de ZEN. La arquitectura básica de cada módulo lo pudes comprobar en su documentación pero para este ejemplo, el esquema de ficheros y directorios será el siguiente:

```
.
├── api
├── certificates /* Los certificados para HTTPS */
├── environment
├── static
├── test
├── www
│   └── mustache
│   └── index.html
├── package.json
├── zen.js
├── zen.proxy.js
├── zen.proxy.yml
├── zen.request.js
├── zen.request.yml
├── zen.yml
```

Esta arquitectura es la que encontrarás cuando clones el proyecto ZEN. A lo largo de este manual iremos explicando la función de cada elemento.

### 1.1 Arranque

Para empezar, clónate el proyecto e instala sus dependencias:

```bash
$ git clone https://github.com/soyjavi/zen.git
$ npm install
```

Para iniciar la aplicación, basta con ejecutar el comando:

```bash
$node zen zen
```

Recordemos que el primer parámetros después del comando `node` hace referencia al fichero que arranca el servidor, el segundo corresponde al fichero de configuración, el **yaml** que contiene todas la información necesaria con la que trabajará ZEN-server.

Écha un vistazo al contenido de *zen.yml* y recuerda que en la documentación de [ZEN-server](https://github.com/soyjavi/zen-server/tree/master/documentation/ES) encontrarás la descripción de cada bloque de opciones.

### 1.1 Arranque
