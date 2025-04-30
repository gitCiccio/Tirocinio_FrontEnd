import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/pages/practice_dialog.dart';

import 'edit_practice.dart';

void main() {
  runApp(const MaterialApp(
    home: AdminPage(),
  ));
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dati statici
    final agents = [
      {
        'agentId': 'A001',
        'email': 'agente1@email.com',
        'role': 'collector',
        'practices': [
          {
            'practiceId': 'PRACT001',
            'debtorName': 'Mario Rossi',
            'creditToRecover': 1500.0,
          },
          {
            'practiceId': 'PRACT002',
            'debtorName': 'Giulia Bianchi',
            'creditToRecover': 3200.0,
          },
        ],
      },
      {
        'agentId': 'A002',
        'email': 'agente2@email.com',
        'role': 'collector',
        'practices': [
          {
            'practiceId': 'PRACT003',
            'debtorName': 'Luca Verdi',
            'creditToRecover': 850.0,
          },
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Azione di logout (da implementare)
            Navigator.pop(context); // esempio: torna alla login page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: agents.length,
        itemBuilder: (context, index) {
          final agent = agents[index];
          final practices = agent['practices'] as List;

          return ExpansionTile(
            title: Text(agent['email'].toString()),
            subtitle: Text('Ruolo: ${agent['role']}'),
            children: (agent['practices'] as List).map<Widget>((practice) {
              return ListTile(
                title: Text('Pratica: ${practice['practiceId']}'),
                subtitle: Text('Debitore: ${practice['debtorName']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditPracticePage(
                              practiceId: practice['practiceId'],
                              debtorName: practice['debtorName'],
                              creditToRecover: practice['creditToRecover'],
                              agents: agents,
                              currentAgentEmail: agent['email'].toString(),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Mostra dialog di conferma
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Conferma eliminazione'),
                              content: Text('Sei sicuro di voler eliminare la pratica ${practice['practiceId']}?'),
                              actions: [
                                TextButton(
                                  child: const Text('Annulla'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: const Text('Elimina', style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    // In questo caso, eliminazione solo simulata su lista statica
                                    practices.remove(practice);
                                    Navigator.of(context).pop();
                                    (context as Element).reassemble(); // Forza rebuild per vedere il cambiamento
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => PracticeDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

