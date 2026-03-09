/// Represents audio recitation information
class Audio {
  final int reciterId;
  final String reciterName;
  final String url;

  const Audio({
    required this.reciterId,
    required this.reciterName,
    required this.url,
  });

  /// Reciter information
  static const Map<int, Map<String, String>> reciters = {
    1: {
      'name': 'Mishary Rashid Al Afasy',
      'slug': 'Alafasy_128kbps',
      'chapter_url': 'https://server8.mp3quran.net/afs',
    },
    2: {
      'name': 'Abu Bakr Al Shatri',
      'slug': 'Abu_Bakr_Ash-Shaatree_128kbps',
      'chapter_url': 'https://server11.mp3quran.net/shatri',
    },
    3: {
      'name': 'Nasser Al Qatami',
      'slug': 'Nasser_Alqatami_128kbps',
      'chapter_url': 'https://server6.mp3quran.net/qtm',
    },
    4: {
      'name': 'Yasser Al Dosari',
      'slug': 'Yasser_Ad-Dussary_128kbps',
      'chapter_url': 'https://server11.mp3quran.net/yasser',
    },
    5: {
      'name': 'Hani Ar Rifai',
      'slug': 'Hani_Rifai_192kbps',
      'chapter_url': 'https://server8.mp3quran.net/hani',
    },
  };

  /// Create Audio for a specific verse
  factory Audio.forVerse(int reciterId, int surahNo, int verseNo) {
    final reciter = reciters[reciterId]!;
    final surahPadded = surahNo.toString().padLeft(3, '0');
    final versePadded = verseNo.toString().padLeft(3, '0');

    return Audio(
      reciterId: reciterId,
      reciterName: reciter['name']!,
      url: 'https://everyayah.com/data/${reciter['slug']}/$surahPadded$versePadded.mp3',
    );
  }

  /// Create Audio for a complete chapter
  factory Audio.forChapter(int reciterId, int surahNo) {
    final reciter = reciters[reciterId]!;
    final surahPadded = surahNo.toString().padLeft(3, '0');

    return Audio(
      reciterId: reciterId,
      reciterName: reciter['name']!,
      url: '${reciter['chapter_url']}/$surahPadded.mp3',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reciter_id': reciterId,
      'reciter_name': reciterName,
      'url': url,
    };
  }

  @override
  String toString() => 'Audio($reciterName)';
}
