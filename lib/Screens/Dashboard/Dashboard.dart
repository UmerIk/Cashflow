import 'dart:io';

import 'package:cashflow/Drawer/CDrawer.dart';
import 'package:cashflow/Extras/BaseAlert.dart';
import 'package:cashflow/Extras/Functions.dart';
import 'package:cashflow/Interface/drawerinterface.dart';
import 'package:cashflow/Models/ProviderModel/AdditionalAdjustmentNotifier.dart';
import 'package:cashflow/Models/ProviderModel/MortgageNotifier.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cashflow/Pdf/Annual.dart';
import 'package:cashflow/Pdf/Cashreturnpdf.dart';
import 'package:cashflow/Screens/Dashboard/AnnualReturn.dart';
import 'package:cashflow/Screens/Dashboard/CashReturn.dart';
import 'package:cashflow/Screens/Steps/Step2.dart';
import 'package:cashflow/Screens/Steps/Step3.dart';
import 'package:cashflow/Screens/Steps/Step4.dart';
import 'package:cashflow/Screens/Steps/Step5.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Dashboard extends StatefulWidget {

  int page;
  String title;

  Dashboard({this.page = 0, this.title = 'Return on Cash'});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> implements Drawerinterface{
  late int page;
  late String title;

  late UserModel userModel;
  @override
  void initState() {
    // TODO: implement initState
    title = widget.title;
    page = widget.page;
    getData();
    geti();
    super.initState();
  }

  var ref = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);


  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  geti() async{
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      sdk = androidInfo.version.sdkInt;
      setState(() {});
      print('sdk ${androidInfo.version.sdkInt}');

    }
  }


  int sdk = 20;
  @override
  Widget build(BuildContext context) {

    if(state == 0){
      return otherwidget(CircularProgressIndicator());
    }else if(state == 1){

      var pages = [
        CashReturn(userModel),
        AnnualReturn(userModel),
      ];
      return Scaffold(
        drawer: CDrawer(this),
        appBar: AppBar(
          elevation: 0,
          title: Text(title),

          actions: [
            sdk < 30 ?
            IconButton(
                onPressed: (){
                  double total = userModel.securitydepositproration;
                  for(int i = 0 ; i < userModel.additionaladjustment.length ; i++){
                    final element = userModel.additionaladjustment[i];
                    AdditionalAdjustment additionalAdjustment = AdditionalAdjustment.fromMap(element);
                    total = total + additionalAdjustment.amount;
                  }
                  if(page == 0){
                    CashReturnPDF(userModel , total).save();
                  }else if(page == 1){
                    AnnualPDF(userModel, total).save();
                  }
                },
                icon: Icon(Icons.save)
            ) : SizedBox(),

          ],
        ),
        body: pages[page],
      );
    }else if(state == 2){
      return otherwidget(Text('Something went wrong'));
    }else{
      return otherwidget(Text('Something went wrong'));
    }
  }


  setPage(int page , String title){
    setState(() {
      this.title = title;
      this.page = page;
    });
  }
  @override
  dclick(int c , String title) {
    Navigator.of(context).pop();
    if(c == 9){
      BaseAlertDialog alertDialog = BaseAlertDialog(
        title: 'Add new file',
        content: 'Your all previous data will be removed. if you add a new file?',
        yes: 'Yes',
        no: 'No',
        noOnPressed: (){
          Navigator.of(context).pop();
        },
        yesOnPressed: () async {
          Navigator.of(context).pop();
          Functions().showLoaderDialog(context);
          await FirebaseFirestore.instance.collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid).delete();
          Navigator.of(context).pop();
          Future.delayed(Duration(milliseconds: 10)).then((value){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
              return Home();
            }), (route) => false);
          });
        },
      );


      showDialog(context: context, builder: (BuildContext context) => alertDialog);
    }else
    if(c == 10){
      BaseAlertDialog alertDialog = BaseAlertDialog(
        title: 'Logout',
        content: 'Do you really want to logout?',
        yes: 'Yes',
        no: 'No',
        noOnPressed: (){
          Navigator.of(context).pop();
        },
        yesOnPressed: () async {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
            return Home();
          }), (route) => false);
        },
      );


      showDialog(context: context, builder: (BuildContext context) => alertDialog);
    }else if(c == 2){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
        return ChangeNotifierProvider(create: (BuildContext context) {
          return MortgageNotifier();
        },
            child: Step2(userModel , update: true,));
      }));
    }

    else if(c == 3){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
        return Step3(userModel , update: true,);
      }));
    }else if(c == 4){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
        return ChangeNotifierProvider(
            create: (BuildContext context) {
              return AditionalAdjustmentNotifier();
            },
            child: Step4(userModel , update: true,));
      }));
    }
    else if(c == 5){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
        return Step5(userModel , update: true,);
      }));
    }
    else{
      setPage(c , title);
    }
  }

  Widget otherwidget(Widget w){
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: w,
          ),
        ),
      ),
    );
  }

  int state = 0;
  getData(){
    state = 0;
    ref.snapshots().listen((event) {
      if(event.exists){
        state = 1;
        userModel = UserModel.fromMap(event.data()!);
      }else{
        state = 2;
      }

      setState(() {

      });
    }).onError((error){
      setState(() {
        state = 3;
      });
      print(error);
    });
  }
}
