#Installation Guide

The project is divided in two repositories, hb-front and hb-back, that need to run at the same time. The docs repository, this one, can be edited here :

[https://github.com/helpbuttons/hb_docs](https://github.com/helpbuttons/hb_docs)

##  Requisites

Install all this to start:

- PostgreSQL para PostGIS
[https://www.postgresql.org/](https://www.postgresql.org/)
- Docker
[https://www.docker.com/](https://www.docker.com/)
- Nodejs
[https://nodejs.org/en/](https://nodejs.org/en/)
- Yarn o NPM
[https://yarnpkg.com/](https://yarnpkg.com/)
[https://www.npmjs.com/](https://www.npmjs.com/)

## running the frontend

[https://github.com/helpbuttons/hb-front](https://github.com/helpbuttons/hb-front)

Open console / terminal:

- npm install
- npm run dev

You can see the running app here:
[http://localhost:3000/](http://localhost:3000/)

## running the backend

[https://github.com/helpbuttons/hb-back](https://github.com/helpbuttons/hb-back)

#### We need to run an instance of postgis.. we recomend to use docker

Open console / terminal:

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

Open [http://127.0.0.1:3001](http://127.0.0.1:3001) in your browser.

#### run the application in watchmode
```sh
$ yarn start:watch
```


## developers hints:

Cheatsheet on chai and mochajs
 [https://devhints.io/chai.html](https://devhints.io/chai.html)

docker compose up

[http://localhost:3001/](http://localhost:3001/)


### CONGRATULATIONS, YOU JOINED THE CONTRIBUTORS LIST
