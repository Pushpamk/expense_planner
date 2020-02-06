import 'dart:math';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.black,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactionList = [];

  void _addNewTransaction(
      String _txnname, double _txnamount, DateTime txnDate) {
    var rng = new Random.secure();
    final _newTransaction = Transaction(
      txnName: _txnname,
      amount: _txnamount,
      date: txnDate,
      id: rng.hashCode,
    );
    setState(() {
      _transactionList.add(_newTransaction);
    });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _transactionList.removeWhere((txn) => txn.id == id);
    });
  }

  void _startNewTransactionList(BuildContext bctx) {
    showModalBottomSheet(
        context: bctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _transactionList.where((txn) {
      return txn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Your monthly expenses'),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Switch(
              value: _showChart,
              onChanged: (val) {
                return setState(() {
                  _showChart = val;
                });
              },
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                    child: Chart(_recentTransaction))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            appbar.preferredSize.height) *
                        0.6,
                    child:
                        TransactionList(_transactionList, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startNewTransactionList(context);
        },
        elevation: 5,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                leading: Icon(
                  Icons.arrow_back,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
              ),
              title: Text('Monthly Expenses Manager'),
              onTap: () {
                Navigator.pop(context);
              },
              subtitle:
                  Text('This app helps you managing your monthly expenses.'),
            ),
          ],
        ),
      ),
    );
  }
}
