import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Questa classe è relativa ai dati di stato dei sensori, cioè i dati ottenuti dalla API (parcheggio occupato/libero e da quando)
// This class represents the data of the sensors' state, received from the API (if the parking is full/empty and since when)
class SensorState{
  String id;
  int state;
  String ts;
  String date;
  String time;

  SensorState(this.id, this.state, this.ts, this.date, this.time);

  String getId(){
    return id;
  }

  int getState(){
    return state;
  }

  String getTs(){
    return ts;
  }

  String getDate(){
    return date;
  }

  String getTime(){
    return time;
  }
}

// Funzione per ottenere il file XML dalla API e poi gestirlo
// Function to obtain the XML file from the API and manage it
Future<List<SensorState>> loadState() async{
  // Attendo di ottenere la risposta HTTP dal URL della API
  // Waiting to obtain the HTTP response from the API
  String urlAPI = 'https://dss.tnlab.smartcommunitylab.it/services/t/comunetn.main/parcheggi/sensori_last';
  final response = await http.get(Uri.parse(urlAPI));

  // Creo una Lista di SensorState
  // I create a list of SensorState
  List<SensorState> sensorState = [];

  // Se lo stato della risposta è 200, allora è andata a buon fine
  // If the response statusCode is 200, means is ok
  if(response.statusCode == 200){
    // Creo un documento XML, passandoci il body della risposta
    // Creation of an XML document from the response body
    final XmlDocument document = XmlDocument.parse(response.body);
    // Creo una lista di elementi, contenente tutti gli elementi <sensor>
    // Creation of a list, containing all the elements <sensor> in the XML
    final elements = document.findAllElements('sensor').toList();

    // Ciclo tutti gli elementi di 'elements'
    // Iteration of all the elements in 'elements'
    for (var i in elements){
      final String id = i.findElements('id').single.innerText;
      final int state = int.parse(i.findElements('state').single.innerText);
      final String ts = i.findElements('ts').single.innerText.toString();
      String date = "NULL";
      String time = "NULL";
      if(ts.isNotEmpty){
        final DateTime timeDate = DateTime.parse(ts);
        date = DateFormat('HH:mm:ss').format(timeDate);
        time = DateFormat('dd/MM/yyyy').format(timeDate);
      }

      // Aggiungo elementi di tipo SensorState nella lista sensorState
      // Adding SensorState objects into the list sensorState
      sensorState.add(SensorState(id, state, ts, date, time));
    }
  }else{
    throw Exception('Error in HTTP request');
  }

  // Restituisco la lista popolata
  // Return of the list
  return sensorState;
}