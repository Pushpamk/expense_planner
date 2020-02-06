import '../models/transaction.dart';
import './chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> lastTransactions;

  Chart(this.lastTransactions);

  var totalAmount = 0.0;

  List<Map<String, Object>> get lastWeekTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var amount = 0.0;
      for (var i = 0; i < lastTransactions.length; i++) {
        if (weekDay.day == lastTransactions[i].date.day &&
            weekDay.month == lastTransactions[i].date.month &&
            weekDay.year == lastTransactions[i].date.year) {
          amount += lastTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'Amount': amount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return lastWeekTransaction.fold(0.0, (sum, item) {
      return sum + item['Amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(lastWeekTransaction);
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: lastWeekTransaction.map((tx) {
        return Flexible(
          fit: FlexFit.tight,
          child: ChartBar(
              label: tx['day'],
              totalSum: tx['Amount'],
              perTotalSum: totalSpending == 0.0? 0.0 : (tx['Amount'] as double) / totalSpending,
          ),
        );
      }).toList()),
    );
  }
}
