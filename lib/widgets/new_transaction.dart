import 'package:flutter/material.dart';

class newTransaction extends StatefulWidget {

  //late String titleInput;
  //late String amountInput;
  final Function addTx;
  newTransaction(this.addTx);

  @override
  _newTransactionState createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final titlecontroller=TextEditingController();

  final amountcontroller=TextEditingController();

  void SubmitData()
  {
    final enteredTitle=titlecontroller.text;
    final enteredAmount=int.parse(amountcontroller.text);
    if(enteredAmount<=0 || enteredTitle.isEmpty)
    return;

    widget.addTx(enteredTitle,enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    autocorrect: true,
                    decoration: InputDecoration(labelText: 'Title'),
                    //onChanged: (val){titleInput=val;},
                    controller: titlecontroller,
                    onSubmitted: (_)=>SubmitData(),

                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    //onChanged: (val){amountInput=val;},
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_)=>SubmitData(),
                  ),
                  FlatButton(onPressed: (){
                    //print(titleInput);
                    //print(amountInput);
                    print(titlecontroller.text);
                    print(amountcontroller.text);
                    // ignore: unnecessary_statements
                    SubmitData();

                  }, 
                  child: Text('Add Transaction',style: TextStyle(fontSize: 15),),
                  textColor: Colors.red,
                  )
                  ],
                  ),
            ),
                );
  }
}