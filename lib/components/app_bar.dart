// ignore_for_file: file_names
import 'package:app_parcheggi/functions/popups.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';

//Questo è il widget della AppBar
//This is the AppBar widget
PreferredSizeWidget myAppBar(BuildContext context, Function onFreeChanged){
  return AppBar(
    //I colori sono presi dal tema dell'app
    //The colors come from the app theme
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,

    //Il titolo è preso dal file 'variables'
    //The title is from the file 'variables'
    title: const Text(
      appTitle,
    ),
    centerTitle: true,
    //Work in progress...
    actions: [
      IconButton(
        onPressed: (){
          infoPopup(onFreeChanged, context);
        },
        icon: const Icon(Icons.info_outline)
      )
    ],
  );
}