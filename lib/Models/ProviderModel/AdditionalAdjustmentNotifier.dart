import 'package:flutter/cupertino.dart';

import '../UserModel.dart';

class AditionalAdjustmentNotifier with ChangeNotifier{
  List<AdditionalAdjustment> alist = [];

  addItem(AdditionalAdjustment model){
    alist.add(model);
    notifyListeners();
  }
}