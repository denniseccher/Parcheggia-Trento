// ignore_for_file: non_constant_identifier_names
import 'package:app_parcheggi/pages/developer.dart';
import 'package:flutter/material.dart';

Widget InfoPopup(String appTitle, Function(Uri) launchUrl, BuildContext context, bool activeFree, Function onFreeChanged){
  return SimpleDialog(
    insetPadding: const EdgeInsets.all(32),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32))
    ),
    title: Text(
      appTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),

    //Come figli ha una colonna, che contiene le info che si vogliono mostrare
    //As children it has a Column, containing the info we want to show
    children:
    [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          height: 384,
          width: 256,
          child: ListView(
            children: [
              const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
              const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  const Text(
                    "Developed by",
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse("https://www.linktr.ee/denniseccher/"));
                        },
                        child: Text(
                          "DENNIS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            foreground: Paint()..shader = const LinearGradient(
                              colors: <Color>[
                                  Colors.red,
                                  Color(0xffff6600),
                                  //add more color here.
                              ],
                            ).createShader(const Rect.fromLTWH(0.0, 0.0, 256.0, 128.0))
                          ),
                        )
                      ),
                      const Text(
                        "×",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse("https://www.comune.trento.it/"));
                        },
                        child: const Text(
                          "Comune di Trento",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              StatefulBuilder(
                builder:(context, setState) {
                  return Center(
                    child: Column(
                      children: [
                        const Text(
                          "Vuoi visualizzare anche i parcheggi occupati?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const Text("(Può peggiorare le prestazioni)"),
                        Switch(
                          value: !activeFree,
                          onChanged:(value) {
                            setState((){
                              onFreeChanged();
                              activeFree = !activeFree;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      //E una zona inferiore personalizzabile, qui ho messo una X che chiude il popup, però si potrebbe mettere
        //un pulsante che ti da le indicazioni per raggiungere quel parcheggio
      //On the buttom it has a customizable part, I did put an X that closes the popup, an option can be a button
        //that gives you indications to reach that parking spot
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
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeveloperPage(),
                ),
              );
            },
            color: Colors.blue,
          )
        ],
      )
    ],

    //FINE - Interno del dialogo
    //END - Inside of dialog
  );
}