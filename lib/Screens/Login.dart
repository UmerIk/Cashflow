
import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Extras/Paths.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class Login extends StatelessWidget {

  double width = 0, height = 0;
  bool obsecuretext = true;

  var econtroller = TextEditingController();
  var pcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02 , horizontal: width * 0.05),
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagePath.login_back),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage(ImagePath.logo) , width: width * 0.6,),


              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: height * 0.01),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.003),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      controller: econtroller,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: (){
                        node.nextFocus();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontFamily: 'futura',
                        )
                      ),
                    ),
                  ),
                  StatefulBuilder(builder: (ctx , setState){
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.003),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        controller: pcontroller,
                        obscureText: obsecuretext,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'futura',
                            ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: obsecuretext ? CColors.primary : Colors
                                  .grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obsecuretext = !obsecuretext;
                              });
                            },
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: (){
                          node.unfocus();
                        },
                      ),
                    );
                  },),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: () {
                      if(!EmailValidator.validate(econtroller.text)){
                        Fluttertoast.showToast(msg: "Invalid Email");
                      }else if(pcontroller.text.trim().length < 6){
                        Fluttertoast.showToast(msg: "Password should contain atleast 6 characters");
                      }else{
                        login(context);
                      }
                    }, child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1 , vertical: height * 0.015),
                      decoration: BoxDecoration(
                        color: CColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text('Login',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'magic',
                        fontSize: 18,
                      ),),
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(BuildContext context){
    Functions().showLoaderDialog(context,text: 'Loging in');
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: econtroller.text.trim(),
        password: pcontroller.text.trim()
    ).then((value){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
        return Home();
      }), (route) => false);
    }).catchError((error){
      Navigator.of(context).pop();
      FirebaseAuthException ex = error;
      Fluttertoast.showToast(msg: ex.message.toString());
    });
  }
}
