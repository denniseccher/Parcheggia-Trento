import 'package:app_parcheggi/classes/sensor.dart';
import 'package:app_parcheggi/classes/streets.dart';
import 'package:app_parcheggi/components/street_tile.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';

class DeveloperPage extends StatefulWidget{
  const DeveloperPage({super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  void initState() {
    super.initState();
  }

  //Prendo la lista di strade
  //I take the streetsList
  List<Street> streets = streetsList;

  //filterSensors serve a filtrare la lista di strade secondo il testo cercato dall'utente
  //filterSensors is used to filter the street list with the text searched by the user
  void filterSensors(String filter) async {
    setState(() {
      streets = streetsList.where((element) => element.getStreetName().toLowerCase().contains(filter.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed:() {
      //     setState(() {
      //       loadSensor();
      //     });
      //   },
      //   child: const Icon(Icons.update),
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        //I colori sono presi dal tema dell'app
        //The colors come from the app theme
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,

        title: const Text("Modalità sviluppatore"),
        centerTitle: true,
      ),
      body: SafeArea(
        child:  Column(
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
                        borderRadius: BorderRadius.all(Radius.circular(50.0))
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
              child: Scrollbar(
                radius: const Radius.circular(4),
                interactive: true,
                
                thumbVisibility: true,
                thickness: 8,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: streets.length,
                  itemBuilder: (context, index){
                    return StreetTileDev(
                      streets[index],
                      context,
                      streets.map((e) => streets.last == streets[index] ? true : false).first,
                    );
                  }
                ),
              )
            )
          ],
        )
      )
    );
  }
}