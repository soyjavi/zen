# Instalación

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
