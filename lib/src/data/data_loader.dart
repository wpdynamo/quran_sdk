import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah.dart';
import '../models/verse.dart';
import '../models/juz.dart';
import '../models/page.dart';
import '../models/sajda.dart';
import '../models/hizb.dart';

/// Loads and caches Quran data from assets
class DataLoader {
  static List<Surah>? _surahs;
  static Map<int, Map<int, Verse>>? _verses; // surahNo -> ayahNo -> Verse
  static List<Juz>? _juz;
  static List<QuranPage>? _pages;
  static List<Sajda>? _sajdaVerses;
  static List<Hizb>? _hizbList;

  /// Load all Surahs
  static Future<List<Surah>> loadSurahs() async {
    if (_surahs != null) return _surahs!;

    final jsonString = await rootBundle.loadString('packages/quran_sdk/assets/data/surahs.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    _surahs = jsonList.map((json) => Surah.fromJson(json)).toList();
    return _surahs!;
  }

  /// Load all verses
  static Future<Map<int, Map<int, Verse>>> loadVerses() async {
    if (_verses != null) return _verses!;

    final surahs = await loadSurahs();
    final surahMap = {for (var s in surahs) s.number: s};

    final jsonString = await rootBundle.loadString('packages/quran_sdk/assets/data/verses.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    _verses = {};
    for (var json in jsonList) {
      final surahNo = json['surah_no'] as int;
      final ayahNo = json['ayah_no'] as int;
      final surah = surahMap[surahNo]!;
      
      _verses![surahNo] ??= {};
      _verses![surahNo]![ayahNo] = Verse.fromJson(json, surah);
    }

    return _verses!;
  }

  /// Load all Juz
  static Future<List<Juz>> loadJuz() async {
    if (_juz != null) return _juz!;

    final jsonString = await rootBundle.loadString('packages/quran_sdk/assets/data/juz.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    _juz = jsonList.map((json) => Juz.fromJson(json)).toList();
    return _juz!;
  }

  /// Clear cache (useful for testing)
  static void clearCache() {
    _surahs = null;
    _verses = null;
    _juz = null;
    _pages = null;
    _sajdaVerses = null;
    _hizbList = null;
  }
  
  /// Load all pages (604 pages)
  static Future<List<QuranPage>> loadPages() async {
    if (_pages != null) return _pages!;
    
    final jsonString = await rootBundle.loadString('packages/quran_sdk/assets/data/pages.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    _pages = jsonList.map((json) => QuranPage.fromJson(json)).toList();
    return _pages!;
  }
  
  /// Load all Sajda verses (15 verses)
  static Future<List<Sajda>> loadSajdaVerses() async {
    if (_sajdaVerses != null) return _sajdaVerses!;
    
    final jsonString = await rootBundle.loadString('packages/quran_sdk/assets/data/sajda.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    _sajdaVerses = jsonList.map((json) => Sajda.fromJson(json)).toList();
    return _sajdaVerses!;
  }
  
  /// Load all Hizb (60 Hizb)
  static Future<List<Hizb>> loadHizb() async {
    if (_hizbList != null) return _hizbList!;
    
    final jsonString = await rootBundle.loadString('packages/quran_sdk/assets/data/hizb.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    _hizbList = jsonList.map((json) => Hizb.fromJson(json)).toList();
    return _hizbList!;
  }
}
