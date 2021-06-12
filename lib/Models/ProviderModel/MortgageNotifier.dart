import 'package:cashflow/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';

class MortgageNotifier with ChangeNotifier{
  List<Mortgage> mlist = [];


  addItem(Mortgage model){
    mlist.add(model);
    notifyListeners();
  }
}