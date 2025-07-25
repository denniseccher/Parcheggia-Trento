// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

//Questo widget rappresenta i pulsanti 'Azione' in basso allo schermo
//This widget represents the 'Action' buttons on the button of the screen 
Widget ActionButtons(Function() function1, Function() function3, MapController mapController, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    //I pulsanti sono in una Row e sono equalmente spaziati
    //The buttons are in a Row and evenly spaced
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Il primo pulsante serve a spostare la mappa sulla mia posizione
        //The first button is used to move the map on my location
        FloatingActionButton(
          // foregroundColor: Theme.of(context).colorScheme.onPrimary,
          elevation: 4,
          onPressed: function1,
          child: const Icon(
            Icons.my_location
          ),
        ),
        //Il secondo pulsante serve ad aggiornare lo stato dei sensori
        //The second button is used to update the state of the sensors
        // FloatingActionButton(
        //   // foregroundColor: Theme.of(context).colorScheme.onPrimary,
        //   elevation: 4,
        //   onPressed: function2,
        //   child: const Icon(
        //     Icons.update
        //   ),
        // ),
        //Il terzo pulsante serve a mostrare la lista delle strade
        //The third button is used to show the streets list
        FloatingActionButton(
          // foregroundColor: Theme.of(context).colorScheme.onPrimary,
          elevation: 4,
          onPressed: function3,
          child: const Icon(
            Icons.add_road_outlined
          ),
        ),
      ],
    ),
  );
}