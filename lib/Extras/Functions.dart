import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CColors.dart';


class Functions{

  static String millisecondstodate(String dateFormat , int milliseconds){
    return DateFormat(dateFormat).format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }

  showLoaderDialog(BuildContext context , {String text = 'Loading'}){
    AlertDialog alert=AlertDialog(
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Container(margin: EdgeInsets.only(top: 20),
                child:Text("$text..." ,style: TextStyle(
                  color: CColors.textblack,
                  fontFamily: 'FuturaMedium',
                  fontSize: 18,
                ),)
            ),
          ],),
      ),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  showinfo(BuildContext context , text){
    AlertDialog alert=AlertDialog(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: double.infinity,
        child: Container(margin: EdgeInsets.only(),
            child:Text("$text" ,style: TextStyle(
              color: Colors.white,
              fontFamily: 'FuturaMedium',
              fontSize: 18,
            ),)
        ),
      ),
    );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}