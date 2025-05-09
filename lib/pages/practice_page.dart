import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/service/agentService.dart';

import '../model/agent.dart';
import '../model/debtor.dart';
import '../model/note.dart';
import '../model/practice.dart';
import '../service/practiceService.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PracticePage();
  }
}

class _PracticePage extends State<PracticePage> {
  List<Practice> practices = [];

  List<Debtor> debtors = [];
  Debtor? selectedDebtor;

  List<Practice> filteredPractices = [];
  Practice? selectedPractice;

  Practice? currentPractice;
  int practiceIndex = 0;
  int selectedValue = 2;

  int index = 1;
  int maxIndex = 100;

  TextEditingController noteController = TextEditingController();
  final AgentService agentService = AgentService();
  final PracticeService practiceService = PracticeService();


  late Agent agent;
//Ora mostra le pratiche a schermo
  @override
  void initState(){
    super.initState();
    debugPrint('initState chiamato');
    noteController = TextEditingController();
    _loadAgentAndPractice();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  void _loadAgentAndPractice() async {
    try{
      agent = await agentService.getAgentData("");//Inserire email
      final List<Practice> loadedPractices = await practiceService.getAgentPractice(agent.agentId);
      if(loadedPractices.isNotEmpty){
        debugPrint("pratiche caricate");
      }
      setState(() {
        practices = loadedPractices;

        // Costruiamo la lista dei debitori unici
        for (var practice in practices) {
          if (!debtors.any((d) => d.id == practice.debtor.id)) {
            debtors.add(practice.debtor);
          }
        }

        // Imposta il primo debitore come selezionato di default
        if (debtors.isNotEmpty) {
          selectedDebtor = debtors[0];
          filteredPractices = practices.where((p) => p.debtor.id == selectedDebtor!.id).toList();
          selectedPractice = filteredPractices.isNotEmpty ? filteredPractices[0] : null;
        }
      });

    }catch(e){
      debugPrint('Errore nel caricamento: $e');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                debugPrint("Profilo");
              },
              icon: Icon(Icons.person))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: const Text(
                'Menù',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Impostazioni'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Esci'),
              onTap: () {},
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          /// 🔶 Scrollable filter bar (Dropdowns)
          /// 🔶 Scrollable filter bar (Dropdowns)
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),

                /// Dropdown 1: ID debitore
                Container(
                  width: 120,
                  child: DropdownButton<Debtor?>(
                    value: selectedDebtor,
                    hint: Text("Tutti i debitori"),
                    isExpanded: true,
                    underline: SizedBox(),
                    items: [
                      // Campo per "Tutti"
                      DropdownMenuItem<Debtor?>(
                        value: null,
                        child: Text('Tutti i debitori'),
                      ),
                      // Lista debitori reali
                      ...debtors.map((debtor) {
                        return DropdownMenuItem<Debtor?>(
                          value: debtor,
                          child: Text('${debtor.personalData.name} ${debtor.personalData.surname}'),
                        );
                      }).toList()
                    ],
                    onChanged: (Debtor? newDebtor) {
                      setState(() {
                        selectedDebtor = newDebtor;
                        if (selectedDebtor == null) {
                          // Se non è selezionato nessun debitore → mostra tutte le pratiche
                          filteredPractices = practices;
                        } else {
                          // Altrimenti filtra le pratiche di quel debitore
                          filteredPractices = practices.where((p) => p.debtor.id == selectedDebtor!.id).toList();
                        }
                        selectedPractice = filteredPractices.isNotEmpty ? filteredPractices[0] : null;
                        currentPractice = selectedPractice;
                      });
                    },
                  )
                ),

                SizedBox(width: 10),

                /// Dropdown 2: ID pratica
                Container(
                  width: 120,
                  child: DropdownButton<Practice>(
                    value: selectedPractice,
                    hint: Text("Seleziona pratica"),
                    isExpanded: true,
                    underline: SizedBox(),
                    items: [
                      // Aggiungi l'opzione per resettare la pratica
                      DropdownMenuItem<Practice>(
                        value: null,  // Valore nullo per resettare la selezione
                        child: Text('Nessuna pratica'),
                      ),
                      // Le altre pratiche
                      ...filteredPractices.asMap().entries.map((entry) {
                        int idx = entry.key;
                        Practice practice = entry.value;
                        return DropdownMenuItem<Practice>(
                          value: practice,
                          child: Text('Pratica ${idx + 1}'),
                        );
                      }).toList(),
                    ],
                    onChanged: (Practice? newPractice) {
                      setState(() {
                        if (newPractice == null) {
                          // Resetta la pratica selezionata
                          selectedPractice = null;
                          currentPractice = null;
                        } else {
                          // Imposta la pratica selezionata
                          selectedPractice = newPractice;
                          currentPractice = newPractice;
                        }
                      });
                    },
                  ),
                ),

