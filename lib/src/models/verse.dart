import 'surah.dart';
import 'audio.dart';

/// Represents a Verse (Ayah) of the Quran
class Verse {
  final Surah surah;
  final int number;
  final String textArabic;
  final String textArabicNoTashkeel;
  final String textEnglish;
  final Map<int, Audio> audio;

  const Verse({
    required this.surah,
    required this.number,
    required this.textArabic,
    required this.textArabicNoTashkeel,
    required this.textEnglish,
    required this.audio,
  });

  factory Verse.fromJson(Map<String, dynamic> json, Surah surah) {
    // Generate audio for all 5 reciters
    final audio = <int, Audio>{};
    for (int i = 1; i <= 5; i++) {
      audio[i] = Audio.forVerse(i, surah.number, json['ayah_no'] as int);
    }

    return Verse(
      surah: surah,
      number: json['ayah_no'] as int,
      textArabic: json['text_arabic_with_tashkeel'] as String,
      textArabicNoTashkeel: json['text_arabic_without_tashkeel'] as String,
      textEnglish: json['text_english'] as String,
      audio: audio,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah': surah.toJson(),
      'verse': {
        'number': number,
        'text': {
          'arabic': textArabic,
          'arabic_no_tashkeel': textArabicNoTashkeel,
          'english': textEnglish,
        },
      },
      'audio': audio.map((key, value) => MapEntry(key.toString(), value.toJson())),
    };
  }

  @override
  String toString() => 'Verse(${surah.number}:$number)';
}
