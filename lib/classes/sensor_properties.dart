import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

// Questa classe rappresenta le proprietà statiche dei sensori, i dati sono raccolti dal file 'parking_properties.csv' che si trova in assets/
// This class represents the static properties of the sensors, the data are collected from the file 'parking_propertie.csv' located in assets/
class SensorProperties{
  String id;
  int type;
  double latitude;
  double longitude;
  int streetCode;
  String streetName;

  SensorProperties(this.id, this.type, this.latitude, this.longitude, this.streetCode, this.streetName);

  String getId(){
    return id;
  }

  int getType(){
    return type;
  }

  double getLatitude(){
    return latitude;
  }

  double getLongitude(){
    return longitude;
  }

  int getStreetCode(){
    return streetCode;
  }

  String getStreetName(){
    return streetName;
  }
}

// Funzione per estrapolare i dati relativi alle proprietà statiche dei sensori dal file CSV
// Function to extract data of the sensors' static properties from the CSV file
Future<List<SensorProperties>> loadProperties() async{
  // Questa funzione restituisce una Stringa partendo dal file CSV; 'rootBundle' contiene le risorse inserite negli assets in 'pubspec.yaml'
  // This functions returns a String from the CSV file; 'rootBundle' contains all the resources inserted in the assets section in 'pubspec.yaml'
  final String csvString = await rootBundle.loadString('assets/sensor_properties.csv');
  // Qui viene trasformata la Stringa in una List di List (tabella) di dynamic
  // Here the String gets converted in a List of Lists (table) of dynamics
  final List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvString);

  // Creo una lista di SensorProperties vuota, che popolerò a breve
  // I create a SensorProperties list, that I'll fill soon
  List<SensorProperties> sensorProperties = [];

  // Nel caso la prima riga del CSV contiene l'intestazione coi titoli, questo è il modo per rimuoverla
  // If the first line of the CSV contains the titles, this is the way to remove it
    // csvTable.removeAt(0);

  // Ciclo tutti gli elementi (righe) nella tabella
  // I iterate all the elements (rows) in the table
  for (var row in csvTable) {
    // Inserisco man mano oggetti di tipo SensorProperties nella lista sensorProperties
    // I instert gradually SensorProperties objects into the list called sensorProperties
    sensorProperties.add(SensorProperties(row[0], row[1], row[2], row[3], row[4], row[5]));
  }

  // Restituisco la lista sensorProperties
  // Return of the sensorProperties list
  return sensorProperties;
}