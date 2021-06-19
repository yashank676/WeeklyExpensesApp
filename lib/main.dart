import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.black,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontFamily: 'Quicksand',fontWeight: FontWeight.bold,fontSize: 18)
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   final List<Transaction> _userTransactions = [];
   
   List<Transaction> get _recentTransactions{
     return _userTransactions.where((tx) {
       return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
     }).toList();
   }

   void _addNewTransaction(String Title,int Amount)
   {
     final newTx=Transaction(amount: Amount,title: Title,date: DateTime.now(),id: DateTime.now().toString());
     setState(() {
       _userTransactions.add(newTx);
     });
   }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return newTransaction(_addNewTransaction);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box,size: 30,),
            onPressed: () => _startAddNewTransaction(context),
            //color: Colors.limeAccent,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        ),
    );
  }
}
