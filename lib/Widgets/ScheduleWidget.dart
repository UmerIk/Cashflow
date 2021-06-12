import 'package:cashflow/Extras/CColors.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {

  int i;
  ScheduleWidget(this.i);

  List<String> days = [
    'Mon' , 'Tue' , 'Wed' , 'Thu' , 'Fri' , 'Sat' , 'Sun',
  ];
  late double height , width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.symmetric(vertical: height * 0.02 , horizontal: width * 0.05),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 70,
              padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.02 ,),
              decoration: BoxDecoration(
                color: CColors.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15) ,
                    bottomLeft: Radius.circular(15),),
              ),
              alignment: Alignment.center,
              child: Text(days[i],style: TextStyle(
                color: Colors.white,
                fontFamily: 'fh',
                fontSize: 18,
              ),),
            ),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text('12:00 PM to 1:00 PM',style: TextStyle(
                    color: CColors.textgray,
                    fontSize: 15,
                    fontFamily: 'fm'
                  ),),
                )
            ),
          ],
        ),
      ),
    );
  }
}
