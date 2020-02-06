import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactionList;
  final Function deleteTransaction;

  TransactionList(this._transactionList, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 500,
        child: _transactionList.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Transaction Yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/no_transaction.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text('${_transactionList[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        '${_transactionList[index].txnName}',
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(_transactionList[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: ()=> deleteTransaction(_transactionList[index].id),
                      ),
                    ),
                  );
                },
                itemCount: _transactionList.length,
//        children: _transactionList.map((txn) {
//          return
//        }).toList(),)
              ),
      ),
    );
  }
}
