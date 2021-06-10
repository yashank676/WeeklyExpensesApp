import 'package:flutter/material.dart';
import 'transaction.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              child: Text('CHART'),
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
                        tx.amount.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    Column(
                      children: [
                        Text(tx.title),
                        Text(tx.date.toString()),
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
