import 'package:app_parcheggi/classes/streets.dart';
import 'package:app_parcheggi/components/street_tile.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:app_parcheggi/functions/position.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//Questa è la classe della lista di strade
//This is the class of the street list
class StreetList extends StatefulWidget{
  final MapController mapController;

  const StreetList({super.key, required this.mapController});

  @override
  State<StatefulWidget> createState() => _StreetListState();
}

class _StreetListState extends State<StreetList> {
  //Prendo la lista di strade
  //I take the streetsList
  List<Street> streets = streetsList;
  
  @override
  void initState() {
    super.initState();
  }

  //onClickStreetList serve a spostare la mappa quando viene premuta una strada dalla lista
  //onClickStreetList is used to move the map when a street is pressed
  void onClickStreetList(LatLng latLng){
    moveMap(widget.mapController, latLng, 20);
  }

  //filterSensors serve a filtrare la lista di strade secondo il testo cercato dall'utente
  //filterSensors is used to filter the street list with the text searched by the user
  void filterSensors(String filter) async {
    setState(() {
      streets = streetsList.where((element) => element.getStreetName().toLowerCase().contains(filter.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    //La lista è composta da una colonna
    //The list is made by a column
    return Column(
      children: [
        //Con una SizedBox
        //With a SizedBox
        SizedBox(
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, right: 8, left: 8, bottom: 0),
              //Con il TextField per la ricerca delle strade
              //With a TextField to search streets
              child: TextField(
                onChanged: filterSensors,
                decoration: const InputDecoration(
                  hintText: "Cerca una strada...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(64.0))
                  ),
                ),
              ),
            ),
          )
        ),
        //E un Expanded
        //And an Expanded
        Expanded(
          //Con la lista di StreetTile
          //With a list of StreetTile
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            itemCount: streets.length,
            itemBuilder: (context, index){
              return StreetTile(streets[index], onClickStreetList, context);
            }
          )
        )
      ],
    );
  }
}