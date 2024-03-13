// ignore_for_file: non_constant_identifier_names
import 'package:app_parcheggi/classes/streets.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

//Questo widget è il singolo elemento nella lista delle strade
//This widget is the single element in the streets list
Widget StreetTile(Street street, Function(LatLng) function, BuildContext context){
  //Restituisco un GestureDetector
  //Return of a GestureDetector
  return GestureDetector(
    //Quando premo su una strada, chiudo il popup e sposto la mappa sulla posizione della strada
    //When I tap on the street, I close the popup and move the map on the street position
    onTap: () {
      Navigator.of(context).pop();
      function(LatLng(street.getLatitude(), street.getLongitude()));
    },
    //Il tile è una colonna
    //The tile is a column
    child: Column(
      children: [
        //Con il nome della strada
        //With the street name
        Text(
          street.getStreetName(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        //E una row con il counter dei posti liberi e occupati nella strada
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Liberi: ${street.getLiberi(selectedType.first)}",
              style: TextStyle(
                color: Colors.green.shade800
              ),
            ),
            Text(
              "Occupati: ${street.getOccupati(selectedType.first)}",
              style: TextStyle(
                color: Colors.red.shade800
              ),
            )
          ],
        )
      ],
    )
  );
}

//Questo widget è il singolo elemento nella lista delle strade
//This widget is the single element in the streets list
Widget StreetTileDev(Street street, BuildContext context, bool isLast){
  //Restituisco un GestureDetector
  //Return of a GestureDetector
  return Column(
    children: [
      //Con il nome della strada
      //With the street name
      Text(
        street.getStreetName(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      //E una row con il counter dei posti liberi e occupati nella strada
      Column(
        children: [
          const Text(
            "Parcheggi linee blu",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Liberi: ${street.getLiberi(0)}",
                style: TextStyle(
                  color: Colors.green.shade800
                ),
              ),
              Text(
                "Occupati: ${street.getOccupati(0)}",
                style: TextStyle(
                  color: Colors.red.shade800
                ),
              ),
              Text(
                "Totale: ${street.getLiberi(0) + street.getOccupati(0)}",
                style: const TextStyle(
                  color: Colors.blue
                ),
              )
            ],
          ),
          const Text(
            "Parcheggi disabili",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Liberi: ${street.getLiberi(1)}",
                style: TextStyle(
                  color: Colors.green.shade800
                ),
              ),
              Text(
                "Occupati: ${street.getOccupati(1)}",
                style: TextStyle(
                  color: Colors.red.shade800
                ),
              ),
              Text(
                "Totale: ${street.getLiberi(1) + street.getOccupati(1)}",
                style: const TextStyle(
                  color: Colors.blue
                ),
              )
            ],
          ),
          const Text(
            "Parcheggi carico/scarico",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Liberi: ${street.getLiberi(2)}",
                style: TextStyle(
                  color: Colors.green.shade800
                ),
              ),
              Text(
                "Occupati: ${street.getOccupati(2)}",
                style: TextStyle(
                  color: Colors.red.shade800
                ),
              ),
              Text(
                "Totale: ${street.getLiberi(2) + street.getOccupati(2)}",
                style: const TextStyle(
                  color: Colors.blue
                ),
              )
            ],
          ),
          const Text(
            "Tutti i parcheggi",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Liberi: ${street.getLiberi(0) + street.getLiberi(1) + street.getLiberi(2)}",
                style: TextStyle(
                  color: Colors.green.shade800
                ),
              ),
              Text(
                "Occupati: ${street.getOccupati(0) + street.getOccupati(1) + street.getOccupati(2)}",
                style: TextStyle(
                  color: Colors.red.shade800
                ),
              ),
              Text(
                "Totale: ${street.getLiberi(0) + street.getLiberi(1) + street.getLiberi(2) + street.getOccupati(0) + street.getOccupati(1) + street.getOccupati(2)}",
                style: const TextStyle(
                  color: Colors.blue
                ),
              ),
            ],
          ),
        ],
      ),
      !isLast ? 
      Divider(
        indent: 8,
        endIndent: 8,
        color: Colors.black.withOpacity(0.5),
      ) : 
      const SizedBox()
    ],
  );
}