# Use the oficial image of mkdocs-material
FROM squidfunk/mkdocs-material

# Install plugins
RUN pip install mkdocs-pandoc-plugin mkdocs-git-revision-date-localized-plugin

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]


