
# serve documentation
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material

# build documentation
docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build