import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDebtorDialog extends StatefulWidget {
  const NewDebtorDialog({super.key});

  @override
  State<NewDebtorDialog> createState() => _NewDebtorDialogState();
}

class _NewDebtorDialogState extends State<NewDebtorDialog> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final taxCodeController = TextEditingController();
  final vatController = TextEditingController();
  DateTime? dateOfBirth;

  List<Map<String, String>> addresses = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuovo Debitore'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Dati Account', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Telefono')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password')),

            const SizedBox(height: 16),
            const Text('Dati Personali', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: surnameController, decoration: const InputDecoration(labelText: 'Cognome')),
            TextField(controller: taxCodeController, decoration: const InputDecoration(labelText: 'Codice Fiscale')),
            TextField(controller: vatController, decoration: const InputDecoration(labelText: 'Partita IVA (facoltativa)')),
            const SizedBox(height: 8),
            ListTile(
              title: Text(dateOfBirth != null
                  ? 'Data di nascita: ${dateOfBirth!.toLocal().toString().split(" ").first}'
                  : 'Seleziona data di nascita'),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(1990),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    dateOfBirth = picked;
                  });
                }
              },
            ),

            const Divider(),
            const Text('Indirizzi', style: TextStyle(fontWeight: FontWeight.bold)),
            ...addresses.map((address) => ListTile(
              title: Text('${address['typeStreet']} ${address['nameStreet']}, ${address['houseNumber']}'),
              subtitle: Text('${address['city']} (${address['province']}) - ${address['zip']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => setState(() => addresses.remove(address)),
              ),
            )),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Aggiungi indirizzo'),
              onPressed: () => _showAddressDialog(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () {
            // In futuro: raccolta dati e creazione del debitore
            Navigator.pop(context);
          },
          child: const Text('Crea Debitore'),
        ),
      ],
    );
  }

  void _showAddressDialog() {
    final houseController = TextEditingController();
    final streetController = TextEditingController();
    final typeController = TextEditingController();

    final cityController = TextEditingController();
    final provinceController = TextEditingController();
    final regionController = TextEditingController();
    final zipController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nuovo Indirizzo'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: houseController, decoration: const InputDecoration(labelText: 'Numero civico')),
              TextField(controller: streetController, decoration: const InputDecoration(labelText: 'Nome via')),
              TextField(controller: typeController, decoration: const InputDecoration(labelText: 'Tipo via (es. Via, Viale, etc.)')),
              const SizedBox(height: 16),
              TextField(controller: cityController, decoration: const InputDecoration(labelText: 'Città')),
              TextField(controller: provinceController, decoration: const InputDecoration(labelText: 'Provincia')),
              TextField(controller: regionController, decoration: const InputDecoration(labelText: 'Regione')),
              TextField(controller: zipController, decoration: const InputDecoration(labelText: 'CAP')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                addresses.add({
                  'houseNumber': houseController.text,
                  'nameStreet': streetController.text,
                  'typeStreet': typeController.text,
                  'city': cityController.text,
                  'province': provinceController.text,
                  'region': regionController.text,
                  'zip': zipController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Aggiungi'),
          )
        ],
      ),
    );
  }
}
