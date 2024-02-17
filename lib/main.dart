import 'package:api_lessons/search_image/provider/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_image/pages/homepage/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'assets/langs', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
      saveLocale: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return ThemeProvider();
        },
        child: PreApp());
  }
}

class PreApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.checkTheme();
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider tp, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Pyidaungsu",
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.blue),
        ),
        darkTheme: ThemeData(
          fontFamily: "Pyidaungsu",
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          appBarTheme: AppBarTheme(color: Colors.teal),
        ),
        themeMode: tp.tm,
        home: HomePage(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      );
    });
  }
}
