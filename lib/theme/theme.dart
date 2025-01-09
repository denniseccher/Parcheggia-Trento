import 'package:flutter/material.dart';

//I colori del tema sono presi dai colori della città di Trento
//The theme colors come from the colors of the city of Trento
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xff004c1d),
    onPrimary: Color(0xfff3f1e9),
    primaryContainer: Color(0xff40b498),
    onPrimaryContainer: Color(0xff006b2d),
  )
);