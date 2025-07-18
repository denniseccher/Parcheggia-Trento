//Importazione delle mie classi
//Importing of my classes
import 'dart:async';

import 'package:app_parcheggi/classes/sensor_properties.dart';
import 'package:app_parcheggi/classes/sensor_state.dart';
import 'package:app_parcheggi/variables/variables.dart';

// Questa classe rapprensenta il sensore nella sua interezza: sia dati statici che dinamici
// This class represents the sensor in its entirety: static and dynamic data
class Sensor{
  String id;
  int type;
  double latitude;
  double longitude;
  int streetCode;
  String streetName;
  int state;
  String ts;
  String date;
  String time;

  Sensor(this.id, this.type, this.latitude, this.longitude, this.streetCode, this.streetName, this.state, this.ts, this.date, this.time);

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

//Questa funzione serve per unire le proprietà dei sensori ai loro stati e creare una lista di Sensor
//This function is used to merge sensor properties and states and creating a list of Sensor
Future<List<Sensor>> loadSensor() async {
  List<Sensor> listSensor = [];

  //Carico le liste di proprietà e stati
  //Loading of properties and states lists
  List<SensorProperties>? sensorProperties = await loadProperties();
  List<SensorState>? sensorState = await loadState();

  //Porto a 0 i valori dei parcheggi liberi e occupati nelle strade, per evitare che si sommino
  //I put free and occupied parkings to 0 in the streets
  for(var i in streetsList){
    streetsList.firstWhere((element) => element.streetCode == i.streetCode).p_liberi = [0,0,0];
    streetsList.firstWhere((element) => element.streetCode == i.streetCode).p_occupati = [0,0,0];
  }

  //Ciclo tutti i sensori
  //Iteration of all the sensors
  for(SensorProperties i in sensorProperties){
    //E trovo lo stato del sensore, nella lista degli stati
    //I find the state of the sensor, in the states list
    SensorState tempState = sensorState.firstWhere((element) => element.id == i.getId());
    //Aggiungo il nuovo Sensor alla lista
    //I add the new Sensor to the list
    listSensor.add(Sensor(i.id, i.type, i.latitude, i.longitude, i.streetCode, i.streetName, tempState.getState(), tempState.getTs(), tempState.getDate(), tempState.getTime()));
    //Se quel sensore è libero, incremento il counter dei liberi di quella via. Altrimenti quello degli occupati
    //If the sensor is free, I increase the free counter. Otherwise the occupied one
    if(tempState.getState() == 0){
      streetsList.firstWhere((element) => element.streetCode == i.streetCode).addLiberi(i.type);
    }else{
      streetsList.firstWhere((element) => element.streetCode == i.streetCode).addOccupati(i.type);
    }
  }

  // Restituisco la lista popolata di Sensor
  // Return of the list full of Sensor
  return listSensor;
}

class SensorService {
  // Creiamo un StreamController che gestirà il flusso di dati per i sensori
  final StreamController<List<Sensor>> _sensorStreamController = StreamController<List<Sensor>>.broadcast();

  // Funzione per ottenere lo stream
  Stream<List<Sensor>> get sensorStream => _sensorStreamController.stream;

  // Funzione per caricare i sensori periodicamente
  Future<void> loadSensor() async {
    try {
      // Carica i dati subito la prima volta
      await _loadAndEmitSensors();

      // Usa un Timer periodico per aggiornare i dati ogni X secondi
      Timer.periodic(const Duration(seconds: 5), (timer) async {
        print("Update\n");
        await _loadAndEmitSensors();
      });
    } catch (e) {
      // In caso di errore, invia l'errore al flusso
      _sensorStreamController.addError(e);
    }
  }

  // Funzione privata per caricare e inviare i dati al flusso
  Future<void> _loadAndEmitSensors() async {
    List<Sensor> listSensor = [];
    List<SensorProperties>? sensorProperties = await loadProperties();
    List<SensorState>? sensorState = await loadState();

    for (var i in streetsList) {
      streetsList.firstWhere((element) => element.streetCode == i.streetCode).p_liberi = [0, 0, 0];
      streetsList.firstWhere((element) => element.streetCode == i.streetCode).p_occupati = [0, 0, 0];
    }

    for (SensorProperties i in sensorProperties) {
      SensorState tempState = sensorState.firstWhere((element) => element.id == i.getId());
      listSensor.add(Sensor(i.id, i.type, i.latitude, i.longitude, i.streetCode, i.streetName, tempState.getState(), tempState.getTs(), tempState.getDate(), tempState.getTime()));

      if (tempState.getState() == 0) {
        streetsList.firstWhere((element) => element.streetCode == i.streetCode).addLiberi(i.type);
      } else {
        streetsList.firstWhere((element) => element.streetCode == i.streetCode).addOccupati(i.type);
      }
    }

    // Invia i nuovi dati nel flusso
    _sensorStreamController.sink.add(listSensor);
  }

  // Chiudi il controller quando non è più necessario
  void dispose() {
    _sensorStreamController.close();
  }
}
