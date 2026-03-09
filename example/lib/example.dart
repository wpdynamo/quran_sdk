// Example of using the Quran SDK package
// For a complete Flutter app example, see example/lib/main.dart

import 'package:quran_sdk/quran_sdk.dart';

void main() async {
  // Initialize the SDK
  final quran = QuranSDK();
  await quran.initialize();

  print('=== Quran SDK Example ===\n');

  // Example 1: Get a specific verse
  print('1. Get a specific verse:');
  final verse = await quran.getVerse(1, 1);
  print('   Arabic: ${verse?.textArabic}');
  print('   English: ${verse?.textEnglish}\n');

  // Example 2: Get all Surahs
  print('2. Get all Surahs:');
  final surahs = await quran.getSurahs();
  print('   Total Surahs: ${surahs.length}');
  print('   First Surah: ${surahs.first.nameArabic} (${surahs.first.name})\n');

  // Example 3: Search verses
  print('3. Search verses:');
  final results = await quran.search(
    query: 'mercy',
    language: 'english',
    limit: 3,
  );
  print('   Found ${results.length} verses containing "mercy"');
  for (var v in results) {
    final preview = v.textEnglish.length > 50
        ? '${v.textEnglish.substring(0, 50)}...'
        : v.textEnglish;
    print('   - ${v.surah.name} ${v.number}: $preview');
  }
  print('');

  // Example 4: Get Juz information
  print('4. Get Juz information:');
  final juz = await quran.getJuz(1);
  print('   Juz ${juz?.number}: ${juz?.start.surah}:${juz?.start.verse} '
      'to ${juz?.end.surah}:${juz?.end.verse}\n');

  // Example 5: Get page information
  print('5. Get page information:');
  final page = await quran.getPage(1);
  print('   Page ${page?.number}: ${page?.startSurah}:${page?.startVerse} '
      'to ${page?.endSurah}:${page?.endVerse}\n');

  // Example 6: Get Sajda verses
  print('6. Get Sajda verses:');
  final sajdaVerses = await quran.getSajdaVerses();
  print('   Total Sajda verses: ${sajdaVerses.length}');
  if (sajdaVerses.isNotEmpty) {
    print('   First: ${sajdaVerses.first.surahNameArabic} '
        '${sajdaVerses.first.verseNumber} (${sajdaVerses.first.type})\n');
  }

  // Example 7: Get Hizb information
  print('7. Get Hizb information:');
  final hizb = await quran.getHizb(1);
  print('   ${hizb?.displayName}: ${hizb?.start.surah}:${hizb?.start.verse} '
      'to ${hizb?.end.surah}:${hizb?.end.verse}\n');

  // Example 8: Get audio
  print('8. Get audio:');
  final reciters = quran.getReciters();
  print('   Available reciters: ${reciters.length}');
  print('   First reciter: ${reciters.first['name']}');
  final audio = verse?.audio[1];
  print('   Audio URL: ${audio?.url}\n');

  // Example 9: Get random verse
  print('9. Get random verse:');
  final randomVerse = await quran.getRandomVerse();
  print('   ${randomVerse.surah.nameArabic} ${randomVerse.number}');
  print('   ${randomVerse.textArabic}\n');

  print('=== Example Complete ===');
  print('\nFor a complete Flutter app example, see example/lib/main.dart');
}
