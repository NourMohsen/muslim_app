import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:muslim_task/Features/home/presentation/views/quran_details_view.dart';

import '../../../../../core/utils/styles.dart';
import '../../../data/models/book_model/surah_model.dart';
import '../../../data/models/book_model/verse_model.dart';
import '../../manger/get_mark_cubit/get_book_mark_cubit.dart';

class VerseLine extends StatelessWidget {
  const VerseLine({Key? key, required this.verse, required this.index}) : super(key: key);
  final VerseModel verse;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              QuranDetailsView(
            startingVerseNumber: verse.verseNumber,
            surah: SurahModel.fromSurahNumber(verse.surahNumber),
            index: index,
          )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal:8.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(verse.verseContent??'',
                  style: AppFontStyle.labelStyle.copyWith(
                      fontSize: 24,
                      fontFamily: "HAFS-Regular",
                  ),
                )),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    verse.delete();
                    BlocProvider.of<GetBookMarksCubit>(context).getBookMarks();
                  },
                  icon: const Icon(Icons.delete),
                ),
                 // style: TextStyle(fontFamily: GoogleFonts.amiri().fontFamily,fontSize: 22),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}