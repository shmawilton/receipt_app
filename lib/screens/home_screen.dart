import 'package:flutter/material.dart';
import 'package:receipt_app/screens/item_input_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemInputScreen()),
            );
          },
          child: Text('Create Receipt'),
        ),
      ),
    );
  }
}
