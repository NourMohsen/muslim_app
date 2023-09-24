import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim_task/Features/home/data/models/book_model/surah_model.dart';
import 'package:muslim_task/Features/home/presentation/manger/add_mark_cubit/book_mark_cubit.dart';

import '../../Features/Splash/presentation/views/splash_view.dart';
import '../../Features/home/presentation/views/home_view.dart';
import '../../Features/home/presentation/views/quran_details_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) =>
            BlocProvider(
              create: (context) => BookMarkCubit(),
              child: QuranDetailsView(
                surah: state.extra as SurahModel,
                startingVerseNumber: state.extra as int,
                index: state.extra as int,
              ),
            ),
      ),
    ],
  );
}
