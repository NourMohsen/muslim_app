import 'package:hive/hive.dart';
import 'package:quran/quran.dart';

part 'verse_model.g.dart';
@HiveType(typeId: 0)
class VerseModel extends HiveObject {
  @HiveField(0)
  final int surahNumber;
  @HiveField(1)
  final int verseNumber;
  @HiveField(2)
  final String? verseContent;
  @HiveField(3)
  final String? verseEnglish;
  @HiveField(4)
  final String ? verseAudioUrl;

  VerseModel({
    required this.surahNumber,
    required this.verseContent,
    required this.verseNumber,
    required this.verseEnglish,
    required this.verseAudioUrl
  });

  factory VerseModel.fromVerseAndSurahNumber(
      {required int verseNumber, required int surahNumber}) {
    return VerseModel(
      surahNumber: surahNumber,
      verseContent: getVerse(surahNumber, verseNumber,),
      verseNumber: verseNumber,
      verseEnglish: getVerseTranslation(surahNumber, verseNumber,
          translation: Translation.enSaheeh),
      verseAudioUrl: getAudioURLByVerse(surahNumber, verseNumber),
    );
  }
}