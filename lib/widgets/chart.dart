import 'package:flutter/material.dart';
import '../widgets/chartBar.dart';
import '../models/transactionModel.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get lastTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumOfTrans = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSumOfTrans += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSumOfTrans};
    }).reversed.toList();
  }

  double get totalWeekAmount {
    return lastTransactionsValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(25),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: lastTransactionsValues.map((dayData) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(dayData['day'], dayData['amount'],
                  (dayData['amount'] as double) / totalWeekAmount),
            );
          }).toList(),
        ),
      ),
    );
  }
}
