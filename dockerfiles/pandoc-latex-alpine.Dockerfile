# ERROR WITH SOME LATEX PACKAGES, ONLY WORKS DEFAULT LATEX TEMPLATE 
# pandoc/latex:latest is an alpine image 

FROM pandoc/latex:latest

COPY latex-templates/eisvogel.latex /root/.local/share/pandoc/templates/eisvogel.latex

#RUN apk update && apk add texmf-dist texlive

#TODO: install the following packages: adjustbox babel-german background bidi collectbox csquotes everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor sourcecodepro sourcesanspro titling ucharcat ulem unicode-math upquote xecjk xurl zref
