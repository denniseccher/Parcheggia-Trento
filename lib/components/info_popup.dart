// ignore_for_file: non_constant_identifier_names
import 'package:app_parcheggi/pages/developer.dart';
import 'package:flutter/material.dart';

Widget InfoPopup(String appTitle, Function(Uri) launchUrl, BuildContext context, bool activeFree, Function onFreeChanged){
  //Il pop-up è un SimpleDialog
  //The pop-up is a SimpleDialog
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

    //Come figli ha una SizedBox che contiene tutti gli elementi e una Row con i pulsanti azione
    //As children has a SizedBox and a Row with the action buttons
    children:
    [
      SizedBox(
        height: 384,
        width: 256,
        //Contiene una ListView, in modo che sia scrollabile
        //Contains a ListView, so it's scrollable
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
            //Questa sezione serve ad attivare o disattivare lo Switch per vedere anche i parcheggi occupati,
              //è Stateful in quanto lo Switch deve cambiare stato (disattivato <--> attivato)
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

      //E una zona inferiore personalizzabile, con una X che chiude il popup e un pulsante debug per accedere alla zona
        //Developer (nella versione per il pubblico verrà rimossa)
      //On the buttom it has a customizable part, with an X that closes the popup and the debug button to access the
        //Developer area (in the public version will be removed)
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
  );
}