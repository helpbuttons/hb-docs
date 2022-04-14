# Run Documentation

Checkout the latest docs generated:

[https://helpbuttons.github.io/hb_docs](https://helpbuttons.github.io/hb_docs)

First remember to install and execute docker.

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
