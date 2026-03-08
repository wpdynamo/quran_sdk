/// Represents a Juz (Part) of the Quran
class Juz {
  final int number;
  final JuzPosition start;
  final JuzPosition end;

  const Juz({
    required this.number,
    required this.start,
    required this.end,
  });

  factory Juz.fromJson(Map<String, dynamic> json) {
    return Juz(
      number: json['juz'] as int,
      start: JuzPosition.fromJson(json['start'] as Map<String, dynamic>),
      end: JuzPosition.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

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
  final int surah;
  final int verse;

  const JuzPosition({
    required this.surah,
    required this.verse,
  });

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
