# Changelog

All notable changes to this project will be documented in this file.

## [0.1.8] - 2026-03-09

### Fixed
- Cleaned up example directory structure
- Removed duplicate main.dart from example root
- Example now properly structured for pub.dev recognition

## [0.1.7] - 2026-03-09

### Added
- Complete example.md with comprehensive usage examples
- Dart console example (example/example.dart)
- Complete dartdoc documentation for Juz and JuzPosition models
- Multiple example formats for different use cases

### Improved
- Documentation coverage now at 76/117 (65%)
- Better example structure following Dart guidelines
- Complete API documentation for all public models

## [0.1.6] - 2026-03-09

### Added
- Proper Flutter example app (instead of simple Dart script)
- Complete dartdoc documentation for Hizb and HizbPosition models
- Example app with pubspec.yaml and proper structure

### Improved
- Example now follows Dart package layout guidelines
- Better documentation coverage for pub.dev score

## [0.1.5] - 2026-03-09

### Added
- Complete dartdoc documentation for Audio model
- Example directory with working example code
- Example README with usage instructions

### Improved
- Documentation coverage for better pub.dev score
- Code examples for easier onboarding

## [0.1.4] - 2026-03-09

### Added
- Complete metadata for all 6,236 verses:
  - `pageNumber` field now populated for all verses (1-604)
  - `hizbNumber` field now populated for all verses (1-60)
  - `sajda` and `sajdaType` fields for 15 Sajda verses
- Python script `update_verses_with_metadata.py` for automated metadata updates

### Changed
- Updated `verses.json` with complete metadata for all verses
- Improved `Verse` model to properly read `hizb` field from JSON

### Fixed
- Fixed metadata consistency across all verses
- Ensured all verses have proper page and hizb assignments

## [0.1.3] - 2026-03-09

### Changed
- Simplified Audio model by removing unused `urlOriginal` field
- Audio model now uses single `url` field pointing to EveryAyah.com
- Updated documentation to reflect Audio model changes

### Fixed
- Removed redundant audio URL field that was not functional

## [0.1.2] - 2026-03-09

### Added
- **Pages System**: Added support for 604 Quran pages (Mushaf pages)
  - `getAllPages()` - Get all 604 pages
  - `getPage(pageNumber)` - Get a specific page
  - `getPageNumber(surah, verse)` - Get page number for a verse
  - `getVersesByPage(pageNumber)` - Get all verses in a page
  
- **Sajda Verses**: Added support for 15 Sajda (prostration) verses
  - `getSajdaVerses()` - Get all 15 Sajda verses
  - `getSajdaVersesWithText()` - Get Sajda verses with full text
  - `isSajdaVerse(surah, verse)` - Check if a verse is Sajda
  - Includes type information (obligatory/recommended)
  
- **Hizb System**: Added support for 60 Hizb (quarters)
  - `getAllHizb()` - Get all 60 Hizb
  - `getHizb(hizbNumber)` - Get a specific Hizb
  - `getVersesByHizb(hizbNumber)` - Get all verses in a Hizb
  - Each Hizb divided into 4 quarters (240 total)

### Changed
- Updated `Verse` model to include:
  - `pageNumber` - Page number in Mushaf (1-604)
  - `hizbNumber` - Hizb number (1-60)
  - `isSajda` - Boolean flag for Sajda verses
  - `sajdaType` - Type of Sajda (obligatory/recommended)

### Technical
- Added new models: `QuranPage`, `PageVerse`, `Sajda`, `Hizb`, `HizbPosition`
- Updated `DataLoader` to load new data files
- Added new JSON data files: `pages.json`, `sajda.json`, `hizb.json`

## [0.1.1] - 2026-03-08

### Added
- Initial release
- 114 Surahs with complete information
- 6,236 verses with Arabic (with/without Tashkeel) and English translations
- 30 Juz support
- Audio support for 5 famous reciters
- Advanced search functionality
- Offline-first approach with embedded data

### Features
- Get Surahs, verses, and Juz
- Search in Arabic and English
- Audio links for verses and chapters
- Random verse functionality
- Complete offline support

## [0.1.0] - 2026-03-07

### Added
- Initial development version
