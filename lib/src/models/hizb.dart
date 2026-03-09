/// Represents a Hizb (one-sixtieth) of the Quran
class Hizb {
  /// Hizb number (1-60)
  final int number;
  
  /// Quarter number within the Hizb (1-4)
  final int quarter;
  
  /// Starting position
  final HizbPosition start;
  
  /// Ending position
  final HizbPosition end;
  
  Hizb({
    required this.number,
    required this.quarter,
    required this.start,
    required this.end,
  });
  
  factory Hizb.fromJson(Map<String, dynamic> json) {
    return Hizb(
      number: json['number'] as int,
      quarter: json['quarter'] as int,
      start: HizbPosition.fromJson(json['start'] as Map<String, dynamic>),
      end: HizbPosition.fromJson(json['end'] as Map<String, dynamic>),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'quarter': quarter,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
  
  /// Display name in Arabic
  String get displayName => 'الحزب $number - الربع $quarter';
  
  /// Display name in English
  String get displayNameEnglish => 'Hizb $number - Quarter $quarter';
  
  @override
  String toString() => 'Hizb $number (Q$quarter): ${start.toString()} to ${end.toString()}';
}

/// Represents a position (surah and verse) in the Quran
class HizbPosition {
  /// Surah number
  final int surah;
  
  /// Verse number
  final int verse;
  
  HizbPosition({
    required this.surah,
    required this.verse,
  });
  
  factory HizbPosition.fromJson(Map<String, dynamic> json) {
    return HizbPosition(
      surah: json['surah'] as int,
      verse: json['verse'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'surah': surah,
      'verse': verse,
    };
  }
  
  @override
  String toString() => '$surah:$verse';
}
