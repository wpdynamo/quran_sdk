# 📖 Quran SDK

مكتبة Flutter للقرآن الكريم تعمل بدون إنترنت مع ترجمة عربية وإنجليزية كاملة، دعم الصوتيات، وإمكانية البحث.

[![pub package](https://img.shields.io/pub/v/quran_sdk.svg)](https://pub.dev/packages/quran_sdk)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[English](README.md) | العربية

## ✨ المميزات

- 🌐 **متعدد اللغات**: النص العربي (بالتشكيل وبدون تشكيل) والترجمة الإنجليزية
- 📴 **يعمل بدون إنترنت**: جميع بيانات القرآن مدمجة في المكتبة (لا حاجة لاستدعاءات API)
- 🎵 **دعم الصوتيات**: روابط لـ 5 قراء مشهورين لكل آية وسورة
- 🔍 **البحث**: ابحث في الآيات بالعربية أو الإنجليزية
- 📚 **دعم الأجزاء**: الوصول إلى جميع الأجزاء الـ 30 من القرآن
- 🎲 **آية عشوائية**: احصل على آيات عشوائية
- ⚡ **سريع**: جميع البيانات محملة في الذاكرة للوصول الفوري
- 🎯 **واجهة برمجية بسيطة**: طرق سهلة الاستخدام لجميع العمليات

## 📦 التثبيت

أضف هذا إلى ملف `pubspec.yaml`:

```yaml
dependencies:
  quran_sdk: ^0.1.0
```

ثم قم بتشغيل:

```bash
flutter pub get
```

## 🚀 البداية السريعة

```dart
import 'package:quran_sdk/quran_sdk.dart';

void main() async {
  // تهيئة المكتبة
  final quran = QuranSDK();
  await quran.initialize();

  // الحصول على آية محددة
  final verse = await quran.getVerse(1, 1);
  print(verse?.textArabic);
  // النتيجة: بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ

  // الحصول على جميع السور
  final surahs = await quran.getSurahs();
  print('إجمالي السور: ${surahs.length}');

  // البحث في الآيات
  final results = await quran.search(query: 'الله', language: 'arabic');
  print('تم العثور على ${results.length} آية');
}
```

## 📚 أمثلة الاستخدام

### الحصول على سورة

```dart
final surah = await quran.getSurah(1);
print('${surah?.name} - ${surah?.nameArabic}');
print('عدد الآيات: ${surah?.totalVerses}');
```

### الحصول على جميع آيات سورة

```dart
final verses = await quran.getVersesBySurah(112);
for (var verse in verses) {
  print('${verse.number}: ${verse.textArabic}');
}
```

### الحصول على آيات بنطاق محدد

```dart
final verses = await quran.getVersesByRange(2, 1, 5);
// الحصول على الآيات 1-5 من سورة البقرة
```

### البحث في الآيات

```dart
// البحث بالعربية
final results = await quran.search(
  query: 'الله',
  language: 'arabic',
  limit: 10,
);

// البحث بالإنجليزية
final results = await quran.search(
  query: 'mercy',
  language: 'english',
  limit: 10,
);

// البحث في جميع اللغات
final results = await quran.search(
  query: 'paradise',
  language: 'all',
);
```

### الحصول على آية عشوائية

```dart
final verse = await quran.getRandomVerse();
print('${verse.surah.nameArabic} ${verse.number}: ${verse.textArabic}');
```

### معلومات الأجزاء

```dart
// الحصول على جميع الأجزاء
final juzList = await quran.getAllJuz();

// الحصول على جزء محدد
final juz = await quran.getJuz(1);
print('الجزء ${juz?.number}: من ${juz?.start} إلى ${juz?.end}');

// الحصول على جميع آيات جزء
final verses = await quran.getVersesByJuz(1);
print('الجزء الأول يحتوي على ${verses.length} آية');
```

### دعم الصوتيات

```dart
// الحصول على القراء المتاحين
final reciters = quran.getReciters();
for (var reciter in reciters) {
  print('${reciter['id']}: ${reciter['name']}');
}

// الحصول على صوت آية
final verse = await quran.getVerse(1, 1);
final audio = verse?.audio[1]; // القارئ رقم 1 (مشاري العفاسي)
print('رابط الصوت: ${audio?.urlOriginal}');

// الحصول على صوت سورة كاملة
final chapterAudio = quran.getChapterAudio(1, 112);
print('صوت السورة: ${chapterAudio.url}');
```

## 🎵 القراء المتاحون

1. مشاري راشد العفاسي
2. أبو بكر الشاطري
3. ناصر القطامي
4. ياسر الدوسري
5. هاني الرفاعي

## 📊 نماذج البيانات

### السورة (Surah)

```dart
class Surah {
  final int number;              // رقم السورة
  final String name;             // اسم السورة بالإنجليزية
  final String nameArabic;       // اسم السورة بالعربية
  final String nameArabicLong;   // اسم السورة الكامل
  final String translation;      // ترجمة اسم السورة
  final String revelationPlace;  // مكان النزول (مكة/المدينة)
  final int totalVerses;         // عدد الآيات
}
```

### الآية (Verse)

```dart
class Verse {
  final Surah surah;                    // معلومات السورة
  final int number;                     // رقم الآية
  final String textArabic;              // النص العربي بالتشكيل
  final String textArabicNoTashkeel;    // النص العربي بدون تشكيل
  final String textEnglish;             // الترجمة الإنجليزية
  final Map<int, Audio> audio;          // الصوتيات للقراء
}
```

### الجزء (Juz)

```dart
class Juz {
  final int number;           // رقم الجزء
  final JuzPosition start;    // بداية الجزء (سورة:آية)
  final JuzPosition end;      // نهاية الجزء (سورة:آية)
}
```

### الصوت (Audio)

```dart
class Audio {
  final int reciterId;        // رقم القارئ
  final String reciterName;   // اسم القارئ
  final String url;           // رابط الصوت
  final String urlOriginal;   // الرابط الأصلي
}
```

## 💾 حجم المكتبة

تتضمن المكتبة جميع بيانات القرآن كملفات JSON:
- السور: ~30 كيلوبايت
- الآيات: ~3.7 ميجابايت
- الأجزاء: ~1 كيلوبايت

إجمالي البيانات المدمجة: ~3.8 ميجابايت

## 🔧 الاستخدام المتقدم

### التهيئة مرة واحدة

```dart
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final quran = QuranSDK();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeQuran();
  }

  Future<void> _initializeQuran() async {
    await quran.initialize();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    // استخدم مكتبة القرآن هنا
  }
}
```

### الاستخدام مع Provider

```dart
class QuranProvider extends ChangeNotifier {
  final QuranSDK quran = QuranSDK();
  bool isInitialized = false;

  Future<void> initialize() async {
    await quran.initialize();
    isInitialized = true;
    notifyListeners();
  }
}
```

## 📱 حالات الاستخدام

1. **تطبيقات قراءة القرآن**: عرض نص القرآن مع الترجمات
2. **تطبيقات حفظ القرآن**: مساعدة المستخدمين على حفظ الآيات
3. **التطبيقات الإسلامية**: تضمين ميزات القرآن في تطبيقات إسلامية شاملة
4. **تطبيقات البحث**: بناء وظائف البحث في القرآن
5. **تطبيقات الصوتيات**: إنشاء مشغلات صوت للقرآن
6. **التطبيقات التعليمية**: تعليم القرآن مع الترجمات
7. **تطبيقات الويدجت**: عرض آيات يومية
8. **تطبيقات التذكير**: إرسال إشعارات بالآيات

## 📈 الأداء

- **وقت التهيئة**: ~1-2 ثانية (تحميل 4 ميجابايت من البيانات)
- **وقت الاستعلام**: فوري (البيانات محفوظة في الذاكرة)
- **استخدام الذاكرة**: ~10-15 ميجابايت (جميع البيانات في الذاكرة)
- **أداء البحث**: سريع (بحث نصي في الذاكرة)

## 🎯 طرق المكتبة الرئيسية

```dart
// التهيئة
await quran.initialize();

// السور
await quran.getSurahs();                    // الحصول على جميع السور (114)
await quran.getSurah(1);                    // الحصول على سورة محددة

// الآيات
await quran.getVerse(1, 1);                 // الحصول على آية محددة
await quran.getVersesBySurah(1);            // الحصول على جميع آيات سورة
await quran.getVersesByRange(1, 1, 5);      // الحصول على آيات 1-5
await quran.getRandomVerse();               // الحصول على آية عشوائية

// البحث
await quran.search(
  query: 'الله',
  language: 'all',  // 'all', 'english', 'arabic'
  limit: 50,
);

// الأجزاء
await quran.getAllJuz();                    // الحصول على جميع الأجزاء (30)
await quran.getJuz(1);                      // الحصول على جزء محدد
await quran.getVersesByJuz(1);              // الحصول على جميع آيات جزء

// الصوتيات
quran.getReciters();                        // الحصول على قائمة القراء
quran.getChapterAudio(1, 112);              // الحصول على صوت سورة
```

## 🤝 المساهمة

المساهمات مرحب بها! لا تتردد في تقديم Pull Request.

## 📄 الترخيص

هذا المشروع مرخص بموجب ترخيص MIT - راجع ملف [LICENSE](LICENSE) للتفاصيل.

## 🙏 الشكر والتقدير

- **مصدر البيانات**: [Quran.com](https://quran.com)
- **الصوتيات**: [EveryAyah.com](https://everyayah.com)
- **الترجمة**: Clear Quran English Translation

## 📧 الدعم

للمشاكل والأسئلة، يرجى زيارة [مستودع GitHub](https://github.com/wpdynamo/quran_sdk).

---

صُنع بـ ❤️ للمجتمع الإسلامي بواسطة [WP Dynamo](https://wpdynamo.com/)
