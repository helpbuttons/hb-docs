#!/bin/sh

docker build -f dockerfiles/mkdocs-material+plugins.Dockerfile -t robinforgood/mkdocs-material:latest .

docker build -f dockerfiles/latex-pandoc.Dockerfile -t robinforgood/latex-pandoc:latest .
