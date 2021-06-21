import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Models/ProviderModel/AdditionalAdjustmentNotifier.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'Step4.dart';

class Step3 extends StatelessWidget {

  UserModel userModel;
  bool update;
  Step3(this.userModel , {this.update = false});

  late double width , height;
  late FocusScopeNode node;

  var tric = TextEditingController();
  var aic = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    node = FocusScope.of(context);

    if(update){
      tric.text = '${MonthlyIncome.fromMap(userModel.monthlyIncome).totalrentalincome}';
      aic.text = '${MonthlyIncome.fromMap(userModel.monthlyIncome).additionalincome}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Income'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Card(
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 00.03),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Text('Total Rental Income', style: TextStyle(
                        color: CColors.textblack,
                        fontFamily: 'fh',
                        fontSize: 15,
                      ),),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.015),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: CColors.textgray),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.attach_money,color: CColors.primary,),
                            Expanded(
                              child: TextField(
                                controller: tric,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    try {
                                      final text = newValue.text;
                                      if (text.isNotEmpty) double.parse(text);
                                      return newValue;
                                    } catch (e) {}
                                    return oldValue;
                                  }),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: ()=> node.nextFocus(),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Text('Additional Income', style: TextStyle(
                        color: CColors.textblack,
                        fontFamily: 'fh',
                        fontSize: 15,
                      ),),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.015),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: CColors.textgray),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.attach_money,color: CColors.primary,),
                            Expanded(
                              child: TextField(
                                controller: aic,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    try {
                                      final text = newValue.text;
                                      if (text.isNotEmpty) double.parse(text);
                                      return newValue;
                                    } catch (e) {}
                                    return oldValue;
                                  }),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: ()=> node.nextFocus(),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                              shape: StadiumBorder(),
                            ),
                            onPressed: (){
                              MonthlyIncome monthlyincome = MonthlyIncome(
                                  tric.text.isEmpty ? 0 : double.parse(tric.text),
                                  aic.text.isEmpty ? 0 : double.parse(aic.text)
                              );


                              if(update) {
                                Map<String, dynamic> map = Map();
                                map['monthlyIncome'] = monthlyincome.tomap();
                                Functions().showLoaderDialog(context);
                                FirebaseFirestore.instance.collection('Users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid).update(map).then((value){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
                                    return Home();
                                  }), (route) => false);

                                }).catchError((error){
                                  Fluttertoast.showToast(msg: error.toString());
                                });

                              }else{
                                userModel.monthlyIncome = monthlyincome.tomap();
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                  return ChangeNotifierProvider(
                                      create: (BuildContext context) {
                                        return AditionalAdjustmentNotifier();
                                      },
                                      child: Step4(userModel));
                                }));
                              }
                            },
                            child: Text(update ? 'Update' : 'Next')),
                      ),


                    ],

                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
