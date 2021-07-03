import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

class Step5 extends StatelessWidget {

  UserModel userModel;
  bool update;
  Step5(this.userModel , {this.update = false});
  late double width , height;
  late FocusScopeNode node;

  var retc = TextEditingController(),inc = TextEditingController(),
      ngc = TextEditingController() , elec = TextEditingController(), watc = TextEditingController(),
      trac = TextEditingController() , suppc = TextEditingController() , lac = TextEditingController(),
      acc = TextEditingController() , assc = TextEditingController() , pmc = TextEditingController(),
      payc = TextEditingController(), fic = TextEditingController(), otherc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(update) {
      MonthlyExpense model = MonthlyExpense.fromMap(userModel.monthlyexpense);
      setvalue(retc, model.realestatetaxes);
      setvalue(inc, model.insurance);
      setvalue(ngc, model.naturalgas);
      setvalue(elec, model.electric);
      setvalue(watc, model.water);
      setvalue(trac, model.trash);
      setvalue(suppc, model.supplies);
      setvalue(lac, model.lawn);
      setvalue(acc, model.accounting);
      setvalue(assc, model.associationfees);
      setvalue(pmc, model.propertymanager);
      setvalue(payc, model.payroll);
      setvalue(fic, model.floodinsurance);
      setvalue(otherc, model.others);

      // retc.text = '${model.realestatetaxes}';
      // inc.text = '${model.insurance}';
      // ngc.text = '${model.naturalgas}';
      // elec.text = '${model.electric}';
      // watc.text = '${model.water}';
      // trac.text = '${model.trash}';
      // suppc.text = '${model.supplies}';
      // lac.text = '${model.lawn}';
      // acc.text = '${model.accounting}';
      // assc.text = '${model.associationfees}';
      // pmc.text = '${model.propertymanager}';
      // payc.text = '${model.payroll}';
      // fic.text = '${model.floodinsurance}';
      // otherc.text = '${model.others}';
    }
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Expense'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Real Estate Tax', style: TextStyle(
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
                          controller: retc,
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


                Text('Insurance', style: TextStyle(
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
                          controller: inc,
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


                Text('Natural Gas', style: TextStyle(
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
                          controller: ngc,
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

                Text('Electric', style: TextStyle(
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
                          controller: elec,
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


                Text('Water', style: TextStyle(
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
                          controller: watc,
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


                Text('Trash', style: TextStyle(
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
                          controller: trac,
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

                Text('Supplies', style: TextStyle(
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
                          controller: suppc,
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


                Text('Lawn/Landscaping', style: TextStyle(
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
                          controller: lac,
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


                Text('Accounting/Legal', style: TextStyle(
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
                          controller: acc,
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


                Text('Association', style: TextStyle(
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
                          controller: assc,
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


                Text('Property Manager', style: TextStyle(
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
                          controller: pmc,
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

                Text('Payroll', style: TextStyle(
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
                          controller: payc,
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

                Text('Flood Insurance', style: TextStyle(
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
                          controller: fic,
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


                Text('Others', style: TextStyle(
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
                          controller: otherc,
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


                SizedBox(height: height * 0.02,),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                        shape: StadiumBorder(),
                      ),
                      onPressed: (){

                        MonthlyExpense model = MonthlyExpense(
                          retc.text.isEmpty ? 0 : double.parse(retc.text),
                          inc.text.isEmpty ? 0 : double.parse(inc.text),
                          ngc.text.isEmpty ? 0 : double.parse(ngc.text),
                          elec.text.isEmpty ? 0 : double.parse(elec.text),
                          watc.text.isEmpty ? 0 : double.parse(watc.text),
                          trac.text.isEmpty ? 0 : double.parse(trac.text),
                          suppc.text.isEmpty ? 0 : double.parse(suppc.text),
                          lac.text.isEmpty ? 0 : double.parse(lac.text),
                          acc.text.isEmpty ? 0 : double.parse(acc.text),
                          assc.text.isEmpty ? 0 : double.parse(assc.text),
                          pmc.text.isEmpty ? 0 : double.parse(pmc.text),
                          payc.text.isEmpty ? 0 : double.parse(payc.text),
                          fic.text.isEmpty ? 0 : double.parse(fic.text),
                          otherc.text.isEmpty ? 0 : double.parse(otherc.text),
                        );

                        if(update) {
                          Map<String, dynamic> map = Map();
                          map['monthlyexpense'] = model.tomap();
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
                          userModel.monthlyexpense = model.tomap();
                          addData(context);
                        }
                      },
                      child: Text(update ? 'Update' : 'Next')),
                ),
                SizedBox(height: height * 0.02,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addData(BuildContext context){
    Functions().showLoaderDialog(context);
    FirebaseFirestore.instance.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.tomap()).then((value){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
        return Home();
      }), (route) => false);
    }).catchError((error){
      // PlatformException platformException = error;
      Fluttertoast.showToast(msg: error.toString());
    });
  }


  setvalue(TextEditingController controller , double val){
    if(val > val.toInt()){
      controller.text = '$val';
    }else{
      controller.text = '${val.toInt()}';
    }
  }
}
