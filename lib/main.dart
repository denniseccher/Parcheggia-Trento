import 'package:app_parcheggi/pages/home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Al momento il tema utilizzato non è quello nel file theme.dart, ma è generato a partire dal colore #004c1d
    //At the moment the used theme is not the one in theme.dart, but it's generated from the color #004c1d
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff004c1d),
        brightness: Brightness.light,
        useMaterial3: true
      ),
      home: const HomePage(),
    );
  }
}