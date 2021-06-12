import 'package:flutter/material.dart';

class BMScreen extends StatelessWidget {

  late double width , height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/hbd.jpg' , width: width * 0.5,),
                SizedBox(height: 20,),
                Text('Happy Birthday Lindsey, I love you so much! I am so proud of you and what you have accomplished, it is so nice to see people in Bovec finally taking advantage of your amazing yoga in the valley! I know how hard you have worked to get to this point and I know how much you love this stuff, It makes me so happy to see you doing what you love! Anyway, I hope this will help you manage your events, I know how much of a hassle it can be managing everything in Austin, organizing and coordinating with all of the teachers. I hope this helps save you some time! You have done so much already, I am so lucky to have found you and get to share an amazing life with my adventure partner in the best place in the world! I can\'t wait to see what lies ahead for you and for us.... Happy Birthday Lindsey, I hope its the best year yet! LJUBI TE ADVENTURE PARTNER!'
                  ,style: TextStyle(
                  color: Color(0xff2e2624),
                  fontFamily: 'fm',
                  fontSize: 18,
                ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
