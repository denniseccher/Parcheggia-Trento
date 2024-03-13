// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:app_parcheggi/variables/variables.dart';

//Questa classe rappresenta il bottone che filtra la tipologia di sensori
  //è Stateful in quanto deve cambiare stato durante l'esecuzione del programma
//This class represents the button which filters the sensor type
  //it's Stateful as it has to change its state during the execution
class FilterButton extends StatefulWidget{
  final Function(Set<int>) onTypeChanged;

  const FilterButton({super.key, required this.onTypeChanged});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    //Il pulsante è centrato
    //The button is centered
    return Center(
      child: Padding(
        //Ha un padding
        //Has a padding
        padding: const EdgeInsets.all(8.0),
        //È un SegmentedButton
        //It's a SegmentedButton
        child: SegmentedButton(
          //selectedType viene dal file 'variables'
          //selectedType comes from the file 'variables'
          selected: selectedType,
          //Quando voglio cambiare il tipo eseguo la funzione
          //When I want to change the type I execute the function
          onSelectionChanged: widget.onTypeChanged,
          //Questo è lo stile del bottone
          //This is the style of the button
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.onPrimaryContainer
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if(states.contains(MaterialState.selected)){
                  return Theme.of(context).colorScheme.primaryContainer;
                }else{
                  return Theme.of(context).colorScheme.primaryContainer.withOpacity(0.25);
                }
              }
            )
          ),
          //I tre segmenti, che indicano le tre tipologie di sensore
          //The three segments, which indicate the three types of sensor
          segments: const [
            ButtonSegment(
              value: 0,
              icon: Icon(Icons.local_parking),
              label: Text("Linee blu")
            ),
            ButtonSegment(
              value: 1,
              icon: Icon(Icons.accessible),
              label: Text("Disabili")
            ),
            ButtonSegment(
              value: 2,
              icon: Icon(Icons.local_shipping),
              label: Text("Carico / scarico")
            ),
          ],
        ),
      ),
    );
  }
}