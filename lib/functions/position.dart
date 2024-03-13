import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//Funzione spostarsi alla posizione attuale del dispositivo
//Function to move to the current position of the device
void moveToCurrentPosition(MapController mapController) async {
  //Restituisco la posizione attuale
  //Return of the current position
  Position currenPosition = await Geolocator.getCurrentPosition();
  moveMap(mapController, LatLng(currenPosition.latitude, currenPosition.longitude), 15);
}

//Funzione per spostare il centro della mappa in coordinate specifiche
//Function to move the center of the map to specific coordinates
void moveMap(MapController mapController, LatLng position, double zoom){
  mapController.move(position, zoom);
}

void enableGeolocatorServices() async{
  //Controllo che i servizi di geolocator siano attivi
  //Check if the geolocator services are enabled
  bool serviceEnabled;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //Se non sono attivi faccio un return e non proseguo
    //If are not enabled I do a return and don't go further
    return Future.error('Location services are disabled.');
  }

  //Controllo che i permessi di geolocator siano autorizzati
  //Check if geolocator is allowed
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  //Se non è autorizzato
  //If it's not allowed
  if (permission == LocationPermission.denied) {
    //Richiedo i permessi all'utente
    //Request of permission to user
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      //Se non sono permessi faccio un return e non proseguo
      //If are not allowed I do a return and don't go further
      return Future.error('Location permissions are denied');
    }
  }
}