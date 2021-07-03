import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Models/ProviderModel/MortgageNotifier.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cashflow/Screens/Steps/Step3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Step2 extends StatelessWidget {

  Step2(this.userModel , {this.update = false});
  UserModel userModel;
  bool update;
  late double width , height;
  late FocusScopeNode node;

  late MortgageNotifier mortgageNotifier;


  var pmic = TextEditingController() , avc = TextEditingController() ,
      rpc = TextEditingController() , sdpc = TextEditingController();
  bool ft = true;
  @override
  Widget build(BuildContext context) {

    mortgageNotifier = Provider.of<MortgageNotifier>(context);

    if(ft){

      Future.delayed(Duration(milliseconds: 100)).then((value){
        if(update){
          if(userModel.privatemortageinsurance > userModel.privatemortageinsurance.toInt()){
            pmic.text = '${userModel.privatemortageinsurance}';
          }else{
            pmic.text = '${userModel.privatemortageinsurance.toInt()}';
          }

          if(userModel.appraisedvalue > userModel.appraisedvalue.toInt()){
            avc.text = '${userModel.appraisedvalue}';
          }else{
            avc.text = '${userModel.appraisedvalue.toInt()}';
          }

          if(userModel.rentproration > userModel.rentproration.toInt()){
            rpc.text = '${userModel.rentproration}';
          }else{
            rpc.text = '${userModel.rentproration.toInt()}';
          }

          if(userModel.securitydepositproration > userModel.securitydepositproration.toInt()){
            sdpc.text = '${userModel.securitydepositproration}';
          }else{
            sdpc.text = '${userModel.securitydepositproration.toInt()}';
          }

          userModel.mortage.forEach((element) {
            Mortgage mortgage = Mortgage.fromMap(element);
            mortgageNotifier.addItem(mortgage);
          });
        }else{
          mortgageNotifier.addItem(Mortgage(0, 0, 0, 0, mortgageNotifier.mlist.length +1));
        }

      });
      ft = false;
    }

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    node = FocusScope.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          mortgageNotifier.addItem(Mortgage(0, 0, 0, 0, mortgageNotifier.mlist.length +1));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Mortgage'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.015),
          child: ListView(
            children: [
              Consumer<MortgageNotifier>(
                builder: (ctx, mortgageNotifier , child){
                  return ListView.builder(itemBuilder: (ctx, i){
                    String num = i == 0 ? '1st' : i==1 ? '2nd' : i==2 ? '3rd' :'${i+1}th';

                    var mpc = TextEditingController();
                    var lbac = TextEditingController();
                    var irc = TextEditingController();
                    var ppyc = TextEditingController();

                    if(mortgageNotifier.mlist[i].monthlypaymnet > mortgageNotifier.mlist[i].monthlypaymnet.toInt()){
                      mpc.text = mortgageNotifier.mlist[i].monthlypaymnet == 0 ?'' : '${mortgageNotifier.mlist[i].monthlypaymnet}';
                    }else{
                      mpc.text = mortgageNotifier.mlist[i].monthlypaymnet == 0 ?'' : '${mortgageNotifier.mlist[i].monthlypaymnet.toInt()}';
                    }

                    if(mortgageNotifier.mlist[i].loanbalanceamount > mortgageNotifier.mlist[i].loanbalanceamount.toInt()){
                      lbac.text = mortgageNotifier.mlist[i].loanbalanceamount == 0 ?'' :  '${mortgageNotifier.mlist[i].loanbalanceamount}';
                    }else{
                      lbac.text = mortgageNotifier.mlist[i].loanbalanceamount == 0 ?'' :  '${mortgageNotifier.mlist[i].loanbalanceamount.toInt()}';
                    }

                    if(mortgageNotifier.mlist[i].intrestrate > mortgageNotifier.mlist[i].intrestrate.toInt()){
                      irc.text = mortgageNotifier.mlist[i].intrestrate == 0 ?'' : '${mortgageNotifier.mlist[i].intrestrate}';
                    }else{
                      irc.text = mortgageNotifier.mlist[i].intrestrate == 0 ?'' : '${mortgageNotifier.mlist[i].intrestrate.toInt()}';
                    }

                    if(mortgageNotifier.mlist[i].paymentsperyear > mortgageNotifier.mlist[i].paymentsperyear.toInt()){
                      ppyc.text = mortgageNotifier.mlist[i].paymentsperyear == 0 ?'' : '${mortgageNotifier.mlist[i].paymentsperyear}';
                    }else{
                      ppyc.text = mortgageNotifier.mlist[i].paymentsperyear == 0 ?'' : '${mortgageNotifier.mlist[i].paymentsperyear.toInt()}';
                    }

                    return Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 00.015),
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Align(
                              alignment: Alignment.center,
                              child: Text('$num Mortgage', style: TextStyle(
                                color: CColors.textblack,
                                fontFamily: 'fh',
                                fontSize: 18,
                              ),),
                            ),
                            SizedBox(height: height * 0.02,),
                            Text('Monthly Payment', style: TextStyle(
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
                                      controller: mpc,
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
                                      onChanged: (val){
                                        if(val.isEmpty){
                                          mortgageNotifier.mlist[i].monthlypaymnet = 0;
                                        }else{
                                          mortgageNotifier.mlist[i].monthlypaymnet = double.parse(val);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Text('Loan Balance Amount', style: TextStyle(
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
                                      controller: lbac,
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
                                      onChanged: (val){
                                        if(val.isEmpty){
                                          mortgageNotifier.mlist[i].loanbalanceamount = 0;
                                        }else{
                                          mortgageNotifier.mlist[i].loanbalanceamount = double.parse(val);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text('Intrest Rate', style: TextStyle(
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
                                      controller: irc,
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
                                      onChanged: (val){
                                        if(val.isEmpty){
                                          mortgageNotifier.mlist[i].intrestrate = 0;
                                        }else{
                                          mortgageNotifier.mlist[i].intrestrate = double.parse(val);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text('Payments per Year', style: TextStyle(
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
                                      controller: ppyc,
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
                                      onChanged: (val){
                                        if(val.isEmpty){
                                          mortgageNotifier.mlist[i].paymentsperyear = 0;
                                        }else{
                                          mortgageNotifier.mlist[i].paymentsperyear = double.parse(val);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                        ),
                      ),
                    );
                  },itemCount: mortgageNotifier.mlist.length,
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                },
              ),

              SizedBox(height: height * 0.02,),

              Card(
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 00.015),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: height * 0.02,),
                      Text('Private Mortgage insurance', style: TextStyle(
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
                                controller: pmic,
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


                      Text('Appraised Value', style: TextStyle(
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
                                controller: avc,
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

                      Text('Rent Proration', style: TextStyle(
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
                                controller: rpc,
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

                      Text('Security Deposit Prorations', style: TextStyle(
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
                                controller: sdpc,
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

                      SizedBox(height: height * 0.03,),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                              shape: StadiumBorder(),
                            ),
                            onPressed: (){

                              List<dynamic> list = [];
                              for(int i = 0 ; i < mortgageNotifier.mlist.length ; i ++){
                                var element = mortgageNotifier.mlist[i];

                                if(element.monthlypaymnet == 0 && element.paymentsperyear == 0
                                    && element.intrestrate == 0 && element.loanbalanceamount == 0){

                                }else{
                                  element.number = list.length + 1;
                                  list.add(element.toMap());
                                }
                              }

                              if(update) {
                                Map<String, dynamic> map = Map();
                                map['mortage'] = list;
                                map['privatemortageinsurance'] = pmic.text.isEmpty ? 0 : double.parse(pmic.text);
                                
                                map['appraisedvalue'] = avc.text.isEmpty ? 0 : double.parse(avc.text);
                                map['rentproration'] = rpc.text.isEmpty ? 0 : double.parse(rpc.text);
                                map['securitydepositproration'] = sdpc.text.isEmpty ? 0 : double.parse(sdpc.text);

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
                                userModel.mortage = list;
                                userModel.privatemortageinsurance = pmic.text.isEmpty ? 0 : double.parse(pmic.text);

                                userModel.appraisedvalue = avc.text.isEmpty ? 0 : double.parse(avc.text);
                                userModel.rentproration = rpc.text.isEmpty ? 0 : double.parse(rpc.text);
                                userModel.securitydepositproration = sdpc.text.isEmpty ? 0 : double.parse(sdpc.text);

                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                  return Step3(userModel);
                                }));
                              }
                            },
                            child: Text(update ? 'Update' : 'Next')),
                      ),
                    ],

                  ),
                ),
              ),

              SizedBox(height: height * 0.02,),
            ],
          ),
        ),
      ),
    );
  }
}
