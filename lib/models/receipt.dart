import 'package:intl/intl.dart';

class Receipt {
  DateTime date;
  String clientNo;
  String name;
  Map<String, double> items;
  double total;
  double amountPaid;
  String payMode;
  String cashier;
  String cashPoint;
  String shiftNo;
  String operator;
  String transactionNo;
  String telNo;

  Receipt({
    required this.date,
    required this.clientNo,
    required this.name,
    required this.items,
    required this.total,
    required this.amountPaid,
    required this.payMode,
    required this.cashier,
    required this.cashPoint,
    required this.shiftNo,
    required this.operator,
    required this.transactionNo,
    required this.telNo,
  });

  String get formattedDate => DateFormat('yyyy-MM-dd @ HH:mm:ss').format(date);
}
