# Contributing

Thank you for wanting to contribute to Helpbuttons. This page covers the git workflow and how to get your changes merged.

For coding conventions and naming rules see [Coding Standards](coding-standards.md).
For commit message format see [Commit Conventions](11commit.md).
For opening issues and pull requests see [Issues & PRs](12issues&PR.md).

---

## Git workflow

- The active branch is **`dev`** — always branch from it and open PRs back to it
- **`main`** tracks production releases only
- The live dev instance at [dev.helpbuttons.org](https://dev.helpbuttons.org) auto-deploys from `dev`

```sh
git checkout dev
git pull
git checkout -b feat/my-feature
# ... make changes ...
git push origin feat/my-feature
# open PR → dev
```

## Requirements

- Docker >= 24.0.7 and docker-compose >= 2.23.3
- Node.js >= v20.11.0
- Yarn >= 1.22.21

Set up your local environment following the [Installation Guide](5installation.md).

## Before submitting

- Follow the [Coding Standards](coding-standards.md)
- Write a clear commit message following the [Commit Conventions](11commit.md)
- Link your PR to an existing issue (or create one first for non-trivial changes)
- Describe how you tested the change

## Community

For questions, ideas, or help before opening a PR, join the conversation in our [Telegram channel](https://t.me/+-_0KxKJ427VkYjU0). We're happy to discuss direction before you invest time writing code.
