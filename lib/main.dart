import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(amount: 38000, date: DateTime.now(), id: 'a1', title: 'MI 10T'),
    Transaction(
        amount: 65000, date: DateTime.now(), id: 'a2', title: 'ASUS TUF'),
  ];
  late String titleInput;
  late String amountInput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              child: Text('CHART'),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    autocorrect: true,
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (val){titleInput=val;},
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    onChanged: (val){amountInput=val;},
                  ),
                  FlatButton(onPressed: (){
                    print(titleInput);
                    print(amountInput);
                  }, 
                  child: Text('Add Transaction',style: TextStyle(fontSize: 15),),
                  textColor: Colors.red,
                  )
                  ],
                  ),
            ),
                ),
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Rs. ${tx.amount}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx.title,
                          style: TextStyle(
                              fontSize: 17.5, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMd().format(tx.date),
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
