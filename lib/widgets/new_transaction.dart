import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_expenses/widgets/adaptiveFlatButtton.dart';

class newTransaction extends StatefulWidget {

  //late String titleInput;
  //late String amountInput;
  final Function addTx;
  newTransaction(this.addTx);

  @override
  _newTransactionState createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final _titlecontroller=TextEditingController();
  final _amountcontroller=TextEditingController();
  DateTime? _selectedDate=null;

  void _SubmitData()
  {
    final enteredTitle=_titlecontroller.text;
    final enteredAmount=int.parse(_amountcontroller.text);
    if(enteredAmount<=0 || enteredTitle.isEmpty || _selectedDate==null)
    return;

    widget.addTx(enteredTitle,enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _DatePicker()
  {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now(),
      ).then((pickedDate){
        if(pickedDate==null)
        return;
        setState(() {
           _selectedDate=pickedDate;
        });
       
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
              child: Container(
                padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      autocorrect: true,
                      decoration: InputDecoration(labelText: 'Title'),
                      //onChanged: (val){titleInput=val;},
                      controller: _titlecontroller,
                      onSubmitted: (_)=>_SubmitData(),
    
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      //onChanged: (val){amountInput=val;},
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_)=>_SubmitData(),
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(_selectedDate==null?'No Date Chosen':"Transaction Date: ${DateFormat.yMEd().format(_selectedDate!)}")),
                            adaptiveFlatButton('Choose Date',_DatePicker),
                        ],
                      ),
                    ),
                    RaisedButton(
                      color: Colors.grey[100],
                      elevation: 5,
                      onPressed: (){
                      //print(titleInput);
                      //print(amountInput);
                      print(_titlecontroller.text);
                      print(_amountcontroller.text);
                      // ignore: unnecessary_statements
                      _SubmitData();
    
                    }, 
                    child: Text('Add Transaction',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),),
                    textColor: Colors.red,
                    )
                    ],
                    ),
              ),
                  ),
    );
  }
}