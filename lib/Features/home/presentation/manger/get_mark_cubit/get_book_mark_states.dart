
import '../../../data/models/book_model/verse_model.dart';

abstract class GetBookMarksStates {}

class InitialGetBooksMarkState extends GetBookMarksStates {}

class SuccessGetBooksMarkState extends GetBookMarksStates {
  final List<VerseModel> verse ;
  SuccessGetBooksMarkState({required this.verse});
}

class ArchivesCubitInitial extends GetBookMarksStates {}

class ArchivesCubitLoadSuccess extends GetBookMarksStates {
  final List<VerseModel> verses;
  ArchivesCubitLoadSuccess({
    required this.verses,
  });
}

class ArchivesCubitLoadFailed extends GetBookMarksStates {}
class ShuffleState extends GetBookMarksStates {}
