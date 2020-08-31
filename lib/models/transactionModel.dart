import 'package:flutter/foundation.dart';

class TransactionModel {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  TransactionModel(
      {@required this.id,
      @required this.name,
      @required this.amount,
      @required this.date});
}
