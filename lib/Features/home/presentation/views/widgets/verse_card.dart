import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim_task/core/utils/assets.dart';
import 'package:muslim_task/core/utils/styles.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../data/models/book_model/surah_model.dart';
import '../quran_details_view.dart';


class VerseCard extends StatelessWidget {
  const VerseCard({
    super.key,
    required this.surah,
  });

  final SurahModel surah;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: InkWell(
        onTap: () {

          // GoRouter.of(context).push(
          //   AppRouter.kBookDetailsView,
          //   extra: surah,
          // );
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context)=>QuranDetailsView(
            surah: surah,
                    startingVerseNumber: -1,
          )));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffDDE9EB),
                  image: 
                  DecorationImage(image: 
                  AssetImage(AssetsData.verseImg))
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.surahName,
                    style: AppFontStyle.labelStyle,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'رقم السورة: ${surah.surahNumber}',
                    style: AppFontStyle.descStyle,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                   surah.placeOfRevelation,
                style: AppFontStyle.coloredLabelStyle,
              ),

                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                  'عدد أياتها: ${surah.versesCount}',
                    style: AppFontStyle.descStyle,

                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
