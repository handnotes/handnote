# Handnote

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/handnotes/handnote/Test?style=for-the-badge)](https://github.com/handnotes/handnote/actions/workflows/test.yml)
[![Codecov](https://img.shields.io/codecov/c/github/handnotes/handnote?style=for-the-badge&token=0GPY49D81Q)](https://app.codecov.io/gh/handnotes/handnote)

Flutter client for handnote.

## Getting Started

```bash
flutter run
flutter test -d macos integration_test
```

## Generate module

If you change the model, you need to regenerate the model database.

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```