                SizedBox(width: 10),

                /// Dropdown 3: Ordina (Icona per invertire)
                Container(
                  width: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedValue == 2) {
                          selectedValue = 1;
                        } else if (selectedValue == 1) {
                          selectedValue = 2;
                        }
                        practices = practices.reversed.toList();
                      });
                    },
                    child: Image(image: AssetImage('images/up_down.webp')),
                  ),
                ),

                SizedBox(width: 10),
              ],
            ),
          ),


          /// 🔴 Lista pratiche
          Container(
            alignment: Alignment.center,
            color: Colors.red,
            width: double.infinity,
            height: 300,
            margin: EdgeInsets.zero,
            child: currentPractice == null
                ? ListView(
              padding: EdgeInsets.all(8),
              children: [
                // Se non c'è una pratica selezionata, mostra tutte le pratiche
                for (var entry in filteredPractices.asMap().entries)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPractice = entry.value;
                        print('Pratica selezionata posizione ${entry.key + 1}');
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      width: double.infinity,
                      height: 20,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Pratica: ${entry.key + 1}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
              ],
            )
                : GestureDetector(
              onTap: () {
                setState(() {
                  currentPractice = null; // Resetta la selezione per mostrare di nuovo la lista
                });
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                width: double.infinity,
                height: 20,
                margin: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Pratica selezionata: ${filteredPractices.indexOf(currentPractice!) + 1}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: () {setState(() {
                  index = 1;
                });}, icon: Icon(Icons.keyboard_double_arrow_left_outlined),
                  padding: EdgeInsets.all(5),),

                IconButton(onPressed: () {setState(() {
                  index--;
                  if(index<=0) {
                    index = maxIndex;
                  }
                });}, icon: Icon(Icons.keyboard_arrow_left),
                  padding: EdgeInsets.all(5),),
                SizedBox(
                  width: 60,
                  child: Center(
                    child: Text('${index}/${maxIndex}', style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
                IconButton(onPressed: () {setState(() {
                  index++;
                  if(index>=maxIndex) {
                    index=1;
                  }
                });}, icon: Icon(Icons.keyboard_arrow_right),
                  padding: EdgeInsets.all(5),),

                IconButton(onPressed: () {setState(() {
                  index = maxIndex;
                });}, icon: Icon(Icons.keyboard_double_arrow_right_outlined),
                  padding: EdgeInsets.all(5),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              currentPractice != null
                  ? 'Pratica n: ${filteredPractices.indexOf(currentPractice!) + 1}'
                  : 'Caricamento...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),


          /// 🔶 Dettaglio pratica selezionata
          Container(
            width: double.infinity,
            height: 400, // aumentato l'altezza per stare più comodi
            color: Colors.orange,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            child: currentPractice != null
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// SINISTRA: DATI PERSONALI
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${currentPractice!.debtor.email}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Numero: ${currentPractice!.debtor.phoneNumber}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Nominativo: ${currentPractice!.debtor.personalData.name} ${currentPractice!.debtor.personalData.surname}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 16),
                        Text('Indirizzi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ...currentPractice!.debtor.addresses.map(
                              (address) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              '${address.nameStreet}, ${address.houseNumber}, ${address.cityHall.city_name}, ${address.cityHall.province}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 20),

                /// DESTRA: CREDITO + NOTE
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// CREDITO DA RECUPERARE
                      Text(
                        'Credito da recuperare:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '€ ${practiceService.calcolateCredit(currentPractice!)}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(height: 20),

                      /// NOTE DELLA PRATICA
                      Text(
                        'Note:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: currentPractice!.notes.isNotEmpty
                            ? ListView.builder(
                          itemCount: currentPractice!.notes.length,
                          itemBuilder: (context, index) {
                            final note = currentPractice!.notes[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '${_formatDate(note.dateNote)} - ',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: note.text,
                                    ),
                                  ],
                                ),
                              ),


                            );
                          },
                        )
                            : Center(
                          child: Text(
                            'Nessuna nota disponibile.',
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            )
                : Center(child: Text('Caricamento della pratica...')),
          ),

          /// ✏️ Input e bottone Salva
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: noteController, // 👈 AGGIUNTO
              decoration: InputDecoration(
                hintText: 'Inserisci una nota',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (noteController.text.trim().isNotEmpty) {
                setState(() {
                  currentPractice!.notes.add(
                    Note(
                      text: noteController.text.trim(), noteId: '', dateNote: DateTime.now()
                      // altri campi se servono
                    ),
                  );
                  noteController.clear(); // Pulisco il campo dopo aver aggiunto
                });
              }
            },
            child: Text('Aggiungi Nota'),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                practiceService.sendPractice(currentPractice!);
              },
              child: Text('Salva'),
            ),
          ),
        ],
      ),
    );
  }
}
