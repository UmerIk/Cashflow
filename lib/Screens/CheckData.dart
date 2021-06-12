import 'package:cashflow/Screens/Dashboard/Dashboard.dart';
import 'package:cashflow/Screens/Steps/Step1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckData extends StatelessWidget {
  checkdata(BuildContext context){
    FirebaseFirestore.instance.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
          if(value.exists){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
              return Dashboard();
            }));
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
              return Step1();
            }));
          }
    }).catchError((error){

    });
  }
  @override
  Widget build(BuildContext context) {
    checkdata(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
