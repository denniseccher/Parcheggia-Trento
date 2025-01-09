import 'package:app_parcheggi/components/info_popup.dart';
import 'package:app_parcheggi/components/streets_list.dart';
import 'package:app_parcheggi/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:app_parcheggi/classes/sensor.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
  
//Funzione che mostra un pop-up dopo aver cliccato un sensore
//Function that shows a pop-up after clicking a sensor
void sensorPopup(BuildContext context, Sensor sensor){
  String duration = 'NULL';

  //Se sensor.date e sensor.state non sono NULL, significa che hanno valori corretti
  //If sensor.date and sensor.state are not NUll, means they have right values
  if(sensor.date != 'NULL' && sensor.time != 'NULL'){
    //Con questa funzione ottengo l'orario attuale
    //With this function i obtain the current time
    DateTime timeNow = DateTime.now();
    //Qui prendo il ts del sensore e lo trasformo in DateTime
    //Here I take the ts of the sensor and parse into DateTime
    DateTime timeSensor = DateTime.parse(sensor.getTs());
    //Ora posso fare la differenza tra l'orario attuale e l'ultimo aggiornamento del sensore
    //Now I can do the difference between the current time and the last update of the sensor state
    Duration timeDifference = timeNow.difference(timeSensor);
    //Qui trasformo la duration in formato leggibile
    //Here I transform the duration into a readable format
    //timeDifferenca.in* = ottengo quel valore / I get that value
    //.toString().padLeft(2, '0') = significa che se le cifre sono meno di 2 ci mette davanti lo 0 / leading zero
    final hh = (timeDifference.inHours).toString().padLeft(2, '0');
    final mm = (timeDifference.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (timeDifference.inSeconds % 60).toString().padLeft(2, '0');
  
    duration = "$hh:$mm:$ss";
  }
  //Ora mostro il dialogo a schermo
  //Now I can show the dialog
  showDialog(
    //Prende il contesto passato
    //Uses the received context
    context: context,
    builder: (BuildContext context) {
      //Restituisce un SimpleDialog
      //Returns a SimpleDialog
      return SimpleDialog(
        //INIZIO - Interno del dialogo
        //BEGINNING - Inside of dialog
        title: Text(
          sensor.getId().toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //Come figli ha una colonna, che contiene le info che si vogliono mostrare
        //As children it has a Column, containing the info we want to show
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Nome via: ${sensor.streetName}'),
              Text('In questo stato da: $duration')
            ],
          ),
          //E una zona inferiore personalizzabile, qui ho messo una X che chiude il popup, però si potrebbe mettere
          //un pulsante che ti da le indicazioni per raggiungere quel parcheggio
          SimpleDialogOption(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close,
                  color: Colors.red,
                )
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],

        //FINE - Interno del dialogo
        //END - Inside of dialog
      );
    }
  );
}


void infoPopup(Function onFreeChanged, BuildContext contesto, Function(Locale) onLanguageChanged){
  //Ora mostro il dialogo a schermo
  //Now I can show the dialog
  showDialog(
    //Prende il contesto passato
    //Uses the received context
    context: contesto,
    builder: (BuildContext context) {
      //Restituisco InfoPopup, creato da me
      //Return of InfoPupup, created by me
      return InfoPopup(
        appTitle,
        _launchUrl,
        context,
        onlyFree,
        onFreeChanged,
        onLanguageChanged,
      );
    },
  ); 
}

void popUpStrade(BuildContext context, MapController joystickMappa) async {
  // Show a popup with minimal design and a light blue background
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      children: [
        // Title with bold and centered text
        Center(
          child: Text(
            AppLocalizations.of(context)!.streets.toUpperCase(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        // Street list with a slightly lighter blue color
        SizedBox(
          height: 450,
          width: 300,
          child: StreetList(
            mapController: joystickMappa
          ),
        ),

        // Close button with a bold red color
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.red,
            ),
          ],
        ),
      ],
    ),
  );
}