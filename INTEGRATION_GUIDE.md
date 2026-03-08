# Integration Guide

This guide shows you how to integrate `quran_sdk` into your Flutter application.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  quran_sdk: ^0.1.0
```

Run:
```bash
flutter pub get
```

## Basic Integration

### 1. Simple Usage (Stateless)

```dart
import 'package:flutter/material.dart';
import 'package:quran_sdk/quran_sdk.dart';

class QuranPage extends StatelessWidget {
  final quran = QuranSDK();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        
        final verse = snapshot.data as Verse;
        return Text(verse.textEnglish);
      },
    );
  }

  Future<Verse> _loadData() async {
    await quran.initialize();
    return await quran.getVerse(1, 1) ?? Verse(...);
  }
}
```

### 2. Stateful Widget

```dart
import 'package:flutter/material.dart';
import 'package:quran_sdk/quran_sdk.dart';

class QuranPage extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final quran = QuranSDK();
  bool isLoading = true;
  List<Surah> surahs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await quran.initialize();
    final data = await quran.getSurahs();
    setState(() {
      surahs = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return ListTile(
          title: Text(surah.name),
          subtitle: Text(surah.nameArabic),
          trailing: Text('${surah.totalVerses} verses'),
        );
      },
    );
  }
}
```

## Advanced Integration

### 1. Using Provider (Recommended)

First, add provider to `pubspec.yaml`:
```yaml
dependencies:
  provider: ^6.0.0
  quran_sdk: ^0.1.0
```

Create a provider:

```dart
import 'package:flutter/foundation.dart';
import 'package:quran_sdk/quran_sdk.dart';

class QuranProvider extends ChangeNotifier {
  final QuranSDK _quran = QuranSDK();
  bool _isInitialized = false;
  
  bool get isInitialized => _isInitialized;
  QuranSDK get quran => _quran;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    await _quran.initialize();
    _isInitialized = true;
    notifyListeners();
  }

  Future<List<Surah>> getSurahs() async {
    return await _quran.getSurahs();
  }

  Future<Verse?> getVerse(int surahNo, int verseNo) async {
    return await _quran.getVerse(surahNo, verseNo);
  }

  Future<List<Verse>> search(String query, {String language = 'all'}) async {
    return await _quran.search(query: query, language: language);
  }
}
```

Setup in main.dart:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuranProvider()..initialize(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuranHomePage(),
    );
  }
}
```

Use in widgets:

```dart
class QuranHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuranProvider>(context);

    if (!provider.isInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Quran')),
      body: FutureBuilder<List<Surah>>(
        future: provider.getSurahs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final surah = snapshot.data![index];
              return ListTile(
                title: Text(surah.name),
                subtitle: Text(surah.nameArabic),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SurahDetailPage(surah: surah),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
```

### 2. Using GetX

Add GetX to `pubspec.yaml`:
```yaml
dependencies:
  get: ^4.6.0
  quran_sdk: ^0.1.0
```

Create a controller:

```dart
import 'package:get/get.dart';
import 'package:quran_sdk/quran_sdk.dart';

class QuranController extends GetxController {
  final QuranSDK _quran = QuranSDK();
  final isInitialized = false.obs;
  final surahs = <Surah>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    await _quran.initialize();
    isInitialized.value = true;
    await loadSurahs();
  }

  Future<void> loadSurahs() async {
    surahs.value = await _quran.getSurahs();
  }

  Future<Verse?> getVerse(int surahNo, int verseNo) async {
    return await _quran.getVerse(surahNo, verseNo);
  }

  Future<List<Verse>> search(String query) async {
    return await _quran.search(query: query);
  }
}
```

Use in widgets:

```dart
class QuranPage extends StatelessWidget {
  final controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quran')),
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.surahs.length,
          itemBuilder: (context, index) {
            final surah = controller.surahs[index];
            return ListTile(
              title: Text(surah.name),
              subtitle: Text(surah.nameArabic),
            );
          },
        );
      }),
    );
  }
}
```

## Common Use Cases

### 1. Display Surah List

```dart
FutureBuilder<List<Surah>>(
  future: quran.getSurahs(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final surah = snapshot.data![index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${surah.number}')),
            title: Text(surah.name),
            subtitle: Text('${surah.nameArabic} • ${surah.totalVerses} verses'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  },
)
```

### 2. Display Verses

```dart
FutureBuilder<List<Verse>>(
  future: quran.getVersesBySurah(1),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final verse = snapshot.data![index];
        return Card(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  verse.textArabic,
                  style: TextStyle(fontSize: 24, fontFamily: 'Amiri'),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 8),
                Text(
                  verse.textEnglish,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Verse ${verse.number}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
)
```

### 3. Search Functionality

```dart
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final quran = QuranSDK();
  final searchController = TextEditingController();
  List<Verse> results = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    quran.initialize();
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      setState(() => results = []);
      return;
    }

    setState(() => isSearching = true);
    
    final searchResults = await quran.search(
      query: query,
      language: 'all',
      limit: 50,
    );
    
    setState(() {
      results = searchResults;
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Quran...',
            border: InputBorder.none,
          ),
          onSubmitted: _search,
        ),
      ),
      body: isSearching
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final verse = results[index];
                return ListTile(
                  title: Text(verse.textEnglish),
                  subtitle: Text('${verse.surah.name} ${verse.number}'),
                );
              },
            ),
    );
  }
}
```

### 4. Audio Player

```dart
import 'package:audioplayers/audioplayers.dart';

class VerseAudioPlayer extends StatefulWidget {
  final Verse verse;
  final int reciterId;

  VerseAudioPlayer({required this.verse, this.reciterId = 1});

  @override
  _VerseAudioPlayerState createState() => _VerseAudioPlayerState();
}

class _VerseAudioPlayerState extends State<VerseAudioPlayer> {
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (isPlaying) {
      await player.pause();
    } else {
      final audio = widget.verse.audio[widget.reciterId]!;
      await player.play(UrlSource(audio.urlOriginal));
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      onPressed: _togglePlay,
    );
  }
}
```

## Performance Tips

1. **Initialize Once**: Initialize the SDK once in your app's lifecycle (in main.dart or a provider)

2. **Cache Results**: The SDK already caches data in memory, but you can cache UI results:
   ```dart
   final _cachedSurahs = <Surah>[];
   
   Future<List<Surah>> getSurahs() async {
     if (_cachedSurahs.isEmpty) {
       _cachedSurahs.addAll(await quran.getSurahs());
     }
     return _cachedSurahs;
   }
   ```

3. **Lazy Loading**: Load verses only when needed, not all at once

4. **Use ListView.builder**: Always use builder constructors for large lists

## Troubleshooting

### Issue: "Unable to load asset"

Make sure you've run `flutter pub get` after adding the package.

### Issue: "StateError: QuranSDK not initialized"

Always call `await quran.initialize()` before using any methods.

### Issue: "Slow initialization"

The first initialization loads ~4MB of data. Consider showing a splash screen:

```dart
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final quran = QuranSDK();
    await quran.initialize();
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading Quran...', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```

---

Need more help? Check the [example](example/main.dart) or open an issue on GitHub!
