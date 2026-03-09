/// Represents a Sajda (prostration) verse in the Quran
class Sajda {
  /// Surah number
  final int surahNumber;
  
  /// Verse number
  final int verseNumber;
  
  /// Surah name in English
  final String surahName;
  
  /// Surah name in Arabic
  final String surahNameArabic;
  
  /// Type of Sajda: 'obligatory' or 'recommended'
  final String type;
  
  Sajda({
    required this.surahNumber,
    required this.verseNumber,
    required this.surahName,
    required this.surahNameArabic,
    required this.type,
  });
  
  factory Sajda.fromJson(Map<String, dynamic> json) {
    return Sajda(
      surahNumber: json['surah'] as int,
      verseNumber: json['verse'] as int,
      surahName: json['surahName'] as String,
      surahNameArabic: json['surahNameArabic'] as String,
      type: json['type'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'surah': surahNumber,
      'verse': verseNumber,
      'surahName': surahName,
      'surahNameArabic': surahNameArabic,
      'type': type,
    };
  }
  
  /// Is this an obligatory Sajda
  bool get isObligatory => type == 'obligatory';
  
  /// Is this a recommended Sajda
  bool get isRecommended => type == 'recommended';
  
  @override
  String toString() => '$surahNameArabic ($surahName) $verseNumber - $type';
}
