import 'package:flutter/material.dart';
import 'package:receipt_app/screens/input_screen.dart';

class ItemInputScreen extends StatefulWidget {
  @override
  _ItemInputScreenState createState() => _ItemInputScreenState();
}

class _ItemInputScreenState extends State<ItemInputScreen> {
  final Map<String, TextEditingController> _nameControllers = {
    'Item 1': TextEditingController(),
  };
  final Map<String, TextEditingController> _amountControllers = {
    'Item 1': TextEditingController(),
  };

  void _addItem() {
    final itemNumber = _nameControllers.length + 1;
    final itemName = 'Item $itemNumber';

    setState(() {
      _nameControllers[itemName] = TextEditingController();
      _amountControllers[itemName] = TextEditingController();
    });
  }

  void _deleteItem(String key) {
    if (_nameControllers.length > 1) {
      setState(() {
        _nameControllers.remove(key);
        _amountControllers.remove(key);
      });
    } else {
      setState(() {
        _nameControllers[key]?.clear();
        _amountControllers[key]?.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ..._nameControllers.entries.map(
              (entry) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: entry.value,
                          decoration: InputDecoration(labelText: 'Name of ${entry.key}'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _amountControllers[entry.key],
                          decoration: InputDecoration(labelText: 'Amount of ${entry.key}'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red, // Changed the color of the delete icon
                        ),
                        onPressed: () => _deleteItem(entry.key),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final items = <String, double>{};
                for (final entry in _nameControllers.entries) {
                  final name = entry.value.text;
                  final amountController = _amountControllers[entry.key];
                  if (amountController == null) continue;

                  final amountStr = amountController.text;
                  final amount = double.tryParse(amountStr);

                  if (amount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Invalid amount for $name"),
                      ),
                    );
                    return;
                  }
                  items[name] = amount;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputScreen(initialItems: items)),
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
