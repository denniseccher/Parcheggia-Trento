# CARTELLE
Ho diviso tutto il progetto in 5 cartelle, in modo da renderlo il più leggibile e modulare possibile

**>cartella classes**
Come suggerisce il nome contiene gli oggetti del progetto, io ho identificato 4 oggetti differenti di cui tenere conto:
- [SensorProperties], cioè le proprietà statiche dei sensori, estratte dal file CSV.
Nel file è anche presente la funzione che estrae effettivamente i dati dal file sensor_properties.csv, collocato nella cartella /assets; la funzione restituisce una Future<List<Sensor>>
- [SensorState], cioè le proprietà dinamiche dei sensori, estratti dal file XML fornito dalla API. Nel file è anche presente la funzione che estrae effettivamente i dati dalla API https://dss.tnlab.smartcommunitylab.it/services/t/comunetn.main/parcheggi/sensori_last, la quale restituisce un file XML contenente gli ultimi stati dei sensori
- [Sensor], un oggetto che contiene tutte le proprietà di un sensore (statiche + dinamiche). Nell’interezza del progetto, verrà utilizzato questo tipo di oggetti. Nel file è presente anche una funzione che, caricando dati statici e dinamici, forma una Future<List<Sensor>>, completa di tutti i dati
- [Street], è l’oggetto che rappresenta tutti i dati delle strade. Al momento l’unico modo per estrapolare questi oggetti è estrarre dal file CSV dei sensori i valori di codiceStrada e nomeStrada, farci un .toSet (in pratica come un DISTINCT) e prendere la prima posizione di un sensore in quella via
Problematiche: posso avere solo le strade che contengono un sensore; mi sposto sulla posizione di un sensore, non su quella della via
Possibili soluzioni: avere un file con tutte le vie; trovare una libreria che mi permetta, dando la posizione attuale, di ottenere le vie vicine

**>cartella components**
In questa cartella ho inserito tutti i componenti grafici utilizzati nell’app, anche questo per permettere una più facile manutenzione e modularità
- [FilterButton] si tratta dei 3 bottoni sopra la mappa nella HomePage (‘Tutti’, ‘Disabili’, ‘Carico/scarico’), sono bottoni che cambiano i sensori mostrati sulla mappa.
La classe restituisce un Padding che contiene un ElevatedButton, il quale esegue una funzione quando è premuto, è colorato se è attivo e contiene un'icona e un testo
*Parametri richiesti*: icon, title, active, function, i (indice: 0, 1, 2)
- [FunctionButton] sono i 3 bottoni sotto la mappa nella HomePage (‘Current position’, ‘Update’, ‘Streets’), sono bottoni che eseguono delle azioni.
La classe restituisce un Padding che contiene un ElevatedButton, che esegue una funzione quando è premuto.
*Parametri richiesti*: icon, function
- [Map] è una Card che ha i bordi arrotondati e contiene una FlutterMap che, come figli, ha un TileLayer (il layer grafico, che prende le immagini da OpenStreetMap), un CurrentLocationLayer (mostra l’indicatore della posizione attuale) e Markers (classe creata da me)
*Parametri richiesti*: mapController, activeType
- [Markers] rappresenta il layer di marker che verranno visualizzati sulla mappa. Contiene un FutureBuilder, cioè un ‘costruttore di widget’ che viene avviato appena viene eseguita una funzione.
In questo caso attende il completamento della funzione loadSensors(activeType); al termine restituisce un MarkerLayer che contiene i marker relativi al risultato della funzione. I marker contengono un IconButton (con un’icona che è verde se il sensore è libero o rossa se il sensore è occupato) e, quando vengono premuti, eseguono la funzione popUpSensore(sensor), la quale mostra un pop-up con i dati del sensore
*Parametri richiesti*: activeType
- [SensorTile] è l’oggetto che rappresenta il singolo elemento nella lista di tutti i sensori del drawer laterale. È composto da un GestureDetector che, al click, esegue l’azione di spostare la mappa sul sensore premuto; come figlio contiene una Card.
La Card ha i bordi stondati ed è rosso se il sensore è occupato oppure verde se il sensore è libero, contiene anche alcune informazioni sul sensore
Parametri richiesti: sensor, function
- [SensorList] è la lista di sensori visibile nel drawer laterale.
In questo caso è uno StatefulWidget in quanto ha uno stato, per fare una ricerca dei sensori per esempio la lista deve essere aggiornata. Con uno StatefulWidget posso eseguire la funzione setState() che permette l’update di qualcosa, non disponibile invece negli StatelessWidget.
SensorList contiene una colonna composta da una barra di ricerca (in lavorazione) e un FutureBuilder; il FutureBuilder, al completamento della funzione load Sensors(3) (che carica tutti i sensori) restituisce una ScrollBar con all’interno una ListView (lista scrollabile) di SensorTile.
Parametri richiesti: mapController

**>cartella functions**
Questa cartella contiene dei file con delle funzioni generiche, utilizzabili all’interno del progetto
- [popups] contiene le funzioni che mostrano dei popup sullo schermo, come la funzione che mostra il popup di informazioni del sensore quando si clicca sul marker e la funzione che mostra la lista di tutte le strade
- [position] contiene tutte le funzioni relative alla geolocalizzazione.
Al momento contiene la funzione enableGeolocatorServices() che controlla che i servizi di localizzazione siano attivi, la funzione moveToCurrentPosition() che sposta l’utente alla sua posizione attuale e la funzione moveMap() che sposta la mappa in un punto indicato

**>cartella pages**
Questa cartella contiene tutte le pagine del progetto
- [HomePage] è ciò che l’utente vede appena apre l’app. È composta da 5 parti principali:
- [AppBar], che è la barra in cima allo schermo
- [Drawer], che è il menù laterale (al momento contiene solo la lista di sensori che, in teoria, l’utente finale non vede)
- [FilterButton] (contenuti in una SizedBox), i 3 pulsanti ‘Tutti’, ‘Disabili’ e ‘Carico/scarico’ che servono a selezionare il tipo di parcheggi da mostrare.
- [Map] (contenuta in un Expanded), la mappa
- [FunctionButton] (contenuti in una SizedBox), i 3 pulsanti ‘Current position’, ‘Update’, ‘Streets’ che servono ad eseguire le relative azioni

**>cartella variables**
Contiene un file con delle variabili locali

