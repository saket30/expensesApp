import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekday= DateTime.now().subtract(Duration(days:index),);
      var totalSum=0.0;

      for(var i=0; i<recentTransaction.length; i++){
        if(recentTransaction[i].date.day== weekday.day &&
        recentTransaction[i].date.month== weekday.month &&
        recentTransaction[i].date.year== weekday.year){
          totalSum+= recentTransaction[i].amount;
        }
      }


      return{'day': DateFormat.E().format(weekday).substring(0,1), 'amount':totalSum};
    }).reversed.toList();

  }
  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum,item) {
      return sum + item['amount'];

    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data){
            return Flexible(
              fit: FlexFit.tight,
                        child: Bar(
                data['day'],
                data['amount'], 
                totalSpending==0.0? 0.0: (data['amount']as double) /totalSpending),
            );
          }).toList(),
        ),
      ),
      
    );
  }
}