/// Represents a Surah (Chapter) of the Quran
class Surah {
  final int number;
  final String name;
  final String nameArabic;
  final String nameArabicLong;
  final String translation;
  final String revelationPlace;
  final int totalVerses;

  const Surah({
    required this.number,
    required this.name,
    required this.nameArabic,
    required this.nameArabicLong,
    required this.translation,
    required this.revelationPlace,
    required this.totalVerses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['surah_no'] as int,
      name: json['surah_name'] as String,
      nameArabic: json['surah_name_ar'] as String,
      nameArabicLong: json['surah_name_ar_long'] as String,
      translation: json['surah_name_translation'] as String,
      revelationPlace: json['revelation_place'] as String,
      totalVerses: json['total_ayah'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'name_arabic': nameArabic,
      'name_arabic_long': nameArabicLong,
      'translation': translation,
      'revelation_place': revelationPlace,
      'total_verses': totalVerses,
    };
  }

  @override
  String toString() => 'Surah($number: $name - $nameArabic)';
}
