import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Models/ProviderModel/MortgageNotifier.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cashflow/Screens/Steps/Step2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Step1 extends StatelessWidget {
  late double width , height;

  late FocusScopeNode node;
  var datecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  // var typepcontroller = TextEditingController();

  var purchasepricecontroller = TextEditingController();
  var downpaymentpcontroller = TextEditingController();

  late UserModel userModel;
  @override
  Widget build(BuildContext context) {
    userModel = UserModel();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    node = FocusScope.of(context);
    datecontroller.text = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('General Information'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03 , vertical: height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today Date', style: TextStyle(
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
                    controller: datecontroller,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=> node.nextFocus(),
                  ),
                ),

                Text('Your Name or Company', style: TextStyle(
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
                    controller: namecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=> node.nextFocus(),
                  ),
                ),


                Text('Property Address', style: TextStyle(
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
                    controller: addresscontroller,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=> node.nextFocus(),
                  ),
                ),

                Text('Type of Property', style: TextStyle(
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
                  child: typedropdown(),
                  // TextField(
                  //   controller: typepcontroller,
                  //   keyboardType: TextInputType.text,
                  //   decoration: InputDecoration(
                  //     border: InputBorder.none,
                  //   ),
                  //   textInputAction: TextInputAction.next,
                  //   onEditingComplete: ()=> node.nextFocus(),
                  // ),
                ),



                Text('Purchase Price', style: TextStyle(
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
                          controller: purchasepricecontroller,
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

                Text('Down Payment', style: TextStyle(
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
                          controller: downpaymentpcontroller,
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
                          textInputAction: TextInputAction.done,
                          onEditingComplete: ()=> node.unfocus(),
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
                      if(namecontroller.text.trim().isEmpty){
                        Fluttertoast.showToast(msg: 'Invalid Name');
                      }else if(addresscontroller.text.trim().isEmpty){
                        Fluttertoast.showToast(msg: 'Invalid Property address');
                      }else if(purchasepricecontroller.text.trim().isEmpty){
                        Fluttertoast.showToast(msg: 'Invalid Purchase Price');
                      }else if(downpaymentpcontroller.text.trim().isEmpty){
                        Fluttertoast.showToast(msg: 'Invalid Downpayment');
                      }else{
                        //id , email , name , propertyaddress, propertytype;
                      // late int date;
                      // late double purchaseprice , downpayment;
                        userModel.id = FirebaseAuth.instance.currentUser!.uid;
                        userModel.email = FirebaseAuth.instance.currentUser!.email!;
                        userModel.name = namecontroller.text;
                        userModel.propertyaddress = addresscontroller.text;
                        userModel.propertytype = type;
                        userModel.date = DateTime.now().millisecondsSinceEpoch;
                        userModel.purchaseprice = double.parse(purchasepricecontroller.text);
                        userModel.downpayment = double.parse(downpaymentpcontroller.text);


                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return ChangeNotifierProvider(create: (BuildContext context) {
                            return MortgageNotifier();
                          },
                          child: Step2(userModel));
                        }));
                      }
                    },
                    child: Text('Next')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  String type = 'Single family';
  Widget typedropdown() {
    return StatefulBuilder(builder: (ctx , setState){
      return DropdownButton<String>(
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, ),
        hint: Text(type , style: TextStyle(

        ),),
        underline: SizedBox(),
        items: <String>['Single family', 'Duplex' , "Triplex" , " 4 unit house"].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (value) {

          setState((){
            type = value!;
          });
        },
      );
    });

  }
}
