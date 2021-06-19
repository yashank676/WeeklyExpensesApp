import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {

  final List<Transaction>transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      child: transactions.isEmpty? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Text(
          'C\'mon....spend some money',
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),
        ),
        SizedBox(height: 30,),
        Container(
          //height: 500,
          width: 500,
          child: Image.asset('assets/images/waiting2.png',fit: BoxFit.cover,)
          )
      ],):ListView.builder(
                  itemBuilder: (cntx,index){
                     return ListTile(
                       leading: CircleAvatar(
                         radius: 30,
                         backgroundColor: Colors.amber,
                         //maxRadius: 60,
                         child: Padding(
                           padding: const EdgeInsets.all(3),
                           child: FittedBox(child: Text('Rs. ${transactions[index].amount}',style: TextStyle(fontWeight: FontWeight.bold),),),
                         )
                         
                       ),
                     );
                  },
                  itemCount: transactions.length,
                ),
      
    );
           }
}