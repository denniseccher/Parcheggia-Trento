// ignore_for_file: file_names
import 'package:app_parcheggi/components/markers.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

//Questa classe rappresenta la mappa mostrata nella home page
//This class represents the map shown in the home page
class Map extends StatefulWidget{
  final MapController mapController;
  final bool onlyFree;

  const Map({super.key, required this.mapController, required this.onlyFree});
  

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    //È un Expanded (occupa tutto lo spazio a disposizione)
    //It's an Expanded (occupies all the available space)
    return Expanded(
      child: Padding(
        //Il padding è solo orizzontale in quanto sia il FilterButton che ActionButton hanno un loro padding
        //The padding is only horizontal as both FilterButton and ActionButton have their padding
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //La mappa è all'interno di una Card
        //The map is inside a Card
        child: Card(
          //La Card è arrotondata
          //The Card is rounded
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32)
          ),
          clipBehavior: Clip.hardEdge,
          //Il figlio è una FlutterMap
          //The child is a FlutterMap
          child: FlutterMap(
            mapController: widget.mapController,
            //Queste sono le opzioni della mappa
            //These are the map options
            options: const MapOptions(
              //La mappa è inizialmente centrata sulle coordinate di Trento
              //The map is initially centered on the coordinates of Trento
              initialCenter: LatLng(latitudeTrento, longitudeTrento),
              //Queste opzioni servono a regolare correttamente lo zoom
              //These options are needed to regulate correctly the zoom
              interactionOptions: InteractionOptions(
                enableMultiFingerGestureRace: true,
                flags: InteractiveFlag.doubleTapDragZoom |
                  InteractiveFlag.doubleTapZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.flingAnimation |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.rotate |
                  InteractiveFlag.scrollWheelZoom,
              ),
            ),
            //I figli della mappa
            //The map's children
            children: [
              //Il layer di sfondo, preso da OpenStreetMap
              //The background layer, from OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),

              //Il CurrentLocationLayer, che mostra un indicatore della mia posizione attuale
              //The CurrentLocationLayer, which shows an indicator of my current position
              CurrentLocationLayer(),

              //I Marker dei sensori
              //The sensors' Marker
              myMarkers(widget.onlyFree)
            ],
          ),
        )
      ),
    );
  }
}