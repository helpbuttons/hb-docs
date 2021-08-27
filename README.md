# Documentación de HelpButtons

Accesible en: [https://docsss.gitlab.io/mkdocs-material/](https://docsss.gitlab.io/mkdocs-material/)

## Inicio rápido

### Despliegue en local

1. Clone este repositorio `git clone https://gitlab.com/docsss/mkdocs-material`.
2. Servir los docs corriendo en Docker con la imagen [robinforgood/mkdocs-material](https://hub.docker.com/r/robinforgood/mkdocs-material) (recomendada porque tiene instalados [mkdocs-pandoc-plugin](https://pypi.org/project/mkdocs-pandoc-plugin/) y [mkdocs-git-revision-date-localized-plugin](https://github.com/timvink/mkdocs-git-revision-date-localized-plugin)). Otra opción es usar la imagen oficial [squidfunk/mkdocs-material](https://hub.docker.com/r/squidfunk/mkdocs-material/) pero sin generador de pdf y es necesario comentar las opciones `pandoc` y `git-revision-date-localized` en [mkdocs.yml](mkdocs.yml). Usa una imagen con plugins:

- Para servir la documentación en español en local: 
``bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs robinforgood/mkdocs-material -f config/es/mkdocs.yml
```

- Para servir la documentación en inglés en local: 
```bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs robinforgood/mkdocs-material -f config/es/mkdocs.yml
```
3. Abra [http://localhost:8000/](http://localhost:8000/) en su navegador. Tenga en cuenta que una pequeña desventaja es que no puede utilizar el comando mkdocs serve para servir su sitio localmente con todos los idiomas.

### Build pdfs with pandoc and Eisvogel LaTeX template in local

El comando más rápido es ejecutar:
```
sh scripts/pdf_local_generator.sh
```

Pero puedes seguir estos pasos:

1. Para construir el contenido público con el plugin pandoc y combinar todos los archivos markdown en uno (public/es/docs.pdf.md):

- En español:
``bash
docker run --rm -it -v ${PWD}:/docs -e ENABLE_PANDOC_EXPORT=1 robinforgood/mkdocs-material build -f config/es/mkdocs.yml --verbose
```

- En inglés:
```bash
docker run --rm -it -v ${PWD}:/docs -e ENABLE_PANDOC_EXPORT=1 robinforgood/mkdocs-material build -f config/es/mkdocs.yml --verbose
```

1. Construir pdf con pandoc y eisvogel LaTeX:
```bash
docker run --rm -it -v ${PWD}:/data robinforgood/latex-pandoc /bin/bash -c 'mkdir -p /assets; cp -r /data/overrides/assets/images /assets/images ; pandoc -N --template=eisvogel. latex --listings -V lang=es --from markdown --variable mainfont="DejaVuSerif" --variable sansfont="DejaVuSans" --variable monofont="DejaVuSansMono" --variable fontsize=12pt --variable version=2. 0 /data/pdf_metadata_esp.md /data/public/es/docs.pdf.md --pdf-engine=xelatex --toc -o /data/docs_hb_esp.pdf;'
```

### Deploy on GitLab Pages

1. Vaya a GitLab, seleccione `Set CI/CD` y copie el contenido de [`.gitlab-ci.yml`]

## Resumen

### Mkdocs
Mkdocs](https://www.mkdocs.org/) es un generador de sitios estáticos rápido, sencillo y francamente bonito que está orientado a la construcción de documentación de proyectos. Los archivos fuente de la documentación se escriben en Markdown, y se configuran con una sola configuración YAML.

### Material para MkDocs

Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) es un tema para MkDocs, un generador de sitios estáticos orientado a la documentación de proyectos (técnicos). 

### Pandoc

Pandoc](https://pandoc.org/) es una biblioteca Haskell para convertir de un formato de marcado a otro, y una herramienta de línea de comandos que utiliza esta biblioteca.

### Eisvogel

Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template) es una plantilla pandoc LaTeX limpia para convertir tus archivos markdown a PDF o LaTeX. Está diseñada para apuntes de clase y ejercicios centrados en la informática. Vea las [variables de las plantillas personalizadas](https://github.com/Wandmalfarbe/pandoc-latex-template#custom-template-variables).

## Plugins instalados en mkdocs

Por defecto, [mkdocs-minify-plugin](https://github.com/byrnereese/mkdocs-minify-plugin) y [mkdocs-redirects](https://github.com/datarobot/mkdocs-redirects) están instalados en la imagen docker oficial [squidfunk/mkdocs-material](https://hub.docker.com/r/squidfunk/mkdocs-material/).

### mkdocs-pandoc-plugin

Utiliza [mkdocs-pandoc-plugin](https://pypi.org/project/mkdocs-pandoc-plugin/) y genera un pdf u otra salida con pandoc. Active la opción con la variable de entorno `ENABLE_PANDOC_EXPORT` puesta a 1.

### mkdocs-git-revision-date-localized-plugin

Utilice [mkdocs-git-revision-date-localized-plugin](https://github.com/timvink/mkdocs-git-revision-date-localized-plugin) para activar la visualización de la fecha de la última modificación git de una página.

---

# HelpButtons documentation

Available at: [https://docsss.gitlab.io/mkdocs-material/](https://docsss.gitlab.io/mkdocs-material/)

## Quick start

### Deploy on localhost

1. Clone this repository `git clone https://gitlab.com/docsss/mkdocs-material`.
2. Serve the docs running in Docker with the image [robinforgood/mkdocs-material](https://hub.docker.com/r/robinforgood/mkdocs-material) (recommended because it has installed [mkdocs-pandoc-plugin](https://pypi.org/project/mkdocs-pandoc-plugin/) and [mkdocs-git-revision-date-localized-plugin](https://github.com/timvink/mkdocs-git-revision-date-localized-plugin)). Other option is to use the oficial image [squidfunk/mkdocs-material](https://hub.docker.com/r/squidfunk/mkdocs-material/) but without pdf generator and it's neccesary to comment `pandoc` and `git-revision-date-localized` options in [mkdocs.yml](mkdocs.yml). Using an image with plugins:

- Serve spanish documentation on localhost: 
```bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs robinforgood/mkdocs-material -f config/es/mkdocs.yml
```

- Serve english documentation on localhost: 
```bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs robinforgood/mkdocs-material -f config/en/mkdocs.yml
```
3. Open [http://localhost:8000/](http://localhost:8000/) in your browser. Note that one small disadvantage is that you cannot use the mkdocs serve command to serve your site locally with all languages.

### Build pdfs with pandoc and Eisvogel LaTeX template in local

Faster command is to execute:

```
sh scripts/pdf_local_generator.sh
```

But you can follow this steps:

1. Build public content with pandoc-plugin to combine all markdown files in one (public/docs.pdf.md):

- Spanish:
```bash
docker run --rm -it -v ${PWD}:/docs -e ENABLE_PANDOC_EXPORT=1 robinforgood/mkdocs-material build -f config/es/mkdocs.yml --verbose
```

- English:
```bash
docker run --rm -it -v ${PWD}:/docs -e ENABLE_PANDOC_EXPORT=1 robinforgood/mkdocs-material build -f config/es/mkdocs.yml --verbose
```

1. Build pdf with pandoc and eisvogel LaTeX:
```bash
docker run --rm -it -v ${PWD}:/data  robinforgood/latex-pandoc /bin/bash -c 'mkdir -p /assets; cp -r /data/overrides/assets/images /assets/images  ; pandoc -N --template=eisvogel.latex --listings -V lang=en --from markdown --variable mainfont="DejaVuSerif" --variable sansfont="DejaVuSans" --variable monofont="DejaVuSansMono" --variable fontsize=12pt --variable version=2.0 /data/pdf_metadata_eng.md /data/public/en/docs.pdf.md  --pdf-engine=xelatex --toc -o /data/docs_hb_eng.pdf;'
```

### Deploy on GitLab Pages

1. Go to GitLab, select `Set CI/CD` and copy the content of [`.gitlab-ci.yml`](.gitlab-ci.yml).

## Overview

### Mkdocs
[Mkdocs](https://www.mkdocs.org/) is a fast, simple and downright gorgeous static site generator that's geared towards building project documentation. Documentation source files are written in Markdown, and configured with a single YAML configuration.

### Material for MkDocs

[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) is a theme for MkDocs, a static site generator geared towards (technical) project documentation. 

### Pandoc

[Pandoc](https://pandoc.org/) is a Haskell library for converting from one markup format to another, and a command-line tool that uses this library.

### Eisvogel

[Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template) is a clean pandoc LaTeX template to convert your markdown files to PDF or LaTeX. It is designed for lecture notes and exercises with a focus on computer science. See the [custom templates variables](https://github.com/Wandmalfarbe/pandoc-latex-template#custom-template-variables).

## Plugins installed on mkdocs

By default, [mkdocs-minify-plugin](https://github.com/byrnereese/mkdocs-minify-plugin) and [mkdocs-redirects](https://github.com/datarobot/mkdocs-redirects) are installed in oficial docker image [squidfunk/mkdocs-material](https://hub.docker.com/r/squidfunk/mkdocs-material/).

### mkdocs-pandoc-plugin

Use [mkdocs-pandoc-plugin](https://pypi.org/project/mkdocs-pandoc-plugin/) and generate a pdf or other output with pandoc. Active the opction with the environmental variable `ENABLE_PANDOC_EXPORT` set to 1.

### mkdocs-git-revision-date-localized-plugin

Use [mkdocs-git-revision-date-localized-plugin](https://github.com/timvink/mkdocs-git-revision-date-localized-plugin) to enable displaying the date of the last git modification of a page.
