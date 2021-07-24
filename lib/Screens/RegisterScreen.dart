import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Paths.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class RegisterScreen extends StatelessWidget {

  double width = 0, height = 0;
  bool obsecuretext = true;
  bool obsecuretext2 = true;

  var ec = TextEditingController();
  // var phc = TextEditingController();
  var pc = TextEditingController();
  var cpc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var node = FocusScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02 , horizontal: width * 0.05),
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.registeration_back),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Align(
                alignment: Alignment.center,
                child: Text('Get Registered',style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'magic',
                  fontSize: 70,
                ),
                  textAlign: TextAlign.end,
                ),
              ),

              // Image(image: AssetImage(ImagePath.logo) , width: width * 0.6,),


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
                      controller: ec,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: ()=>node.nextFocus(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: 'futura',
                          )
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: height * 0.01),
                  //   padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.003),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white70,
                  //       borderRadius: BorderRadius.circular(20)
                  //   ),
                  //   child: TextField(
                  //     // controller: phc,
                  //     textInputAction: TextInputAction.next,
                  //     onEditingComplete: ()=>node.nextFocus(),
                  //     decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         hintText: 'Phone',
                  //         hintStyle: TextStyle(
                  //           fontFamily: 'futura',
                  //         )
                  //     ),
                  //   ),
                  // ),
                  StatefulBuilder(builder: (ctx , setState){
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.003),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        controller: pc,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>node.nextFocus(),
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

                      ),
                    );
                  },),
                  StatefulBuilder(builder: (ctx , setState){
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.003),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        controller: cpc,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: ()=>node.nextFocus(),
                        obscureText: obsecuretext2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            fontFamily: 'futura',
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: obsecuretext2 ? CColors.primary : Colors
                                  .grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obsecuretext2 = !obsecuretext2;
                              });
                            },
                          ),
                        ),

                      ),
                    );
                  },),


                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: () {
                      if(validate()){
                        register(context);
                      }
                    }, child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1 , vertical: height * 0.015),
                      decoration: BoxDecoration(
                        color: CColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text('Register',style: TextStyle(
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
  bool validate(){
    if(!EmailValidator.validate(ec.text.trim())){
      Fluttertoast.showToast(msg: "Invalid Email");
    // }else if(phc.text.trim().isEmpty){
    //   Fluttertoast.showToast(msg: "Invalid Phone");
    }else if(pc.text.trim().length < 6){
      Fluttertoast.showToast(msg: "Password should contain atleast 6 characters");
    }else if(pc.text.trim() != cpc.text.trim()){
      Fluttertoast.showToast(msg: "Password didn\'t matched");
    }else{
      return true;
    }
    return false;
  }

  register(BuildContext context){
    Functions().showLoaderDialog(context,text: 'Registering');
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: ec.text.trim(),
        password: pc.text.trim()
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
