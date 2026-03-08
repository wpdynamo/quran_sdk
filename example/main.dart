import 'package:quran_sdk/quran_sdk.dart';

void main() async {
  print('🕌 Quran SDK Example\n');

  // Initialize the SDK
  final quran = QuranSDK();
  print('Initializing Quran SDK...');
  await quran.initialize();
  print('✓ SDK initialized\n');

  // Example 1: Get a specific verse
  print('--- Example 1: Get a specific verse ---');
  final verse = await quran.getVerse(1, 1);
  if (verse != null) {
    print('Surah: ${verse.surah.name} (${verse.surah.nameArabic})');
    print('Verse ${verse.number}:');
    print('Arabic: ${verse.textArabic}');
    print('English: ${verse.textEnglish}');
  }
  print('');

  // Example 2: Get all Surahs
  print('--- Example 2: Get all Surahs ---');
  final surahs = await quran.getSurahs();
  print('Total Surahs: ${surahs.length}');
  print('First 5 Surahs:');
  for (var i = 0; i < 5; i++) {
    final surah = surahs[i];
    print('${surah.number}. ${surah.name} (${surah.nameArabic}) - ${surah.totalVerses} verses');
  }
  print('');

  // Example 3: Get all verses of a Surah
  print('--- Example 3: Get all verses of Surah Al-Ikhlaas (112) ---');
  final surahVerses = await quran.getVersesBySurah(112);
  for (var verse in surahVerses) {
    print('${verse.number}. ${verse.textArabic}');
    print('   ${verse.textEnglish}');
  }
  print('');

  // Example 4: Search verses
  print('--- Example 4: Search for "mercy" in English ---');
  final searchResults = await quran.search(
    query: 'mercy',
    language: 'english',
    limit: 3,
  );
  print('Found ${searchResults.length} verses:');
  for (var verse in searchResults) {
    print('${verse.surah.name} ${verse.number}: ${verse.textEnglish}');
  }
  print('');

  // Example 5: Get random verse
  print('--- Example 5: Get a random verse ---');
  final randomVerse = await quran.getRandomVerse();
  print('${randomVerse.surah.name} ${randomVerse.number}:');
  print('${randomVerse.textEnglish}');
  print('');

  // Example 6: Get Juz information
  print('--- Example 6: Get Juz 1 information ---');
  final juz = await quran.getJuz(1);
  if (juz != null) {
    print('Juz ${juz.number}');
    print('Start: Surah ${juz.start.surah}, Verse ${juz.start.verse}');
    print('End: Surah ${juz.end.surah}, Verse ${juz.end.verse}');
    
    final juzVerses = await quran.getVersesByJuz(1);
    print('Total verses in Juz 1: ${juzVerses.length}');
  }
  print('');

  // Example 7: Get audio information
  print('--- Example 7: Get audio for a verse ---');
  final verseWithAudio = await quran.getVerse(1, 1);
  if (verseWithAudio != null) {
    print('Available reciters:');
    final reciters = quran.getReciters();
    for (var reciter in reciters) {
      final audio = verseWithAudio.audio[reciter['id']];
      print('${reciter['id']}. ${reciter['name']}');
      print('   URL: ${audio?.urlOriginal}');
    }
  }
  print('');

  // Example 8: Get chapter audio
  print('--- Example 8: Get chapter audio ---');
  final chapterAudio = quran.getChapterAudio(1, 112);
  print('Surah Al-Ikhlaas by ${chapterAudio.reciterName}');
  print('Audio URL: ${chapterAudio.url}');
  print('');

  print('✓ All examples completed!');
}
