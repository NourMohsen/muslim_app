import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_task/constants.dart';

import '../../../../../core/utils/cache_network.dart';
import '../../../data/models/book_model/verse_model.dart';
import 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkStates> {
  BookMarkCubit () : super(InitialBookMarkState());

addBookMark({required VerseModel verseModel}) async {
  emit(LoadingBookMarkState());
  try {
    var bookMark = Hive.box<VerseModel>(hiveKey);
    await bookMark.add(verseModel);
    emit(SuccessBookMarkState());
  } catch (error) {
    emit(FailureBookMarkState(error.toString()));
  }
}

  final minFontSize = 20.0;
  final maxFontSize = 48.0;
  onSliderChanged(double value) {
    if(value<=maxFontSize-2){
      value+=2;
    }
    CacheHelper.saveData(
        key: 'fontsize', value: value);
    emit(changeFontState());
  }
}