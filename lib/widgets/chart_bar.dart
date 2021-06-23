import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {
  final String label;
  final int spentAmount;
  final double fracSpentAmount;
  ChartBar(this.label,this.fracSpentAmount,this.spentAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(
      children: [
        Container(
          height: constraints.maxHeight *0.15,
          child: FittedBox(
            child: Text('₹${spentAmount.toString()}')
            ),
        ),
        SizedBox(height: constraints.maxHeight *0.05,),
        Container(
          height: constraints.maxHeight *0.6,
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
        SizedBox(height: constraints.maxHeight *0.05,),
        Container(
          height: constraints.maxHeight *0.125,
          child: FittedBox(child: Text(label))),
      ],
    );
    });
    
  }
}