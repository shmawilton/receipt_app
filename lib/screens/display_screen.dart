import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receipt_app/models/receipt.dart';

class DisplayReceiptScreen extends StatelessWidget {
  final Receipt receipt;

  DisplayReceiptScreen({required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: SvgPicture.asset('assets/gok.svg', height: 80, width: 80),
            ),
            SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Text('COAST PROVINCIAL GENERAL', style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('HOSPITAL', style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('P. O. BOX 90231 - 80100', style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('MOMBASA - KENYA', style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('TEL: 041 - 2314204/5', style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('RECEIPT', style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _buildRow(['Client No:', receipt.clientNo, 'Date:', receipt.formattedDate]),
                _buildRow(['Client Name:', receipt.name]),
                _buildRow(['Description', 'Amount KSH']),
                ...receipt.items.entries.map((entry) => _buildRow([entry.key, entry.value.toStringAsFixed(2)])).toList(),
                _buildRow(['Total KSH', receipt.total.toStringAsFixed(2)]),
                _buildRow(['Amount Paid', receipt.amountPaid.toStringAsFixed(2)]),
                _buildRow(['Pay Mode:', receipt.payMode, 'Cashier:', receipt.cashier]),
                _buildRow(['Cash Point:', receipt.cashPoint, 'Shift No:', receipt.shiftNo]),
                _buildRow(['Operator:', receipt.operator]),
                _buildRow(['Transaction No:', receipt.transactionNo]),
                _buildRow(['Mobile Tel. No:', receipt.telNo]),
              ],
            ),
            SizedBox(height: 5), // Add some spacing after the table.
            Divider(
              color: Colors.black, // Adjust the color if needed.
              thickness: 2, // Adjust thickness if needed.
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Printing receipt...');
              },
              child: Text('Print Receipt'),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(List<String> values) {
  if (values.length == 2) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(values[0] + ' ' + values[1], style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.w300)),
        ),
      ],
    );
  } else if (values.length == 4) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(values[0] + ' ' + values[1], style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.w300)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(values[2] + ' ' + values[3], style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.w300)),
        ),
      ],
    );
  } else {
    // Single value that spans the entire row
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text(values[0], style: TextStyle(fontFamily: 'Inconsolata', fontWeight: FontWeight.w300)),
          ),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
      ],
    );
  }
}

}
