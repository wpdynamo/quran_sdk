# Publishing Guide for quran_sdk

This guide will help you publish the `quran_sdk` package to pub.dev.

## Prerequisites

1. **Dart SDK**: Make sure you have Dart SDK installed
2. **pub.dev Account**: Create an account at [pub.dev](https://pub.dev)
3. **Google Account**: You'll need a Google account to sign in to pub.dev

## Pre-Publishing Checklist

### 1. Verify Package Structure

```bash
cd quran_sdk
flutter pub get
dart analyze
flutter test
```

Make sure:
- ✅ No errors in `dart analyze`
- ✅ All tests pass
- ✅ README.md is complete
- ✅ CHANGELOG.md is updated
- ✅ LICENSE file exists
- ✅ pubspec.yaml has correct metadata

### 2. Check Package Score

Run the pub.dev scoring tool locally:

```bash
dart pub publish --dry-run
```

This will show you:
- Package validation results
- What will be published
- Any warnings or errors

### 3. Verify Package Contents

The package should include:
- `lib/` - All Dart source files
- `assets/data/` - JSON data files (surahs.json, verses.json, juz.json)
- `example/` - Example usage
- `test/` - Unit tests
- `README.md` - Documentation
- `CHANGELOG.md` - Version history
- `LICENSE` - MIT License
- `pubspec.yaml` - Package metadata

## Publishing Steps

### Step 1: Login to pub.dev

```bash
dart pub login
```

This will open a browser window for you to authenticate with your Google account.

### Step 2: Dry Run

Test the publishing process without actually publishing:

```bash
dart pub publish --dry-run
```

Review the output carefully. Make sure:
- All files are included
- No sensitive files are being published
- Package size is reasonable (~4 MB expected)

### Step 3: Publish

If the dry run looks good, publish for real:

```bash
dart pub publish
```

You'll be asked to confirm. Type `y` and press Enter.

### Step 4: Verify on pub.dev

After publishing, visit:
```
https://pub.dev/packages/quran_sdk
```

Check:
- Package appears correctly
- README renders properly
- Example code is visible
- Score is good (aim for 130+)

## Post-Publishing

### 1. Add Package Badge to README

Add this to the top of your README.md:

```markdown
[![pub package](https://img.shields.io/pub/v/quran_sdk.svg)](https://pub.dev/packages/quran_sdk)
```

### 2. Update GitHub Repository

If you have a GitHub repo:

```bash
git tag v0.1.0
git push origin v0.1.0
```

### 3. Announce

Share your package:
- Twitter/X
- Reddit (r/FlutterDev)
- Flutter Community Discord
- LinkedIn

## Updating the Package

When you want to release a new version:

### 1. Update Version

Edit `pubspec.yaml`:
```yaml
version: 0.1.1  # or 0.2.0, 1.0.0, etc.
```

Follow [Semantic Versioning](https://semver.org/):
- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (0.2.0): New features, backward compatible
- **PATCH** (0.1.1): Bug fixes, backward compatible

### 2. Update CHANGELOG.md

Add a new section at the top:

```markdown
## 0.1.1

* Fixed bug in search functionality
* Improved performance
* Updated documentation
```

### 3. Publish Update

```bash
dart pub publish --dry-run
dart pub publish
```

## Common Issues

### Issue: "Package validation failed"

**Solution**: Run `dart analyze` and fix all errors

### Issue: "Package name already exists"

**Solution**: The name `quran_sdk` is already taken. Choose a different name in `pubspec.yaml`

### Issue: "Package size too large"

**Solution**: Check `.gitignore` and make sure you're not including unnecessary files

### Issue: "Missing required fields"

**Solution**: Make sure `pubspec.yaml` has:
- `name`
- `description`
- `version`
- `homepage` or `repository`

## Package Maintenance

### Responding to Issues

Monitor your package on pub.dev for:
- Bug reports
- Feature requests
- Questions

### Keeping Dependencies Updated

Regularly update dependencies:

```bash
flutter pub upgrade
```

### Monitoring Package Score

pub.dev gives your package a score based on:
- Documentation quality
- Code quality
- Platform support
- Null safety
- Maintenance

Aim for a score of 130+ (out of 140).

## Resources

- [Publishing Packages](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [Semantic Versioning](https://semver.org/)
- [pub.dev Help](https://pub.dev/help)

## Support

If you need help:
1. Check [pub.dev documentation](https://dart.dev/tools/pub)
2. Ask on [Flutter Discord](https://discord.gg/flutter)
3. Post on [StackOverflow](https://stackoverflow.com/questions/tagged/flutter) with tag `flutter`

---

Good luck with your package! 🚀
