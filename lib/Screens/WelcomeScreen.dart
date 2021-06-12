import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Paths.dart';
import 'package:cashflow/Screens/Login.dart';
import 'package:cashflow/Screens/RegisterScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  double width = 0, height = 0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagePath.signup_back),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Image(image: AssetImage(ImagePath.logo) , width: width * 0.6,),

              Column(
                children: [
                  // Text('Seek Adventure, Experience culture,\n Find your Zen',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontFamily: 'futura',
                  //     color: Colors.white,
                  //     fontSize: 15
                  //   ),
                  // ),
                  SizedBox(height: height * 0.01,),
                  TextButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return RegisterScreen();
                    }));
                  }, child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1 , vertical: height * 0.015),
                    decoration: BoxDecoration(
                      color: CColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('Join us',style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'magic',
                      fontSize: 18,
                    ),),
                  ),

                  ),
                  SizedBox(height: height * 0.01,),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: RichText(
                      text: new TextSpan(
                        text: 'Already a member?  ',
                        style: TextStyle(
                            color: Colors.white,
                          fontFamily: 'futura',
                          fontSize: 16
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx){
                                    return Login();
                                  }));
                            },
                            style: TextStyle(
                                color: CColors.primary,
                                fontFamily: 'futura',
                                fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
