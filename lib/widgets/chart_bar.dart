import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {
  final String label;
  final int spentAmount;
  final double fracSpentAmount;
  ChartBar(this.label,this.fracSpentAmount,this.spentAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('Rs. ${spentAmount.toString()}')
          ),
        SizedBox(height: 5,),
        Container(
          height: 50,
          width: 10,
          child: Stack(children: [
            
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 1),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
                ),
            ),
            FractionallySizedBox(
              heightFactor: fracSpentAmount,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              )
          ],),
        ),
        SizedBox(height: 5,),
        Text(label),
      ],
    );
  }
}