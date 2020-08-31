import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/addNewTransaction.dart';
import 'models/transactionModel.dart';
import 'widgets/transactionsList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
          accentColor: Colors.green[600],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _transactions = [];
  bool _showCharts = false;
  List<TransactionModel> get _lastTransactionsValues {
    return _transactions.where((trans) {
      return trans.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransFunc(String title, double amount, DateTime selectedDate) {
    final newTrans = TransactionModel(
        name: title,
        amount: amount,
        date: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      _transactions.add(newTrans);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showAddNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddNewTransaction(_addNewTransFunc),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObj = MediaQuery.of(context);
    final landScapeMode = mediaQueryObj.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expenses application'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddNewTransactionModal(context))
      ],
    );

    final transList = Container(
        height: (mediaQueryObj.size.height -
                appBar.preferredSize.height -
                mediaQueryObj.padding.top) *
            0.7,
        child: TransactionsList(_transactions, _deleteTransaction));

    final chartView = Container(
        height: (mediaQueryObj.size.height -
                appBar.preferredSize.height -
                mediaQueryObj.padding.top) *
            (landScapeMode ? 0.7 : 0.3),
        child: Chart(_lastTransactionsValues));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (landScapeMode && _transactions.isNotEmpty)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Show charts'),
                Switch(
                  value: _showCharts,
                  onChanged: (val) {
                    setState(() {
                      _showCharts = val;
                    });
                  },
                )
              ]),
            _transactions.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LayoutBuilder(builder: (ctx, constraints) {
                        return Column(children: [
                          Text('No transactions added yet',
                              style: Theme.of(context).textTheme.headline6),
                          SizedBox(
                            height: (mediaQueryObj.size.height -
                                    appBar.preferredSize.height -
                                    mediaQueryObj.padding.top) *
                                0.1,
                          ),
                          Container(
                              height: (mediaQueryObj.size.height -
                                      appBar.preferredSize.height -
                                      mediaQueryObj.padding.top) *
                                  0.4,
                              child: Image.asset(
                                'assets/images/waiting.png',
                                fit: BoxFit.cover,
                              ))
                        ]);
                      }),
                    ],
                  )
                : landScapeMode
                    ? (_showCharts ? chartView : transList)
                    : Column(
                        children: [chartView, transList],
                      )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddNewTransactionModal(context),
      ),
    );
  }
}
