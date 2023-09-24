import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muslim_task/Features/home/presentation/manger/add_mark_cubit/book_mark_state.dart';
import 'package:muslim_task/constants.dart';
import 'package:muslim_task/core/utils/assets.dart';
import 'package:muslim_task/core/utils/cache_network.dart';
import 'package:muslim_task/core/utils/functions/to_arabic_no_covertor.dart';
import 'package:muslim_task/core/utils/styles.dart';
import 'package:quran/quran.dart' as quran;
import '../../../data/models/book_model/surah_model.dart';
import '../../manger/add_mark_cubit/book_mark_cubit.dart';

class QuranDetailsViewBody extends StatefulWidget {

  const QuranDetailsViewBody({
    super.key,
    required this.surah,
    this.startingVerseNumber, this.index,
  });

  final SurahModel surah;
  final int? startingVerseNumber;
  final int?index;

  @override
  State<QuranDetailsViewBody> createState() => _QuranDetailsViewBodyState();
}

class _QuranDetailsViewBodyState extends State<QuranDetailsViewBody> {
  var keys = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.startingVerseNumber!=-1&&keys[widget.startingVerseNumber!].currentContext!=null) {
      Scrollable.ensureVisible(
        keys[widget.startingVerseNumber!].currentContext,
        alignment: 0.2,
        duration: Duration(milliseconds: 500),
      );
    }});

  }
  @override
  Widget build(BuildContext context) {
    keys = List.generate(widget.surah.versesCount, (i) => GlobalKey());

    var cubit = BlocProvider.of<BookMarkCubit>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetsData.appBarBg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(widget.surah.surahName),
        ),
        body: BlocBuilder<BookMarkCubit, BookMarkStates>(
  builder: (context, state) {
    return SingleChildScrollView(
          padding: const  EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Slider(
                activeColor: kBackgroundColor,
                inactiveColor: Colors.white,
                value:CacheHelper.getData(key: "fontsize")??cubit.minFontSize,
                min: cubit.minFontSize,
                max: cubit.maxFontSize,
                //label: fontSize.round().toString(),
                onChanged: (value) async {
                    cubit.onSliderChanged(value);
                },
              ),
              RichText(
                textAlign: widget.surah.versesCount <= 20 ? TextAlign.center : TextAlign.justify,
                text: TextSpan(
                  style: AppFontStyle.labelStyle.copyWith(
                              fontFamily: "HAFS-Regular",
                              fontWeight: FontWeight.w500,
                              fontSize: CacheHelper.getData(key: "fontsize")),
                    children: Iterable.generate(widget.surah.versesCount, (i) => i)
                        .expand((i) => [
                      WidgetSpan(
                        child: SizedBox.fromSize(
                          size: Size.zero,
                          key: keys[i],
                        ),
                      ),
                      TextSpan(

                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            BlocProvider.of<BookMarkCubit>(context).addBookMark(
                                verseModel:
                                widget.surah.getVerseByNumber(i+1));
                            Fluttertoast.showToast(
                                msg: "This is Center Short Toast",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kBackgroundColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                        text: '${quran.getVerse(
                          widget.surah.surahNumber,
                          i+1,
                        )} ${(i+1).toArabicNumbers} ',
                        style: TextStyle(
                            color: widget.startingVerseNumber == i+1
                                ? kBackgroundColor
                                : Colors.black,
                            fontWeight: widget.startingVerseNumber == i+1 ?
                            FontWeight.w700:FontWeight.w500
                        ),
                      )
                    ])
                        .toList()),
              )
            ],
          ),
        );
  },
)

        );
  }
}
