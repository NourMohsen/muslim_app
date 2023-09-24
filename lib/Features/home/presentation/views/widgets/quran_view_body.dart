import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart'as quran;
import '../../../data/models/book_model/surah_model.dart';
import 'custom_search_text_field.dart';
import 'verse_card.dart';



class QuranViewBody extends StatefulWidget {
  const QuranViewBody({super.key});

  @override
  State<QuranViewBody> createState() => _QuranViewBodyState();
}

class _QuranViewBodyState extends State<QuranViewBody> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchTextField(
                onChange: (value){
                },
              ),
                const SizedBox(height: 10.0),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final surah = SurahModel.fromSurahNumber(index + 1);
                    return VerseCard(
                      surah: surah,
                    );
                  },
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
                  itemCount: quran.totalSurahCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
