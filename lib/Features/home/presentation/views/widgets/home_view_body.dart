import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_task/Features/home/presentation/manger/get_mark_cubit/get_book_mark_cubit.dart';
import '../archives_view.dart';
import '../quran_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
          ),
          title: const Text(
            'القرأن الكريم',
          ),
          bottom: const TabBar(
            padding: EdgeInsets.zero,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 35),
            physics: BouncingScrollPhysics(),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            tabs: [
              Tab(
                child: Text('السور'),
              ),
              Tab(
                child: Text('المحفوظات'),
              ),

            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            QuranView(),
            BlocProvider(
              create: (context) => GetBookMarksCubit()..getBookMarks(),
              child: ArchivesView(),
            ),
          ],
        ),
      ),
    );
  }
}
