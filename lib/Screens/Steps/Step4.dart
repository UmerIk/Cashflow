import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Models/ProviderModel/AdditionalAdjustmentNotifier.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'Step5.dart';

class Step4 extends StatelessWidget {
  UserModel userModel;
  bool update;
  Step4(this.userModel , {this.update = false});
  late double width , height;
  late FocusScopeNode node;

  late AditionalAdjustmentNotifier notifier;

  bool ft = true;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<AditionalAdjustmentNotifier>(context);

    if(ft){

      Future.delayed(Duration(milliseconds: 100)).then((value){
        if(update){
          userModel.additionaladjustment.forEach((element) {
            AdditionalAdjustment mortgage = AdditionalAdjustment.fromMap(element);
            notifier.addItem(mortgage);
          });
        }else{
          notifier.addItem(AdditionalAdjustment('', 0));
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
          notifier.addItem(AdditionalAdjustment('', 0));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Additional Adjustment'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Consumer<AditionalAdjustmentNotifier>(
                  builder: (ctx, noti , child){
                    return ListView.builder(itemBuilder: (ctx, i){
                      var d = TextEditingController(), a = TextEditingController();
                      d.text = noti.alist[i].description;
                      a.text = noti.alist[i].amount == 0 ? '' : '${noti.alist[i].amount}';
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: height * 0.01 , horizontal: width * 0.03),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: height * 0.02 , horizontal: width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description', style: TextStyle(
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
                                child: TextField(
                                  controller: d,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: ()=> node.nextFocus(),
                                  onChanged: (val){
                                    noti.alist[i].description = val;
                                  },
                                ),
                              ),


                              Text('Amount', style: TextStyle(
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
                                        controller: a,
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
                                            noti.alist[i].amount = 0;
                                          }else{
                                            noti.alist[i].amount = double.parse(val);
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
                    },itemCount: noti.alist.length,
                      shrinkWrap: true,
                    );
                  },
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



                      List<dynamic> list = [];

                      notifier.alist.forEach((element) {
                        if(element.description.trim().isEmpty && element.amount == 0){

                        }else{
                          list.add(element.tomap());
                        }
                      });

                      if(update) {
                        Map<String, dynamic> map = Map();
                        map['additionaladjustment'] = list;
                        Functions().showLoaderDialog(context);
                        FirebaseFirestore.instance.collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid).update(map).then((value){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
                            return Home();
                          }), (route) => false);

                        }).catchError((error){
                          Fluttertoast.showToast(msg: error.toString());
                        });

                      }else {
                        userModel.additionaladjustment = list;
                        print(list.length);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Step5(userModel);
                        }));
                      }
                    },
                    child: Text(update ? 'Update' : 'Next')),
              ),
              SizedBox(height: height * 0.02,),
            ],
          ),

        ),
      ),
    );
  }
}
