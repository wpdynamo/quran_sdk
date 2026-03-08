import 'package:flutter_test/flutter_test.dart';
import 'package:quran_sdk/quran_sdk.dart';

void main() {
  group('QuranSDK', () {
    late QuranSDK quran;

    setUp(() {
      quran = QuranSDK();
    });

    test('should initialize successfully', () async {
      await quran.initialize();
      expect(quran, isNotNull);
    });

    test('should get all surahs', () async {
      await quran.initialize();
      final surahs = await quran.getSurahs();
      expect(surahs.length, 114);
    });

    test('should get specific surah', () async {
      await quran.initialize();
      final surah = await quran.getSurah(1);
      expect(surah?.name, 'Al-Faatiha');
      expect(surah?.totalVerses, 7);
    });

    test('should get specific verse', () async {
      await quran.initialize();
      final verse = await quran.getVerse(1, 1);
      expect(verse?.surah.number, 1);
      expect(verse?.number, 1);
      expect(verse?.textEnglish, isNotEmpty);
    });

    test('should search verses', () async {
      await quran.initialize();
      final results = await quran.search(query: 'Allah', language: 'english');
      expect(results, isNotEmpty);
    });

    test('should get random verse', () async {
      await quran.initialize();
      final verse = await quran.getRandomVerse();
      expect(verse, isNotNull);
      expect(verse.textEnglish, isNotEmpty);
    });

    test('should get all juz', () async {
      await quran.initialize();
      final juzList = await quran.getAllJuz();
      expect(juzList.length, 30);
    });

    test('should get specific juz', () async {
      await quran.initialize();
      final juz = await quran.getJuz(1);
      expect(juz?.number, 1);
      expect(juz?.start.surah, 1);
    });

    test('should get reciters', () {
      final reciters = quran.getReciters();
      expect(reciters.length, 5);
    });
  });
}
