import 'package:flutter/material.dart';
import 'package:receipt_app/models/receipt.dart';
import 'package:receipt_app/screens/display_screen.dart';
import 'package:intl/intl.dart';

class InputScreen extends StatefulWidget {
  final Map<String, double> initialItems;

  InputScreen({required this.initialItems});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late final Map<String, TextEditingController> _itemControllers;

  @override
  void initState() {
    super.initState();
    _itemControllers = widget.initialItems.map(
      (key, value) => MapEntry(key, TextEditingController(text: value.toString())),
    );
  }

  final TextEditingController _clientNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _payModeController = TextEditingController();
  final TextEditingController _cashierController = TextEditingController();
  final TextEditingController _cashPointController = TextEditingController();
  final TextEditingController _shiftNoController = TextEditingController();
  final TextEditingController _operatorController = TextEditingController();
  final TextEditingController _transactionNoController = TextEditingController();
  final TextEditingController _telNoController = TextEditingController();

  // final Map<String, TextEditingController> _itemControllers = {
  //   'Permanent Filing': TextEditingController(),
  //   // add more item controllers if needed
  // };

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _clientNoController,
              decoration: InputDecoration(labelText: 'Client No'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            ..._itemControllers.entries.map(
              (entry) => TextField(
                controller: entry.value,
                decoration: InputDecoration(labelText: entry.key),
                keyboardType: TextInputType.number,
              ),
            ),
            TextField(
              controller: _payModeController,
              decoration: InputDecoration(labelText: 'Pay Mode'),
            ),
            TextField(
              controller: _cashierController,
              decoration: InputDecoration(labelText: 'Cashier'),
            ),
            TextField(
              controller: _cashPointController,
              decoration: InputDecoration(labelText: 'Cash Point'),
            ),
            TextField(
              controller: _shiftNoController,
              decoration: InputDecoration(labelText: 'Shift No'),
            ),
            TextField(
              controller: _operatorController,
              decoration: InputDecoration(labelText: 'Operator'),
            ),
            TextField(
              controller: _transactionNoController,
              decoration: InputDecoration(labelText: 'Transaction No'),
            ),
            TextField(
              controller: _telNoController,
              decoration: InputDecoration(labelText: 'Tel No'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final date = DateTime.now();
                final clientNo = _clientNoController.text;
                final name = _nameController.text;
                final payMode = _payModeController.text;
                final cashier = _cashierController.text;
                final cashPoint = _cashPointController.text;
                final shiftNo = _shiftNoController.text;
                final operator = _operatorController.text;
                final transactionNo = _transactionNoController.text;
                final telNo = _telNoController.text;

               final items = _itemControllers.map((key, controller) => MapEntry(key, double.tryParse(controller.text) ?? 0.0));

                final total = items.values.reduce((value, element) => value + element);
                final amountPaid = total;

                final receipt = Receipt(
                  date: date,
                  clientNo: clientNo,
                  name: name,
                  items: items,
                  total: total,
                  amountPaid: amountPaid,
                  payMode: payMode,
                  cashier: cashier,
                  cashPoint: cashPoint,
                  shiftNo: shiftNo,
                  operator: operator,
                  transactionNo: transactionNo,
                  telNo: telNo,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayReceiptScreen(receipt: receipt)),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
