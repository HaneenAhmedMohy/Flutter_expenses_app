import 'package:flutter/material.dart';
import 'package:flutter_expenses_app/models/transactionModel.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final Function deleteTransaction;
  TransactionsList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Container()
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTransaction(transactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
