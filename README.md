```
MAIN
Il progetto è pensato di non contenere nulla nel main, in modo che risulti estremamente modulare e implementabile in progetti più grandi
Il file main contiene solo un rimando al file HomePage, la radice effettiva di tutte le applicazioni
L'intero progetto è stato commentato, quasi riga per riga, sia in italiano che in inglese per spiegare al meglio il suo funzionamento
Questo documento è pensato per illustrare la struttura del progetto nella sua interezza, non sono presenti le spiegazioni di tutte le funzioni in quanto ritengo che i commenti all'interno del codice risultino sufficienti ad illustrare le dinamiche dell'app

CARTELLE
Ho diviso tutto il progetto in 6 cartelle, in modo da renderlo il più leggibile e modulare possibile

>cartella classes
Come suggerisce il nome contiene gli oggetti del progetto, io ho identificato 4 oggetti differenti di cui tenere conto:
- SensorProperties, cioè le proprietà statiche dei sensori, estratte dal file CSV.
Nel file è anche presente la funzione che estrae effettivamente i dati dal file sensor_properties.csv, collocato nella cartella /assets; la funzione restituisce una Future<List<Sensor>>
- SensorState, cioè le proprietà dinamiche dei sensori, estratti dal file XML fornito dalla API. Nel file è anche presente la funzione che estrae effettivamente i dati dalla API https://dss.tnlab.smartcommunitylab.it/services/t/comunetn.main/parcheggi/sensori_last, la quale restituisce un file XML contenente gli ultimi stati dei sensori
- Sensor, un oggetto che contiene tutte le proprietà di un sensore (statiche + dinamiche). Nell'interezza del progetto, verrà utilizzato questo tipo di oggetti. Nel file è presente anche una funzione che, caricando dati statici e dinamici, forma una Future<List<Sensor>>, completa di tutti i dati
- Street, è l'oggetto che rappresenta tutti i dati delle strade. Al momento l'unico modo per estrapolare questi oggetti è estrarre dal file CSV dei sensori i valori di codiceStrada e nomeStrada, farci un .toSet (in pratica come un DISTINCT) e prendere la prima posizione di un sensore in quella via
Problematiche: posso avere solo le strade che contengono un sensore; mi sposto sulla posizione di un sensore, non su quella della via
Possibili soluzioni: avere un file con tutte le vie; trovare una libreria che mi permetta, dando la posizione attuale, di ottenere le vie vicine

>cartella components
In questa cartella ho inserito tutti i componenti grafici utilizzati nell'app, anche questo per permettere una più facile manutenzione e modularità
- ActionButtons è una Row di FloatingActionButtons che permettono di eseguire le 3 principali azioni nell'app:
	- Spostare la mappa sulla mia posizione attuale
	- Aggiornare lo stato dei sensori
	- Aprire la lista delle strade
Parametri richiesti: function1, function2, function3, mapController, context
- AppBar è la AppBar dell'applicazione, ha un titolo e un'action (il pulsante per aprire il popup delle informazioni)
Parametri richiesti: context, onFreeChanged
- FilterButton indica i bottoni presenti sopra la mappa per selezionare quale tipo di sensori visualizzare (linee blu, disabili o carico/scarico)
Il bottone è un SegmentedButton e i segmenti sono i tre tipi di parcheggio
Parametri richiesti: onTypeChanged
- InfoPopup è il popup che viene mostrato quando si preme sul tasto i in alto a destra; è un SimpleDialog che mostra alcune informazioni sull'app e nasconde lo Switch per decidere se visualizzare o meno anche i parcheggi occupati, mostrati in rosso
Qui, nella versione per 'developer', c'è l'opzione di accedere ad un'area dedicata (non disponibile al pubblico) con ulteriori dati
Parametri richiesti: appTitle, launchUrl, context, activeFree, onFreeChanged
- Map è una Card che ha i bordi arrotondati e contiene una FlutterMap che, come figli, ha un TileLayer (il layer grafico, che prende le immagini da OpenStreetMap), un CurrentLocationLayer (mostra l'indicatore della posizione attuale) e Markers (classe creata da me)
Parametri richiesti: mapController, onlyFree
- Markers rappresenta il layer di marker che verranno visualizzati sulla mappa.
Contiene un FutureBuilder, cioè un 'costruttore di widget' che viene avviato appena viene eseguita una funzione.
In questo caso attende il completamento della funzione loadSensors(); al termine restituisce un MarkerLayer che contiene tutti i Marker (per migliorare le prestazioni nell'app); i Marker hanno un child Visibility, che nasconde il marker nel caso in cui il sensore sia occupato e l'utente ha chiesto di visualizzare solo quelli liberi oppure se il tipo del sensore è diverso da quello richiesto dall'utente.
Vengono quindi mostrati solo i sensori del tipo richiesto e solo quelli liberi o tutti a seconda da ciò che l'utente ha selezionato
Parametri richiesti: onlyFree
- StreetTile indica il singolo elemento presente nella SensorList, mostra la strada e il numero di sensori liberi e occupati del tipo richiesto dall'utente.
Quando si preme su una strada, viene eseguita una funzione che sposta la mappa sulla posizione del primo sensore in quella via
Nello stesso file è presente anche StreetTileDev, che rappresenta l'elemento mostrato nell'area Developer e che mostra tutti i tipi di sensori
Parametri richiesti: street, [function], context, [isLast]
- StreetList è la lista delle strade mostrata nella modalità utente. Contiene una casella di ricerca che filtra le strade e la lista di StreetTile
Parametri richiesti: mapController

>cartella functions
Questa cartella contiene dei file con delle funzioni generiche, utilizzabili all'interno del progetto
- popups contiene le funzioni che mostrano dei popup sullo schermo, come la funzione che mostra il popup di informazioni del sensore quando si clicca sul marker, la funzione che mostra la lista di tutte le strade e quella che mostra il popup con le info dell'app
- position contiene tutte le funzioni relative alla geolocalizzazione.
Al momento contiene la funzione enableGeolocatorServices() che controlla che i servizi di localizzazione siano attivi, la funzione moveToCurrentPosition() che sposta l'utente alla sua posizione attuale e la funzione moveMap() che sposta la mappa in un punto indicato

>cartella pages
Questa cartella contiene tutte le pagine del progetto
- HomePage è ciò che l'utente vede appena apre l'app. È composta da:
	- AppBar
	- FilterButton
	- Map
	- FunctionButton
- Developer è la pagina dedicata agli sviluppatori, sarà rimossa dalla versione pubblica, contiene alcune informazioni più specifiche

>cartella variables
Contiene un file con delle variabili locali
>cartella theme
Contiene un file con il tema dell'applicazione, al momento i colori sono presi dal documento sulle linee guida della città di Trento ma possono essere facilmente modificati

FILE
>file pubspec.yaml
Sotto flutter inserisco
assets:
- assets/

>file android/app/src/debug/AndroidManifest.xml
All'interno di <manifest> </manifest> inserisco
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
Che permettono di accedere alla localizzazione su Android

IMPLEMENTAZIONE LETTURA FILE CSV
>file pubspec.yaml
Sotto dependencies inserisco
csv: ^5.1.1
```



