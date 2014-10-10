# Instalación

Para instalar una nueva instancia de ZEN-server únicamente tienes que ejecutar el comando:

```
npm install zen-server --save-dev
```

De esta manera tendrás todo lo necesario para comenzar con el proyecto. Otra manera, algo más rudimentaría, es modificar el fichero ```package.json``` incluyendo esta nueva dependencia:

```
{
  "name"            : "zen-server-instance",
  "version"         : "1.0.0",
  "dependencies": {
    "coffee-script" : "*",
    "zenserver"     : "*" },
  "scripts"         : {
    "start": "node zen.js"},
  "engines"         : {
    "node": "*"}
}
```
Como
