import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:muslim_task/constants.dart';
import 'package:muslim_task/core/utils/styles.dart';
import '../../manger/get_mark_cubit/get_book_mark_cubit.dart';
import '../../manger/get_mark_cubit/get_book_mark_states.dart';
import 'verse_line.dart';

class ArchivesViewBody extends StatelessWidget {
  const ArchivesViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetBookMarksCubit, GetBookMarksStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<GetBookMarksCubit>(context);
        return cubit.bookMarks.isEmpty?
        Center(
          child: Text(
            'لم تضف اي محفوظات بعد',
            style: AppFontStyle.labelStyle.copyWith(
                fontSize: 40,
                fontFamily: "HAFS-Regular",
                fontWeight: FontWeight.w900),
          ),
        )
        :Stack(
          children: [
            ReorderableListView.builder(
                onReorder: (oldindex,newindex){
                  cubit.reOrder(oldindex, newindex);
              },
              // onReorder: (int oldindex, int newindex)async{
              //   if (oldindex == newindex) return;
              //   final items =cubit.bookMarks.removeAt(oldindex);
              //   if(newindex<oldindex){
              //     cubit.bookMarks.insert(newindex, items);
              //   }else{
              //     cubit.bookMarks.insert(newindex-=1, items);
              //   }
              // },
              itemBuilder: (context, index) {
                return Padding(
                  key: Key(index.toString()),
                  padding: const EdgeInsets.all(16),
                  child: VerseLine(
                    verse: cubit.bookMarks[index],
                    index: index,
                  ),
                );
              },
              itemCount: cubit.bookMarks.length,
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                child: Icon(Icons.shuffle),
                backgroundColor: kBackgroundColor,
                onPressed: (){
                  cubit.shuffle();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