><code>file <em>main.dart</em></code>


```
In cima al file inserisco
import 'package:csv/csv.dart';

La funzione per ottenere i file deve essere async, ed è
```



_// Carico il file CSV in una variabile String, await perché devo attendere il caricamento (per questo la funzione deve essere async)_


```
final String csv_string = await rootBundle.loadString('posizione_file.csv');
```



_// Converto la stringa in tabella (Lista di liste), di dynamic_


```
final List<List<dynamic>> csv_table = CsvToListConverter().convert(csv_string);
```



// Qui rimuovo la prima riga, in quanto nel file CSV la prima riga contiene i nomi delle colonne e da errori


csv_table.removeAt(0);


// Da qui in poi tratto la tabella normalmente


```
for(var row in csv_table){
```



// Accedo con _row[0...n]_	


```
}

IMPLEMENTAZIONE LETTURA FILE XML (DA API)
>file pubspec.yaml
Sotto dependencies inserisco
http: ^1.1.0
xml: ^6.1.0
intl: ^0.18.1

>file main.dart
In cima al file inserisco
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

La funzione per ottenere i dati deve essere async, ed è
```



_//Attendo di ottenere la risposta HTTP dal URL della API_


```
final response = await http.get(Uri.parse('link alla API'));
```



_//Se il codice di stato è 200, vuol dire che è andato tutto bene_


```
if(status.code == 200){
```



_//Creo un documento XML, passandoci il body della risposta_


```
final XmlDocument document = XmlDocument.parse(response.body);
```



_//Creo una lista di elementi, contenente tutti gli elementi &lt;sensor>_


```
final elements = document.findAllElements('sensor').toList();
```



_//Da qui tratto elements come una normale lista_


```
for(var i in elements){
```



**<code>	<em>//Per estrarre il valore dei singoli campi</em></code></strong>


_	**<code>var x = i.find Elements('x').single.innerText;</code></strong></em>


```
}
}else{
	print("errore");
}