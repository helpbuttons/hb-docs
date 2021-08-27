#!/bin/sh

docker run --rm -it -p 8000:8000 -v ${PWD}:/docs robinforgood/mkdocs-material -f config/es/mkdocs.yml