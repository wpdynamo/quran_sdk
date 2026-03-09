/// Represents a page in the Quran (Mushaf)
class QuranPage {
  /// Page number (1-604)
  final int number;
  
  /// List of verses in this page
  final List<PageVerse> verses;
  
  /// Starting surah number
  final int startSurah;
  
  /// Starting verse number
  final int startVerse;
  
  /// Ending surah number
  final int endSurah;
  
  /// Ending verse number
  final int endVerse;
  
  QuranPage({
    required this.number,
    required this.verses,
    required this.startSurah,
    required this.startVerse,
    required this.endSurah,
    required this.endVerse,
  });
  
  factory QuranPage.fromJson(Map<String, dynamic> json) {
    return QuranPage(
      number: json['number'] as int,
      verses: (json['verses'] as List)
          .map((v) => PageVerse.fromJson(v as Map<String, dynamic>))
          .toList(),
      startSurah: json['start']['surah'] as int,
      startVerse: json['start']['verse'] as int,
      endSurah: json['end']['surah'] as int,
      endVerse: json['end']['verse'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'verses': verses.map((v) => v.toJson()).toList(),
      'start': {'surah': startSurah, 'verse': startVerse},
      'end': {'surah': endSurah, 'verse': endVerse},
    };
  }
  
  @override
  String toString() => 'Page $number: $startSurah:$startVerse to $endSurah:$endVerse';
}

/// Represents a verse reference in a page
class PageVerse {
  /// Surah number
  final int surahNumber;
  
  /// Verse number
  final int verseNumber;
  
  /// Is this the first verse of the surah in this page
  final bool isFirstInSurah;
  
  PageVerse({
    required this.surahNumber,
    required this.verseNumber,
    this.isFirstInSurah = false,
  });
  
  factory PageVerse.fromJson(Map<String, dynamic> json) {
    return PageVerse(
      surahNumber: json['surah'] as int,
      verseNumber: json['verse'] as int,
      isFirstInSurah: json['first'] as bool? ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'surah': surahNumber,
      'verse': verseNumber,
      'first': isFirstInSurah,
    };
  }
  
  @override
  String toString() => '$surahNumber:$verseNumber';
}
