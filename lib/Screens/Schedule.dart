import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Widgets/ScheduleWidget.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  String name;

  Schedule(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Text(name , style: TextStyle(
                color: CColors.primary,
                fontFamily: 'magic',
                fontSize: 40,
              ),),
              Expanded(
                  child: ListView.builder(itemBuilder: (ctx,i){
                    return ScheduleWidget(i);
                  }, itemCount: 7,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
