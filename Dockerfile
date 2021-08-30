FROM squidfunk/mkdocs-material:7.2.5

RUN pip install mkdocs-pandoc-plugin mkdocs-git-revision-date-localized-plugin
