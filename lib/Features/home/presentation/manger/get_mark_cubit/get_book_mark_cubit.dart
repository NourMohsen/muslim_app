
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:muslim_task/constants.dart';
import '../../../data/models/book_model/verse_model.dart';
import 'get_book_mark_states.dart';

class GetBookMarksCubit extends Cubit<GetBookMarksStates> {
  GetBookMarksCubit() : super(InitialGetBooksMarkState());
  List<VerseModel> bookMarks = [];
  var bookMarkBox = Hive.box<VerseModel>(hiveKey);

  getBookMarks() {
    //kBookMarkBox
    bookMarks =List.from( bookMarkBox.values.toList());
    emit(SuccessGetBooksMarkState(verse: bookMarks));
  }


  reOrder(int oldIndex, int newIndex){
    if (oldIndex == newIndex) return;
    final items =bookMarks.removeAt(oldIndex);
    if(newIndex<oldIndex){
      bookMarks.insert(newIndex, items);
    }else{
      bookMarks.insert(newIndex-=1, items);
    }
    bookMarkBox.putAt(newIndex, bookMarks[oldIndex]);
    bookMarks =List.from( bookMarkBox.values.toList());
    emit(ArchivesCubitInitial());
  }

  void shuffle(){
    bookMarks.shuffle();
    emit(ShuffleState());
  }
}
