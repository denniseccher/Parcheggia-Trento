// ignore_for_file: file_names
import 'package:app_parcheggi/classes/sensor.dart';
import 'package:app_parcheggi/functions/popups.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//Questa classe rappresenta i markers da mostrare sulla mappa
//This class represents the markers shown on the map
Widget myMarkers(bool onlyFree){
  //È un FutureBuilder
  //It's a FutureBuilder
  return FutureBuilder(
    //Che attende il caricamento dei sensori
    //That waits the loading of the sensors
    future: loadSensor(),
    builder:(context, snapshot) {
      //Se non ha ottenuto ancora dati, mostra un indicatore di caricamento
      //If it doesn't already have data it shows a loading indicator
      if(!snapshot.hasData){
        return const Center(
          child: CircularProgressIndicator(),
        );
      //Altrimenti, restituisce i sensori
      //Else, returns the sensors
      }else{
        //Creo una sensorsList dai dati ottenuti da loadSensor()
        //I create a sensorsList from the data by loadSensor()
        List<Sensor>? sensorsList = snapshot.data;
        return MarkerLayer(
          markers: sensorsList!
            //Prendo solo i sensori con stato 1 o 0 (per evitare eccezioni)
            .where((i) => i.getState() == 1 || i.getState() == 0)
            .map(
              (sensor) {
                //Restituisco dei Marker
                //Return of Marker
                return Marker(
                  width: 50,
                  height: 50,
                  //Posizionati in latitudine e longitudine del sensore
                  //Located on the latitude and longitude of the sensor
                  point: LatLng(sensor.latitude, sensor.longitude),
                  //Il figlio è un Visibility, in quanto il sensore deve essere visibile solo il alcune condizioni
                    //li carico comunque tutti subito, per velocizzare il tutto
                  //The child is a Visibility, as the sensor has to be visible only under certain conditions
                    //I upload all immediately, to fast the process
                  child: Visibility(
                    //Il sensore deve essere nascosto se è occupato e l'utente ha richiesto solo quelli liberi
                      //oppure se il tipo del sensore è diverso dal tipo richiesto dall'utente
                    //The sensor has to be hidden if it's occupied and the user requested the free ones only
                      //or it the sensor type is different from the type requested from the user 
                    visible: (sensor.getState() == 1 && onlyFree) || (sensor.type != selectedType.first) ? false : true,
                    //Il sensore in sé è un IconButton
                    //The sensor itself is an IconButton
                    child: IconButton(
                      icon: Icon(
                        Icons.circle,
                        size: 15,
                        //È rosso se è occupato, verde se è libero
                        //It's red if it's occupied, green if it's free
                        color: sensor.getState() == 1 ? Colors.red : Colors.green[900],
                      ),
                      // Quando premo l'IconButton mostro il pop-up, passo l'oggetto stesso per poi utilizzarne le proprietà
                      // When I press the IconButton a pop-up is show, I pass the object to show its properties
                      onPressed: (){
                        sensorPopup(context, sensor);
                      },
                    ),
                  )
                );
              }
            ).toList(),
        );
      }
    },
  );
}