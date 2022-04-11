# Instalaciones de Help Buttons

## En GNU/Linux

Referencias seguidas:

Para realizar la instalación de Node en Debian o derivados (Ubuntu) existen los siguientes requisitos:

- PostgreSQL para PostGIS
https://www.postgresql.org/
- Docker
https://www.docker.com/
- Nodejs
https://nodejs.org/en/
- Yarn o NPM
https://yarnpkg.com/
https://www.npmjs.com/

Para el front, abre una terminal:
- npm install
- npm run dev

(http://localhost:3000/)

En el back:
- npm install
- npm start

or


## running the backend
#### We need to run an instance of postgis.. we recomend to use docker

To start postgis:
```sh
$ cp env.docker .env
$ docker-compose up db -d
```
### install dependencies

```sh
yarn
```

#### Run the application
```sh
$ yarn start
```

Open http://127.0.0.1:3001 in your browser.

#### run the application in watchmode
```sh
$ yarn start:watch
```


## developers hints:

Cheatsheet on chai and mochajs
 https://devhints.io/chai.html

docker compose up

(http://localhost:3001/)


### Instalación de la versión de Node del proyecto. Problemas comunes.

### Command not found
