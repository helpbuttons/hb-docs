
![HB cover](/images/wip_sept_2021/hb_landscape_02_small.jpg?raw=true "hb cover")

# Helpbuttons Documentation

You need to have [Docker](https://www.docker.com/) installed in order to run this repository.

# Checkout the latest docs generated:

https://helpbuttons.github.io/hb-docs

# serve documentation
`$ docker-compose up serve`

# build documentation
`$ docker-compose up build`

```
$ mkdir local
$ cp swagger.yaml local/
$ docker run --rm -v "${PWD}/local:/local" openapitools/openapi-generator-cli generate  -i /local/swagger.yaml     -g typescript-node     -o /local/backend
$ cp -r local/backend/* ../hb-back/
```
