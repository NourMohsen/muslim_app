import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_task/constants.dart';
import 'package:muslim_task/core/utils/app_router.dart';
import 'Features/home/data/models/book_model/verse_model.dart';
import 'core/utils/cache_network.dart';
import 'core/utils/simple_bloc_observer.dart';
import 'core/utils/styles.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VerseModelAdapter());
  await Hive.openBox<VerseModel>(hiveKey);
  await CacheHelper.init();
  Bloc.observer = SimpleBlocObserver();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [ Locale('ar'),],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: const Locale('ar'),
        startLocale: Locale("ar"),
        child: const MuslimApp()
    ),);}

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale.fromSubtags(languageCode: "ar"),
      debugShowCheckedModeBanner: false,
      title: 'Muslim App',
      theme: ThemeData(
        appBarTheme: Theme
            .of(context)
            .appBarTheme
            .copyWith(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kBackgroundColor,
          titleTextStyle: AppFontStyle.appBarTitle,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor:kBackgroundColor,
              statusBarIconBrightness: Brightness.light
          ),
        ),
        scaffoldBackgroundColor:kScaffoldBackgroundColor,
        fontFamily: 'URW DIN Arabic',
      ),
      routerConfig: AppRouter.router,
    );
  }
}



