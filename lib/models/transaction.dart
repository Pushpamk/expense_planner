import 'package:flutter/foundation.dart';

class Transaction {
  final int id;
  final String txnName;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.txnName,
    @required this.amount,
    @required this.date,
  });
}
