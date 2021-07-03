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
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Real Estate Tax', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Review the property specification sheet and find the RE Taxes.  Divide this number by 12, and put the result here.\n\nYour almost done!!'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Insurance', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'For excellent low cost property insurance call Richard at\n630-213-6800.  He will send someone out to the property, research the property, and provide you with a cost effective quote.  You must call now to start this process!  Yes, this can hold up closing!!'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),

                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Natural Gas', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),



                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'If you have a single family home or a property that the utilities are separated you can have the Resident pay this bill.  Call the company quarterly to find out if the bill is up to date.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Electric', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'If you have a single family home or a property that the utilities are separated you can have the Resident pay this bill.  Call the company quarterly to find out if the bill is up to date.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Water', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),


                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'If you are going to pay for the water bill call the water company and find out what the average monthly water bill will be.  Remember if the water bill goes unpaid the water company may put a lien on your property.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trash', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Ask your realtor do you have to pay for the trash, or is it included in the water bill.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Supplies', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'This can be for any type of supply… office supplies, or property cleaning supplies.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lawn/Landscaping', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Insert your monthly lawn cost here.  You may cut it yourself or have a company cut it for you.  Remember  negotiate these price down BUT make sure that the service is going to give you quality'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Accounting/Legal', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),


                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'If you have an accountant or attorney that you pay monthly their fee(s) goes here.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Homeowner Association fees', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Check with your realtor to see if there are any association fees for the property'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Property Manager', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Now you have a choice to make, are you going to manage the property or are you going to have a property manger?  If you have a manager put their fee here.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payroll', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Do you have any workers that work for you.  If so how much do you pay them monthly?'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Flood Insurance', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Check with your realtor and  City Planning to  ensure if the property is in a flood zone, or not.  This is critical don\'t forget.  This insurance can be an expensive mistake.'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Others', style: TextStyle(
                      color: CColors.textblack,
                      fontFamily: 'fh',
                      fontSize: 15,
                    ),),

                    GestureDetector(
                        onTap: (){
                          Functions().showinfo(
                              context,
                              'Are there any other expenses that you want to include? If so, put it here.  Guess What?!\nYOU\'RE DONE!!!!'
                          );
                        },
                        child: Icon(Icons.info, color: Colors.blue,)
                    ),
                  ],
                ),
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
