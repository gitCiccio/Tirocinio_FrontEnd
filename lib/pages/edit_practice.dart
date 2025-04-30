import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPracticePage extends StatefulWidget {
  final String practiceId;
  final String debtorName;
  final double creditToRecover;
  final List<Map<String, dynamic>> agents;
  final String currentAgentEmail;

  const EditPracticePage({
    super.key,
    required this.practiceId,
    required this.debtorName,
    required this.creditToRecover,
    required this.agents,
    required this.currentAgentEmail,
  });

  @override
  State<EditPracticePage> createState() => _EditPracticePageState();
}

class _EditPracticePageState extends State<EditPracticePage> {
  late TextEditingController debtorController;
  late TextEditingController creditController;
  List<double> installments = [200.0, 300.0];
  List<double> recoveries = [100.0];
  List<double> promises = [250.0];
  late String selectedAgentEmail;

  @override
  void initState() {
    super.initState();
    debtorController = TextEditingController(text: widget.debtorName);
    creditController = TextEditingController(text: widget.creditToRecover.toString());
    selectedAgentEmail = widget.currentAgentEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifica Pratica')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID Pratica: ${widget.practiceId}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: debtorController,
              decoration: const InputDecoration(labelText: 'Debitore'),
            ),
            TextField(
              controller: creditController,
              decoration: const InputDecoration(labelText: 'Credito da Recuperare'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedAgentEmail,
              items: widget.agents.map((agent) {
                return DropdownMenuItem<String>(
                  value: agent['email'],
                  child: Text(agent['email']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAgentEmail = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Assegna a un altro agente"),
            ),

            const SizedBox(height: 20),
            _buildEditableList("Rate (Installments)", installments),
            _buildEditableList("Recuperi (Recoveries)", recoveries),
            _buildEditableList("Promesse di pagamento", promises),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Salvataggio logica futura
                Navigator.pop(context);
              },
              child: const Text("Salva modifiche"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableList(String title, List<double> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...list.asMap().entries.map((entry) {
          final index = entry.key;
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: entry.value.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => list[index] = double.tryParse(val) ?? 0,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    list.removeAt(index);
                  });
                },
              )
            ],
          );
        }),
        TextButton.icon(
          onPressed: () {
            setState(() {
              list.add(0);
            });
          },
          icon: const Icon(Icons.add),
          label: const Text("Aggiungi"),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
