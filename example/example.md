# Quran SDK Example

This example demonstrates how to use the Quran SDK package in your Flutter or Dart applications.

## Quick Start

```dart
import 'package:quran_sdk/quran_sdk.dart';

void main() async {
  // Initialize the SDK
  final quran = QuranSDK();
  await quran.initialize();

  // Get a specific verse
  final verse = await quran.getVerse(1, 1);
  print(verse?.textArabic);
  print(verse?.textEnglish);
}
```

## Features Demonstrated

### 1. Get Verses

```dart
// Get a specific verse
final verse = await quran.getVerse(1, 1);

// Get all verses of a surah
final verses = await quran.getVersesBySurah(112);

// Get verses by range
final verses = await quran.getVersesByRange(2, 1, 5);
```

### 2. Get Surahs

```dart
// Get all surahs
final surahs = await quran.getSurahs();

// Get a specific surah
final surah = await quran.getSurah(1);
```

### 3. Search

```dart
// Search in English
final results = await quran.search(
  query: 'mercy',
  language: 'english',
  limit: 10,
);

// Search in Arabic
final results = await quran.search(
  query: 'الله',
  language: 'arabic',
);
```

### 4. Juz (Parts)

```dart
// Get all Juz
final juzList = await quran.getAllJuz();

// Get specific Juz
final juz = await quran.getJuz(1);

// Get all verses in a Juz
final verses = await quran.getVersesByJuz(1);
```

### 5. Pages

```dart
// Get all pages (604 pages)
final pages = await quran.getAllPages();

// Get a specific page
final page = await quran.getPage(1);

// Get page number for a verse
final pageNum = await quran.getPageNumber(2, 1);

// Get all verses in a page
final verses = await quran.getVersesByPage(1);
```

### 6. Sajda Verses

```dart
// Get all Sajda verses (15 verses)
final sajdaVerses = await quran.getSajdaVerses();

// Get Sajda verses with full text
final verses = await quran.getSajdaVersesWithText();

// Check if a verse is Sajda
final isSajda = await quran.isSajdaVerse(32, 15);
```

### 7. Hizb (Quarters)

```dart
// Get all Hizb (60 Hizb)
final hizbList = await quran.getAllHizb();

// Get a specific Hizb
final hizb = await quran.getHizb(1);

// Get all verses in a Hizb
final verses = await quran.getVersesByHizb(1);
```

### 8. Audio

```dart
// Get available reciters
final reciters = quran.getReciters();

// Get verse audio
final verse = await quran.getVerse(1, 1);
final audio = verse?.audio[1]; // Reciter ID 1
print(audio?.url);

// Get chapter audio
final chapterAudio = quran.getChapterAudio(1, 112);
print(chapterAudio.url);
```

### 9. Random Verse

```dart
final verse = await quran.getRandomVerse();
print('${verse.surah.name} ${verse.number}: ${verse.textEnglish}');
```

## Available Reciters

1. Mishary Rashid Al Afasy
2. Abu Bakr Al Shatri
3. Nasser Al Qatami
4. Yasser Al Dosari
5. Hani Ar Rifai

## Running the Examples

### Dart Console Example

```bash
dart run example/example.dart
```

### Flutter App Example

```bash
cd example
flutter pub get
flutter run
```

## More Information

For complete API documentation, visit:
- [Package Documentation](https://pub.dev/documentation/quran_sdk/latest/)
- [GitHub Repository](https://github.com/wpdynamo/quran_sdk)
- [Main README](../README.md)
