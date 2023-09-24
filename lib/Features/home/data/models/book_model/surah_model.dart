import 'package:muslim_task/Features/home/data/models/book_model/verse_model.dart';
import 'package:quran/quran.dart';

class SurahModel {
  final String surahName;
  final int surahNumber;
  final String placeOfRevelation;
  final int versesCount;

  SurahModel({
    required this.surahName,
    required this.surahNumber,
    required this.placeOfRevelation,
    required this.versesCount,
  });

  factory SurahModel.fromSurahNumber(int surahNumber) {
    return SurahModel(
      surahName: getSurahNameArabic(surahNumber),
      surahNumber: surahNumber,
      placeOfRevelation:
          getPlaceOfRevelation(surahNumber) == 'Makkah' ? 'مكية' : 'مدنية',
      versesCount: getVerseCount(surahNumber),
    );
  }

  VerseModel getVerseByNumber(int verseNumber) {
    return VerseModel.fromVerseAndSurahNumber(
      verseNumber: verseNumber,
      surahNumber: surahNumber,
    );
  }
}
