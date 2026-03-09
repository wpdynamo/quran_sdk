# Changelog

All notable changes to this project will be documented in this file.

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
