import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receipt_app/models/receipt.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class DisplayReceiptScreen extends StatefulWidget {
  final Receipt receipt;

  DisplayReceiptScreen({required this.receipt});

  @override
  _DisplayReceiptScreenState createState() => _DisplayReceiptScreenState();
}

class _DisplayReceiptScreenState extends State<DisplayReceiptScreen> {
  final WidgetsToImageController controller = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            WidgetsToImage(
              controller: controller,
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset('assets/gok.svg', height: 90, width: 90),
                  ),
                  SizedBox(height: 18),
                  Center(
                    child: Column(
                      children: [
                        Text('COAST PROVINCIAL GENERAL', style: TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 18)),
                        Text('HOSPITAL', style: TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 18)),
                        Text('P. O. BOX 90231 - 80100', style: TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 18)),
                        Text('MOMBASA - KENYA', style: TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 18)),
                        Text('TEL: 041 - 2314204/5', style: TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 18)),
                        Text('RECEIPT', style: TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Table(
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      _buildRow(['Client No:', widget.receipt.clientNo, 'Date:', widget.receipt.formattedDate]),
                      _buildRow(['Client Name', widget.receipt.name]),
                      _buildRow(['Description', 'Amount KSH']),
                      ...widget.receipt.items.entries.map((entry) => _buildRow([entry.key, entry.value.toStringAsFixed(2)])).toList(),
                      _buildRow(['Total KSH', widget.receipt.total.toStringAsFixed(2)]),
                      _buildRow(['Amount Paid', widget.receipt.amountPaid.toStringAsFixed(2)]),
                      _buildRow(['Pay Mode:', widget.receipt.payMode, 'Cashier:', widget.receipt.cashier]),
                      _buildRow(['Cash Point:', widget.receipt.cashPoint, 'Shift No:', widget.receipt.shiftNo]),
                      _buildRow(['Operator', widget.receipt.operator]),
                      _buildRow(['Transaction No', widget.receipt.transactionNo]),
                      _buildRow(['Mobile Tel. No', widget.receipt.telNo]),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _captureAndShowImage,
              child: Text('Print Receipt'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndShowImage() async {
    final bytes = await controller.capture();
    if (bytes != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Image.memory(bytes),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  TableRow _buildRow(List<String> values) {
    TextStyle baseStyle = TextStyle(fontFamily: 'CourierPrime', fontWeight: FontWeight.w700, fontSize: 14);
    bool isSpecialRow = values.length == 2 && values[0] == 'Description' && values[1] == 'Amount KSH';
    bool isAmountRow = values.length == 2 && values[1].contains(RegExp(r'^[0-9]+(\.[0-9]{1,2})?$'));

    if (values.length == 2) {
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(values[0],
                style: isSpecialRow 
                    ? baseStyle.copyWith(fontWeight: FontWeight.bold, fontSize: baseStyle.fontSize! + 2)
                    : (isAmountRow 
                        ? baseStyle.copyWith(fontWeight: FontWeight.bold)
                        : baseStyle),
                textAlign: (isSpecialRow || isAmountRow) ? TextAlign.center : TextAlign.left),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(values[1],
                style: isSpecialRow 
                    ? baseStyle.copyWith(fontWeight: FontWeight.bold, fontSize: baseStyle.fontSize! + 2)
                    : (isAmountRow 
                        ? baseStyle.copyWith(fontWeight: FontWeight.bold)
                        : baseStyle),
                textAlign: (isAmountRow) ? TextAlign.right : TextAlign.left),
          ),
        ],
      );
    } else if (values.length == 4) {
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(values[0] + ' ' + values[1], style: baseStyle, textAlign: TextAlign.left),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(values[2] + ' ' + values[3], style: baseStyle, textAlign: TextAlign.left),
          ),
        ],
      );
    } else {
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(values[0], style: baseStyle, textAlign: TextAlign.left),
          ),
          Container(),
        ],
      );
    }
  }
}
