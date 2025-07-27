# Publishing to pub.dev

This package is ready to be published to pub.dev. Here's how to do it:

## Prerequisites

1. Make sure you have a verified publisher account on pub.dev
2. Update the `homepage`, `repository`, and `issue_tracker` URLs in `pubspec.yaml`
3. Ensure all tests pass: `flutter test`
4. Check package scoring: `dart pub publish --dry-run`

## Publishing Steps

1. **Verify package structure:**
   ```bash
   dart pub publish --dry-run
   ```

2. **Publish to pub.dev:**
   ```bash
   dart pub publish
   ```

## Package Structure

```
glowing_wave_button/
├── lib/
│   ├── glowing_wave_button.dart      # Main export file
│   └── src/
│       └── glowing_wave_button.dart  # Widget implementation
├── example/                          # Example app
│   ├── lib/
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── README.md
├── test/
│   └── glowing_wave_button_test.dart # Unit tests
├── analysis_options.yaml            # Linting rules
├── CHANGELOG.md                      # Version history
├── LICENSE                          # MIT License
├── pubspec.yaml                      # Package configuration
└── README.md                        # Documentation
```

## Before Publishing

- [ ] Update version in `pubspec.yaml`
- [ ] Update `CHANGELOG.md` with new changes
- [ ] Update `homepage`, `repository` URLs in `pubspec.yaml`
- [ ] Ensure all tests pass
- [ ] Run `dart pub publish --dry-run` to check for issues
- [ ] Verify example app works correctly

## Pub.dev Score Optimization

To get a high score on pub.dev:

- ✅ Comprehensive documentation (README.md)
- ✅ Example app included
- ✅ Unit tests included
- ✅ Analysis options configured
- ✅ MIT License included
- ✅ Changelog maintained
- ✅ Proper package structure
- ⚠️ Update repository URLs before publishing
