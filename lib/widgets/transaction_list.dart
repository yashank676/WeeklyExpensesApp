import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatefulWidget {

  final List<Transaction>transactions;
  final Function deletetx;
  TransactionList(this.transactions,this.deletetx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  
  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;

    return widget.transactions.isEmpty? 
       LayoutBuilder(builder: (ctx,constraints){
         return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Text(
          'C\'mon....spend some money',
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),
        ),
        SizedBox(height: 5,),
        if(isLandscape)
        Container(
          //height: constraints.maxHeight*0.7,
          width: constraints.maxWidth*0.4,
          child: Image.asset('assets/images/waiting2.png',fit: BoxFit.cover,)
          ),
          if(!isLandscape)
          Container(
          //height: constraints.maxHeight*0.7,
          width: constraints.maxWidth*0.8,
          child: Image.asset('assets/images/waiting2.png',fit: BoxFit.cover,)
          ),
      ],);
       })
       :ListView.builder(
                  itemBuilder: (cntx,index){
                     return Card(
                       elevation: 10,
                       margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                       child: ListTile(
                         leading: CircleAvatar(
                           radius: 35,
                           backgroundColor: Colors.amber,
                           //maxRadius: 60,
                           child: Padding(
                             padding: const EdgeInsets.all(3),
                             child: FittedBox(child: Text('₹${widget.transactions[index].amount}',style: TextStyle(fontWeight: FontWeight.bold),),),
                           )
                         ),
                         title: Text(
                           widget.transactions[index].title,
                           style: Theme.of(context).textTheme.title,
                           ),
                           subtitle: Text(DateFormat.yMMMd().format(widget.transactions[index].date)),
                           trailing:MediaQuery.of(context).size.width>450 ?
                             FlatButton.icon(
                               onPressed: (){
                               widget.deletetx(widget.transactions[index].id);
                             }, icon: Icon(Icons.delete_rounded), label: Text('Delete'),textColor: Theme.of(context).errorColor,)
                             :
                             IconButton(
                             icon: Icon(Icons.delete_rounded),
                             color: Theme.of(context).errorColor,
                             onPressed: (){
                               widget.deletetx(widget.transactions[index].id);
                             },
                             ),
                       ),
                     );
                  },
                  itemCount: widget.transactions.length,

    );
           }
}