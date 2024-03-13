import 'package:app_parcheggi/classes/streets.dart';

//Dati statici, la mappa parte centrata su questi punti
//Static data, the map starts centered on this points
const double latitudeTrento = 46.074779;
const double longitudeTrento = 11.12108;

//Il titolo dell'app, visualizzato nella AppBar
//The app title, shown in the AppBar
const String appTitle = "Parcheggia Trento";

//Il selectedType serve all'interno dell'app per sapere che categoria di sensori l'utente vuole vedere
//The selectedType is used inside the app to know which sensor category the user wants to see
Set<int> selectedType= {0};

//onlyFree indica se voglio vedere solo i parcheggi liberi oppure anche quelli occupati
//onlyFree sets if I want to see only the free spots or the occupied ones too
bool onlyFree = true;

//streetsList viene inizializzato all'inizio, verrà utilizzato più volte
//streetsList is loaded at the beginning, will be used multiple times
late List<Street> streetsList;
void loadData() async{
  streetsList = await loadStreets();
}