import 'package:flutter/material.dart';
import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;// list to get transactions list
  
  Chart(this.recentTransaction);// method to get transaction list

  List <Map<String,Object>> get groupedTransactionValues{
   
    return List.generate(7, (index) {
      final weekDay=DateTime.now().subtract(Duration(days: index));//we get the weekday using this variable
      int totalSum=0;
      for(var i=0;i<recentTransaction.length;++i)
      {
        if(recentTransaction[i].date.day==weekDay.day&&
          recentTransaction[i].date.month==weekDay.month&& 
          recentTransaction[i].date.year==weekDay.year)
          {
            totalSum+=recentTransaction[i].amount;
          }
      }
      
      //print(DateFormat.E().format(weekDay));
      //print(totalSum);
      
      return {
        'day':DateFormat.E().format(weekDay),
        'amount':totalSum,

      };
    });
  }
  double get totalSpending{
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + (item['amount'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  
          groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'] as String,
                  totalSpending==0?0.0:(data['amount'] as int)*1.0/totalSpending,
                  (data['amount'] as int)),
              );
            }).toList(),
          
        ),
      ),
    );
  }
}