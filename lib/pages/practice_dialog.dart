import 'package:flutter/material.dart';

import 'new_debtor_dialog.dart';

class PracticeDialog extends StatefulWidget {
  const PracticeDialog({super.key});

  @override
  State<PracticeDialog> createState() => _PracticeDialogState();
}

class _PracticeDialogState extends State<PracticeDialog> {
  String? selectedAgentEmail = 'agente1@email.com';
  String? selectedDebtor = 'Mario Rossi';
  bool showNewDebtorFields = false;

  final TextEditingController newDebtorNameController = TextEditingController();
  final TextEditingController newDebtorAddressController = TextEditingController();
  final TextEditingController creditController = TextEditingController();

  final List<Map<String, dynamic>> installments = [];
  final List<Map<String, dynamic>> promises = [];
  final List<Map<String, dynamic>> recoveries = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nuova Pratica"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedAgentEmail,
              decoration: const InputDecoration(labelText: 'Assegna a un agente'),
              items: ['agente1@email.com', 'agente2@email.com']
                  .map((email) => DropdownMenuItem(
                value: email,
                child: Text(email),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAgentEmail = value;
                });
              },
            ),
            const SizedBox(height: 16),
            if (!showNewDebtorFields)
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedDebtor,
                      decoration: const InputDecoration(labelText: 'Seleziona un debitore'),
                      items: ['Mario Rossi', 'Giulia Bianchi']
                          .map((debtor) => DropdownMenuItem(
                        value: debtor,
                        child: Text(debtor),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDebtor = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const NewDebtorDialog(),
                      );
                    },
                  ),

                ],
              ),
            if (showNewDebtorFields) ...[
              TextField(
                controller: newDebtorNameController,
                decoration: const InputDecoration(labelText: 'Nome debitore'),
              ),
              TextField(
                controller: newDebtorAddressController,
                decoration: const InputDecoration(labelText: 'Indirizzo'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedDebtor = newDebtorNameController.text;
                    showNewDebtorFields = false;
                  });
                },
                child: const Text("Usa questo debitore"),
              )
            ],
            const SizedBox(height: 16),
            TextField(
              controller: creditController,
              decoration: const InputDecoration(labelText: 'Credito da recuperare'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildItemSection(
              title: 'Rate',
              items: installments,
              onAdd: () => _addItemDialog('Nuova rata', false).then((value) {
                if (value != null) setState(() => installments.add(value));
              }),
            ),
            _buildItemSection(
              title: 'Promesse di pagamento',
              items: promises,
              onAdd: () => _addItemDialog('Nuova promessa di pagamento', false).then((value) {
                if (value != null) setState(() => promises.add(value));
              }),
            ),
            _buildItemSection(
              title: 'Recuperi',
              items: recoveries,
              onAdd: () => _addItemDialog('Nuovo recupero', true).then((value) {
                if (value != null) setState(() => recoveries.add(value));
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annulla"),
        ),
        ElevatedButton(
          onPressed: () {
            // In futuro: logica di salvataggio pratica
            Navigator.pop(context);
          },
          child: const Text("Crea Pratica"),
        ),
      ],
    );
  }

  Widget _buildItemSection({
    required String title,
    required List<Map<String, dynamic>> items,
    required VoidCallback onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
          ],
        ),
        ...items.map((item) => ListTile(
          title: Text('Importo: €${item['amount']}'),
          subtitle: Text(
            'Emissione: ${item['dateOfIssue']?.toString().split(" ").first}'
                '${item['accrualDate'] != null ? ' | Scadenza: ${item['accrualDate'].toString().split(" ").first}' : ''}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => items.remove(item)),
          ),
        )),
      ],
    );
  }

  Future<Map<String, dynamic>?> _addItemDialog(String title, bool isRecovery) {
    final amountController = TextEditingController();
    DateTime? issueDate;
    DateTime? accrualDate;

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setLocalState) => AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Importo'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text(issueDate != null
                      ? 'Data emissione: ${issueDate!.toLocal().toString().split(" ").first}'
                      : 'Seleziona data emissione'),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setLocalState(() {
                        issueDate = picked;
                      });
                    }
                  },
                ),
                if (!isRecovery)
                  ListTile(
                    title: Text(accrualDate != null
                        ? 'Data scadenza: ${accrualDate!.toLocal().toString().split(" ").first}'
                        : 'Seleziona data scadenza'),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setLocalState(() {
                          accrualDate = picked;
                        });
                      }
                    },
                  ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'amount': double.tryParse(amountController.text) ?? 0,
                    'dateOfIssue': issueDate ?? DateTime.now(),
                    'accrualDate': isRecovery ? null : accrualDate,
                  });
                },
                child: const Text('Aggiungi'),
              ),
            ],
          ),
        );
      },
    );
  }
}
