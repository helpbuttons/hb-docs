FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y pandoc

COPY latex-templates/eisvogel.latex /usr/share/pandoc/data/templates/eisvogel.latex

COPY latex-templates/default.latex /usr/share/pandoc/data/templates/default.latex

COPY latex-templates/pandoc-scholar.latex /usr/share/pandoc/data/templates/pandoc-scholar.latex
