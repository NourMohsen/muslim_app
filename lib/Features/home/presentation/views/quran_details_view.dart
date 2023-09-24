import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_task/Features/home/presentation/manger/add_mark_cubit/book_mark_cubit.dart';
import 'package:muslim_task/Features/home/presentation/views/widgets/quran_details_view_body.dart';

import '../../data/models/book_model/surah_model.dart';


class QuranDetailsView extends StatelessWidget {
  const QuranDetailsView(
      {super.key, required this.surah, this.index, this.startingVerseNumber, this.scrollToWord});

  final SurahModel surah;
  final int? index, startingVerseNumber;
  final VoidCallback? scrollToWord;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookMarkCubit(),
      child: QuranDetailsViewBody(
        surah: surah, index: index, startingVerseNumber: startingVerseNumber,),
    );
  }
}
