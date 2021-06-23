import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main(){
// this code is to force only portrait mode
/*
WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]
  );
*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.black,
        errorColor: Colors.black,
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

   void _addNewTransaction(String Title,int Amount,DateTime chosenDate)
   {
     final newTx=Transaction(amount: Amount,title: Title,date: chosenDate,id: DateTime.now().toString());
     setState(() {
       _userTransactions.add(newTx);
     });
   }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return newTransaction(_addNewTransaction);
    });
  }

  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id);
    });
  }

  bool _showChart=false;
  
  @override
  Widget build(BuildContext context) {
     final mediaQuery=MediaQuery.of(context);
    final appbar= Platform.isIOS? CupertinoNavigationBar(
      middle: Text('Weekly Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        GestureDetector(
          onTap: () => _startAddNewTransaction(context),
          child: Icon(CupertinoIcons.add),
        )
      ],),
    ):AppBar(
        title: Text('Weekly Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box,size: 30,),
            onPressed: () => _startAddNewTransaction(context),
            //color: Colors.limeAccent,
          )
        ],
      ) as PreferredSizeWidget;

      final isLandscape=mediaQuery.orientation==Orientation.landscape;
      final txListWidget=Container(
              height: (mediaQuery.size.height-appbar.preferredSize.height-mediaQuery.padding.top),
              child: TransactionList(_userTransactions,_deleteTransaction));
      final pageBody=SafeArea(child:SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Show Chart',style: TextStyle(fontFamily: 'Quicksand',fontSize: 20),),
              Switch.adaptive(value: _showChart, onChanged: (val){
                setState(() {
                  _showChart=val; 
                });
              }),
            ],),
            if(isLandscape)
            _showChart?
            Container(
              height: (mediaQuery.size.height-appbar.preferredSize.height-mediaQuery.padding.top)*0.7,
              child: Chart(_recentTransactions))
            :
            txListWidget
            ,
            if(!isLandscape)
            Container(
              height: (mediaQuery.size.height-appbar.preferredSize.height-mediaQuery.padding.top)*0.3,
              child: Chart(_recentTransactions)),
            if(!isLandscape)
            Container(
              height: (mediaQuery.size.height-appbar.preferredSize.height-mediaQuery.padding.top)*0.7,
              child: TransactionList(_userTransactions,_deleteTransaction)),
          ],
        ),
      ),);
     return Platform.isIOS? CupertinoPageScaffold(
       child: pageBody,
       navigationBar: appbar as ObstructingPreferredSizeWidget,
     )
     :
     Scaffold(
      appBar: appbar,
      body: pageBody,
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Platform.isIOS? Container():FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        ),
    );
  }
}
