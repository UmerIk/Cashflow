import 'package:cashflow/Screens/CheckData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Extras/CColors.dart';
import 'Screens/WelcomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CColors.primary
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Flow',
      theme: ThemeData(
        primarySwatch: MaterialColor(CColors.primary.value , CColors.getSwatch(CColors.primary)),
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return WelcomeScreen();
    }else{
      return CheckData();
    }
  }
}

