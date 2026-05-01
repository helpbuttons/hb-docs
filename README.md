![Helpbuttons](images/wip_sept_2021/base_jumbo_03.jpg)

# Helpbuttons Documentation

This is the documentation repository for [Helpbuttons](https://github.com/helpbuttons/helpbuttons) — an open-source platform for building geo-based collaborative networks.

**Browse the docs:** [helpbuttons.github.io/hb-docs](https://helpbuttons.github.io/hb-docs)

---

## Contributing to the docs

The docs are written in Markdown and built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/).

### Run locally

```sh
pip install mkdocs-material mkdocs-render-swagger-plugin mkdocs-git-revision-date-localized-plugin
mkdocs serve
```

> On macOS use `pip3` instead of `pip`.

Open [http://localhost:8000](http://localhost:8000).

### Structure

```
docs/
├── English/      # English documentation
├── Castellano/   # Spanish documentation
├── images/       # Images used in the docs
└── index.md      # Landing page
```

To contribute, edit the Markdown files in `docs/` and open a pull request.

---

*Part of the [Helpbuttons](https://github.com/helpbuttons/helpbuttons) project · [help@helpbuttons.org](mailto:help@helpbuttons.org)*
