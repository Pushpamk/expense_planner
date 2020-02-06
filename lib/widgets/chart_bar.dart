import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalSum;
  final double perTotalSum;

  ChartBar({this.label, this.totalSum, this.perTotalSum});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: Text('${totalSum}'),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 100,
            width: 20,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: 1-perTotalSum,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('${label}'),
        ],
      ),
    );
  }
}
