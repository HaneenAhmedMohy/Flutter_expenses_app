import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTransaction extends StatefulWidget {
  final Function addTransactionFunc;

  AddNewTransaction(this.addTransactionFunc);

  @override
  _AddNewTransactionState createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime pickedDate;

  void onSubmitData() {
    final enteredName = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredName.isEmpty || enteredAmount <= 0 || pickedDate == null) {
      return;
    }

    widget.addTransactionFunc(
        titleController.text, double.parse(amountController.text), pickedDate);
    Navigator.of(context).pop();
  }

  void showDatePickerModal() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2017),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => onSubmitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => onSubmitData(),
              ),
              Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(pickedDate == null
                          ? 'No date chosen'
                          : 'Picked date : ${DateFormat.yMd().format(pickedDate)}'),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: showDatePickerModal,
                    )
                  ],
                ),
              ),
              FlatButton(
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                onPressed: onSubmitData,
                textColor: Theme.of(context).buttonColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
