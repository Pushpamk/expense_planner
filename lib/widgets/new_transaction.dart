import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction, );

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final transactionName = TextEditingController();
  final transactionAmount = TextEditingController();
  DateTime enteredDate;

  void _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return ;
      }
      else{
        setState(() {
          enteredDate = pickedDate;
        });
      }
    });
  }

  void submitData() {
    final enteredTxnName = transactionName.text;
    final enteredAmount = double.parse(transactionAmount.text);

    if (enteredTxnName.isEmpty || enteredAmount <= 0 || enteredAmount == null) {
      return;
    }
    widget.addNewTransaction(
      enteredTxnName,
      enteredAmount,
      enteredDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Transaction Name'),
            controller: transactionName,
            style: Theme.of(context).textTheme.title,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: transactionAmount,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.title,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: <Widget>[
                Text(
                  enteredDate == null ? 'No Date Choosed' : '${DateFormat.yMd().format(enteredDate)}',
                  style: enteredDate == null ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  child: Text('Choose Date'),
                  onPressed: () {
                    _chooseDate();
                  },
                  color: Colors.cyanAccent,
                )
              ],
            ),
          ),
          RaisedButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            color: Colors.cyanAccent,
            //color: Theme.of(context).primaryColor,
            onPressed: submitData,
          )
        ],
      ),
    );
  }
}
