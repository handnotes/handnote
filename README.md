# Handnote

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
