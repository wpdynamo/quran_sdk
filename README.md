# 📖 Quran SDK

Offline-first Quran SDK for Flutter with complete Arabic and English translations, audio support, and search functionality.

[![pub package](https://img.shields.io/pub/v/quran_sdk.svg)](https://pub.dev/packages/quran_sdk)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 🌐 **Multi-Language**: Arabic (with/without Tashkeel) and English translations
- 📴 **Offline-First**: All Quran data embedded in the package (no API calls needed)
- 🎵 **Audio Support**: Links to 5 famous reciters for every verse and chapter
- 🔍 **Search**: Search verses in Arabic or English
- 📚 **Juz Support**: Access all 30 Juz (parts) of the Quran
- 🎲 **Random Verse**: Get random verses
- ⚡ **Fast**: All data loaded into memory for instant access
- 🎯 **Simple API**: Easy-to-use methods for all operations

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  quran_sdk: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

```dart
import 'package:quran_sdk/quran_sdk.dart';

void main() async {
  // Initialize the SDK
  final quran = QuranSDK();
  await quran.initialize();

  // Get a specific verse
  final verse = await quran.getVerse(1, 1);
  print(verse?.textEnglish);
  // Output: In the Name of Allah—the Most Compassionate, Most Merciful.

  // Get all Surahs
  final surahs = await quran.getSurahs();
  print('Total Surahs: ${surahs.length}');

  // Search verses
  final results = await quran.search(query: 'mercy', language: 'english');
  print('Found ${results.length} verses');
}
```

## 📚 Usage Examples

### Get a Surah

```dart
final surah = await quran.getSurah(1);
print('${surah?.name} - ${surah?.nameArabic}');
print('Total verses: ${surah?.totalVerses}');
```

### Get All Verses of a Surah

```dart
final verses = await quran.getVersesBySurah(112);
for (var verse in verses) {
  print('${verse.number}: ${verse.textArabic}');
}
```

### Get Verses by Range

```dart
final verses = await quran.getVersesByRange(2, 1, 5);
// Get verses 1-5 from Surah 2
```

### Search Verses

```dart
// Search in English
final results = await quran.search(
  query: 'paradise',
  language: 'english',
  limit: 10,
);

// Search in Arabic
final results = await quran.search(
  query: 'الله',
  language: 'arabic',
  limit: 10,
);

// Search in all languages
final results = await quran.search(
  query: 'mercy',
  language: 'all',
);
```

### Get Random Verse

```dart
final verse = await quran.getRandomVerse();
print('${verse.surah.name} ${verse.number}: ${verse.textEnglish}');
```

### Get Juz Information

```dart
// Get all Juz
final juzList = await quran.getAllJuz();

// Get specific Juz
final juz = await quran.getJuz(1);
print('Juz ${juz?.number}: ${juz?.start} to ${juz?.end}');

// Get all verses in a Juz
final verses = await quran.getVersesByJuz(1);
print('Juz 1 has ${verses.length} verses');
```

### Audio Support

```dart
// Get available reciters
final reciters = quran.getReciters();
for (var reciter in reciters) {
  print('${reciter['id']}: ${reciter['name']}');
}

// Get verse audio
final verse = await quran.getVerse(1, 1);
final audio = verse?.audio[1]; // Reciter ID 1 (Mishary Al Afasy)
print('Audio URL: ${audio?.urlOriginal}');

// Get chapter audio
final chapterAudio = quran.getChapterAudio(1, 112);
print('Chapter audio: ${chapterAudio.url}');
```

## 🎵 Available Reciters

1. Mishary Rashid Al Afasy
2. Abu Bakr Al Shatri
3. Nasser Al Qatami
4. Yasser Al Dosari
5. Hani Ar Rifai

## 📊 Data Models

### Surah

```dart
class Surah {
  final int number;
  final String name;
  final String nameArabic;
  final String nameArabicLong;
  final String translation;
  final String revelationPlace;
  final int totalVerses;
}
```

### Verse

```dart
class Verse {
  final Surah surah;
  final int number;
  final String textArabic;
  final String textArabicNoTashkeel;
  final String textEnglish;
  final Map<int, Audio> audio;
}
```

### Juz

```dart
class Juz {
  final int number;
  final JuzPosition start;
  final JuzPosition end;
}

class JuzPosition {
  final int surah;
  final int verse;
}
```

### Audio

```dart
class Audio {
  final int reciterId;
  final String reciterName;
  final String url;
  final String urlOriginal;
}
```

## 💾 Package Size

The package includes all Quran data embedded as JSON files:
- Surahs: ~30 KB
- Verses: ~3.7 MB
- Juz: ~1 KB

Total embedded data: ~3.8 MB

## 🔧 Advanced Usage

### Initialize Once

```dart
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final quran = QuranSDK();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeQuran();
  }

  Future<void> _initializeQuran() async {
    await quran.initialize();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    // Use quran SDK here
  }
}
```

### Use with Provider

```dart
class QuranProvider extends ChangeNotifier {
  final QuranSDK quran = QuranSDK();
  bool isInitialized = false;

  Future<void> initialize() async {
    await quran.initialize();
    isInitialized = true;
    notifyListeners();
  }
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Credits

- **Data Source**: [Quran.com](https://quran.com)
- **Audio**: [EveryAyah.com](https://everyayah.com)
- **Translation**: Clear Quran English Translation

## 📧 Support

For issues and questions, please visit the [GitHub repository](https://github.com/mahmmoudeid/quran_sdk).

---

Made with ❤️ for the Muslim community by [WP Dynamo](https://wpdynamo.com/)
