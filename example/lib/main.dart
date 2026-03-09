import 'package:flutter/material.dart';
import 'package:quran_sdk/quran_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran SDK Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final quran = QuranSDK();
  bool isLoading = true;
  String output = '';

  @override
  void initState() {
    super.initState();
    _runExamples();
  }

  Future<void> _runExamples() async {
    setState(() {
      output = 'Initializing Quran SDK...\n';
    });

    await quran.initialize();

    final buffer = StringBuffer();
    buffer.writeln('✓ SDK Initialized\n');

    // Example 1: Get a verse
    final verse = await quran.getVerse(1, 1);
    buffer.writeln('📖 Verse 1:1:');
    buffer.writeln('   ${verse?.textArabic}');
    buffer.writeln('   ${verse?.textEnglish}\n');

    // Example 2: Get surahs
    final surahs = await quran.getSurahs();
    buffer.writeln('📚 Total Surahs: ${surahs.length}');
    buffer.writeln('   First: ${surahs.first.nameArabic}\n');

    // Example 3: Search
    final results = await quran.search(query: 'mercy', language: 'english', limit: 2);
    buffer.writeln('🔍 Search "mercy": ${results.length} results');
    for (var v in results) {
      buffer.writeln('   ${v.surah.name} ${v.number}');
    }
    buffer.writeln('');

    // Example 4: Juz
    final juz = await quran.getJuz(1);
    buffer.writeln('📗 Juz 1: ${juz?.start.surah}:${juz?.start.verse} to ${juz?.end.surah}:${juz?.end.verse}\n');

    // Example 5: Pages
    final pages = await quran.getAllPages();
    buffer.writeln('📄 Total Pages: ${pages.length}\n');

    // Example 6: Sajda
    final sajdaVerses = await quran.getSajdaVerses();
    buffer.writeln('🕌 Sajda Verses: ${sajdaVerses.length}\n');

    // Example 7: Hizb
    final hizbList = await quran.getAllHizb();
    buffer.writeln('📖 Total Hizb: ${hizbList.length}\n');

    // Example 8: Audio
    final reciters = quran.getReciters();
    buffer.writeln('🎵 Reciters: ${reciters.length}');
    buffer.writeln('   ${reciters.first['name']}\n');

    setState(() {
      output = buffer.toString();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran SDK Example'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Text(
                output,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
              ),
            ),
    );
  }
}
