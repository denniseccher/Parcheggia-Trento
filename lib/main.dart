import 'package:app_parcheggi/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:app_parcheggi/pages/home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("it");

  changeLanguage(Locale locale) {
    setState(() {
    _locale = locale;
    });
  }
    
  @override
  Widget build(BuildContext context) {
    //Al momento il tema utilizzato non è quello nel file theme.dart, ma è generato a partire dal colore #004c1d
    //At the moment the used theme is not the one in theme.dart, but it's generated from the color #004c1d
    return MaterialApp(
      supportedLocales: L10n.all,

      // locale: const Locale("en"),
      locale: _locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff004c1d),
        brightness: Brightness.light,
        useMaterial3: true
      ),
      home: HomePage(
        changeLanguage: changeLanguage,
      ),
    );
  }
}