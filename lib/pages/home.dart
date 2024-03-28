// ignore_for_file: file_names
import 'package:app_parcheggi/components/action_buttons.dart';
import 'package:app_parcheggi/components/app_bar.dart';
import 'package:app_parcheggi/components/filter_button.dart';
import 'package:app_parcheggi/components/map.dart';
import 'package:app_parcheggi/functions/popups.dart';
import 'package:app_parcheggi/functions/position.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';


//Questa è la HomePage dell'app
//This is the app HomePage
class HomePage extends StatefulWidget{
  final Function(Locale) changeLanguage;

  const HomePage({super.key, required this.changeLanguage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MapController mapController = MapController();

  //Quando viene creato lo stato, carico anche la lista di strade
  //On initState, I load the streetsList
  @override
  void initState() {
    loadData();
    super.initState();

    //Questo serve ad impostare il colore della barra di stato, della navigation bar e delle icone (se il tema è chiaro le icone devono essere scure, altrimenti chiare)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ));
    });
  }

  //Funzione che viene eseguita quando cambio il tipo di sensori da visualizzare
  //Function to be executed when I change the type of the sensors to be shown
  void _myTypeSelection(p0){
    setState(() {
      selectedType = p0;
    });
  }

  //Funzione per cambiare il tipo di sensori da vedere (solo liberi o tutti)
  //Function to change the type of sensors to show (only free or all)
  void _myFree(){
    setState(() {
      onlyFree = !onlyFree;
    });
  }

  //Funzione per postare la mappa sulla nostra posizione attuale
  //Function to move the map on our current location
  void _onClickPosition(){
    moveToCurrentPosition(mapController);
  }

  //Funzione per aggiornare lo stato dei sensori
  //Function to update the state of the sensors
  void _updateSensors(){
    setState((){
    });
  }

  //Funzione per mostrare il popup con la lista delle strade
  //Function to show the poput with the streets list
  void _streetsList(){
    popUpStrade(context, mapController);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //L'AppBar è la mia app bar personalizzata
      //The AppBar is my custom app bar
      appBar: myAppBar(
        context,
        _myFree,
        widget.changeLanguage,
      ),
      //Il body è una column
      //The body is a column
      body: Column(
        children: [
          //Con i bottoni per filtrare il tipo (linee blu, disabili, carico/scarico)
          //With the buttons to filter the type (blue lines, disabled, load/unload)
          FilterButton(
            onTypeChanged: _myTypeSelection,
          ),
          //La mappa
          //The map
          Map(
            mapController: mapController,
            onlyFree: onlyFree,
          ),
          //I bottoni azione
          //The action buttons
          ActionButtons(
            _onClickPosition,
            _updateSensors,
            _streetsList,
            mapController,
            context
          )
        ],
      ),
    );
  }
}