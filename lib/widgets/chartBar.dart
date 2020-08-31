import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double amountPercentage;

  ChartBar(this.day, this.amount, this.amountPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(children: [
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black, width: 1)),
              ),
              FractionallySizedBox(
                heightFactor: amountPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(day)))
      ]);
    });
  }
}
