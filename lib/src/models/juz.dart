/// Represents a Juz (Part) of the Quran
class Juz {
  /// Juz number (1-30)
  final int number;
  
  /// Starting position (surah and verse)
  final JuzPosition start;
  
  /// Ending position (surah and verse)
  final JuzPosition end;

  /// Creates a Juz instance
  const Juz({
    required this.number,
    required this.start,
    required this.end,
  });

  /// Creates a Juz instance from JSON data
  factory Juz.fromJson(Map<String, dynamic> json) {
    return Juz(
      number: json['juz'] as int,
      start: JuzPosition.fromJson(json['start'] as Map<String, dynamic>),
      end: JuzPosition.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  /// Converts the Juz instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'juz': number,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }

  @override
  String toString() => 'Juz($number: ${start.surah}:${start.verse} - ${end.surah}:${end.verse})';
}

/// Represents a position in the Quran (Surah and Verse)
class JuzPosition {
  /// Surah number (1-114)
  final int surah;
  
  /// Verse number within the surah
  final int verse;

  /// Creates a JuzPosition instance
  const JuzPosition({
    required this.surah,
    required this.verse,
  });

  /// Creates a JuzPosition instance from JSON data
  factory JuzPosition.fromJson(Map<String, dynamic> json) {
    return JuzPosition(
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
