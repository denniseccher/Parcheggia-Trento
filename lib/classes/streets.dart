// ignore_for_file: non_constant_identifier_names
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

// Questa classe rapprensenta l'oggetto strada
// This class represents the object street
class Street{
  String streetName;
  int streetCode;
  double latitude;
  double longitude;
  List<int> p_liberi = [0, 0, 0];
  List<int> p_occupati = [0, 0, 0];

  Street(this.streetName, this.streetCode, this.latitude, this.longitude);

  String getStreetName(){
    return streetName;
  }

  int getStreetCode(){
    return streetCode;
  }

  double getLatitude(){
    return latitude;
  }

  double getLongitude(){
    return longitude;
  }

  int getLiberi(int type){
    return p_liberi[type];
  }

  int getOccupati(int type){
    return p_occupati[type];
  }

  void addLiberi(int type){
    p_liberi[type]++;
  }

  void addOccupati(int type){
    p_occupati[type]++;
  }
}

// Funzione per estrapolare le vie dal file CSV
// Function to extract the streets from the CSV file
Future<List<Street>> loadStreets() async{
  // Questa funzione restituisce una Stringa partendo dal file CSV; 'rootBundle' contiene le risorse inserite negli assets in 'pubspec.yaml'
  // This functions returns a String from the CSV file; 'rootBundle' contains all the resources inserted in the assets section in 'pubspec.yaml'
  final String csvString = await rootBundle.loadString('assets/sensor_properties.csv');
  // Qui viene trasformata la Stringa in una List di List (tabella) di dynamic
  // Here the String gets converted in a List of Lists (table) of dynamics
  final List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvString);
  
  // Creo una lista di Street
  // I create a list of Street
  List<Street> streets = [];

  // Estraggo le colonne 2 (latitude), 3 (longitude), 4 (streetCode) e 5 (streetName) dal CSV e lo converto in lista
  // Extraction of columns 2 (latitude), 3 (longitude), 4 (streetCode) and 5 (streetName) from the CSV and conversion into a list
  List<List<dynamic>> columns = csvTable.map((row) => [row[2], row[3], row[4], row[5]]).toList();
  // 'columns' diventa quindi | latitude | longitude | streetCode | streetName |
  // 'columns' becomes | latitude | longitude | streetCode | streetName |

  // Faccio un 'toSet' sulla colonna 2 (streetCode), che mi crea una lista di streetCode unici
  // I do a 'toSet' on the column 2 (streetCode), which creates a list of unique streetCode
  Set<dynamic> distinctStreetCodes = columns.map((row) => row[2]).toSet();

  // Creo una nuova tabella | streetName | streetCode | latitude | longitude |
  // Creation of a new table | streetName | streetCode | latitude | longitude |
  List<List<dynamic>> table = distinctStreetCodes.map((description) => [
    columns.firstWhere((row) => row[2] == description)[3],
    columns.firstWhere((row) => row[2] == description)[2],
    columns.firstWhere((row) => row[2] == description)[0],
    columns.firstWhere((row) => row[2] == description)[1],
  ]).toList();

  // Ciclo tutte le righe della tabella
  // Iteration of all the rows in the table
  for (var row in table) {
    // Estrapolo i dati dalle colonne delle varie righe
    // Extraction of data from the columns
    final streetName = row[0];
    final streetCode = row[1];
    final latitude = row[2];
    final longitude = row[3];

    // Le aggiungo alla Lista
    // Add to the list
    streets.add(Street(streetName, streetCode, latitude, longitude));
  }

  // Restituisco la lista streets
  // Return of the list 'streets'
  return streets;
}