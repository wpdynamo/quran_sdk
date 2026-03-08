import 'models/surah.dart';
import 'models/verse.dart';
import 'models/juz.dart';
import 'models/audio.dart';
import 'data/data_loader.dart';

/// Main SDK class for accessing Quran data
class QuranSDK {
  bool _initialized = false;

  /// Initialize the SDK (loads data into memory)
  Future<void> initialize() async {
    if (_initialized) return;
    
    await DataLoader.loadSurahs();
    await DataLoader.loadVerses();
    await DataLoader.loadJuz();
    
    _initialized = true;
  }

  /// Ensure SDK is initialized
  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError('QuranSDK not initialized. Call initialize() first.');
    }
  }

  /// Get all Surahs
  Future<List<Surah>> getSurahs() async {
    _ensureInitialized();
    return await DataLoader.loadSurahs();
  }

  /// Get a specific Surah by number (1-114)
  Future<Surah?> getSurah(int surahNumber) async {
    if (surahNumber < 1 || surahNumber > 114) return null;
    
    final surahs = await getSurahs();
    return surahs.firstWhere((s) => s.number == surahNumber);
  }

  /// Get a specific verse
  Future<Verse?> getVerse(int surahNumber, int verseNumber) async {
    _ensureInitialized();
    
    final verses = await DataLoader.loadVerses();
    return verses[surahNumber]?[verseNumber];
  }

  /// Get all verses of a Surah
  Future<List<Verse>> getVersesBySurah(int surahNumber) async {
    _ensureInitialized();
    
    final verses = await DataLoader.loadVerses();
    final surahVerses = verses[surahNumber];
    
    if (surahVerses == null) return [];
    
    return surahVerses.values.toList()..sort((a, b) => a.number.compareTo(b.number));
  }

  /// Get verses by range within a Surah
  Future<List<Verse>> getVersesByRange(
    int surahNumber,
    int fromVerse,
    int toVerse,
  ) async {
    final allVerses = await getVersesBySurah(surahNumber);
    return allVerses.where((v) => v.number >= fromVerse && v.number <= toVerse).toList();
  }

  /// Get a random verse
  Future<Verse> getRandomVerse() async {
    _ensureInitialized();
    
    final verses = await DataLoader.loadVerses();
    final allVerses = <Verse>[];
    
    for (var surahVerses in verses.values) {
      allVerses.addAll(surahVerses.values);
    }
    
    allVerses.shuffle();
    return allVerses.first;
  }

  /// Get all Juz
  Future<List<Juz>> getAllJuz() async {
    _ensureInitialized();
    return await DataLoader.loadJuz();
  }

  /// Get a specific Juz by number (1-30)
  Future<Juz?> getJuz(int juzNumber) async {
    if (juzNumber < 1 || juzNumber > 30) return null;
    
    final juzList = await getAllJuz();
    return juzList.firstWhere((j) => j.number == juzNumber);
  }

  /// Get all verses in a Juz
  Future<List<Verse>> getVersesByJuz(int juzNumber) async {
    final juz = await getJuz(juzNumber);
    if (juz == null) return [];

    final verses = await DataLoader.loadVerses();
    final result = <Verse>[];

    if (juz.start.surah == juz.end.surah) {
      // Same surah
      final surahVerses = verses[juz.start.surah];
      if (surahVerses != null) {
        for (var i = juz.start.verse; i <= juz.end.verse; i++) {
          final verse = surahVerses[i];
          if (verse != null) result.add(verse);
        }
      }
    } else {
      // Multiple surahs
      for (var surahNo = juz.start.surah; surahNo <= juz.end.surah; surahNo++) {
        final surahVerses = verses[surahNo];
        if (surahVerses == null) continue;

        final startVerse = (surahNo == juz.start.surah) ? juz.start.verse : 1;
        final endVerse = (surahNo == juz.end.surah) ? juz.end.verse : surahVerses.length;

        for (var i = startVerse; i <= endVerse; i++) {
          final verse = surahVerses[i];
          if (verse != null) result.add(verse);
        }
      }
    }

    return result;
  }

  /// Search verses by text
  Future<List<Verse>> search({
    required String query,
    String language = 'all', // 'all', 'english', 'arabic'
    int limit = 50,
  }) async {
    _ensureInitialized();
    
    if (query.trim().isEmpty) return [];

    final verses = await DataLoader.loadVerses();
    final results = <Verse>[];
    final queryLower = query.toLowerCase();

    for (var surahVerses in verses.values) {
      for (var verse in surahVerses.values) {
        bool matches = false;

        if (language == 'all' || language == 'english') {
          if (verse.textEnglish.toLowerCase().contains(queryLower)) {
            matches = true;
          }
        }

        if (language == 'all' || language == 'arabic') {
          if (verse.textArabic.contains(query) || 
              verse.textArabicNoTashkeel.contains(query)) {
            matches = true;
          }
        }

        if (matches) {
          results.add(verse);
          if (results.length >= limit) break;
        }
      }
      if (results.length >= limit) break;
    }

    return results;
  }

  /// Get available reciters
  List<Map<String, dynamic>> getReciters() {
    return Audio.reciters.entries.map((entry) {
      return {
        'id': entry.key,
        'name': entry.value['name'],
      };
    }).toList();
  }

  /// Get chapter audio for a specific reciter
  Audio getChapterAudio(int reciterId, int surahNumber) {
    return Audio.forChapter(reciterId, surahNumber);
  }
}
