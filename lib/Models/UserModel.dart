class UserModel{
  late String id , email , name , propertyaddress, propertytype;
  late int date;
  late double purchaseprice , downpayment;
  List<dynamic> mortage = [];
  late double privatemortageinsurance,appraisedvalue, rentproration, securitydepositproration;
  late dynamic monthlyIncome;
  List<dynamic> additionaladjustment = [];
  late dynamic monthlyexpense;


  UserModel();


  UserModel.fromMap(Map<String , dynamic> data){
    id = data['id'];
    email = data['email'];
    name = data['name'];
    propertyaddress = data['propertyaddress'];
    propertytype = data['propertytype'];
    date = data['date'];
    purchaseprice = data['purchaseprice'];
    downpayment = data['downpayment'];
    mortage = data['mortage'] ?? [];
    privatemortageinsurance = data['privatemortageinsurance'];
    appraisedvalue = data['appraisedvalue'];
    rentproration = data['rentproration'];
    securitydepositproration = data['securitydepositproration'];

    monthlyIncome = data['monthlyIncome'];
    additionaladjustment = data['additionaladjustment'] ?? [];
    monthlyexpense = data['monthlyexpense'];
  }

  Map<String , dynamic> tomap(){
    return {
    'id' :id,
    'email' :email,
    'name' :name,
    'propertyaddress' :propertyaddress,
    'propertytype' :propertytype,
    'date' :date,
    'purchaseprice' :purchaseprice,
    'downpayment' :downpayment,
    'mortage' :mortage,
    'privatemortageinsurance' :privatemortageinsurance,
    'appraisedvalue' :appraisedvalue,
    'rentproration' :rentproration,
    'securitydepositproration' :securitydepositproration,
    'monthlyIncome' :monthlyIncome,
    'additionaladjustment' :additionaladjustment,
    'monthlyexpense' :monthlyexpense,
    };
  }
}
class Mortgage{
  late double monthlypaymnet, loanbalanceamount, intrestrate , paymentsperyear;
  late int number;

  Mortgage(this.monthlypaymnet, this.loanbalanceamount, this.intrestrate,
      this.paymentsperyear, this.number);

  Mortgage.fromMap(Map<String, dynamic> data){
    number = data['number'] ;
    monthlypaymnet = data['monthlypaymnet'] ;
    loanbalanceamount = data['loanbalanceamount'] ;
    intrestrate = data['intrestrate'] ;
    paymentsperyear = data['paymentsperyear'];
  }

  Map<String , dynamic> toMap(){
    return{
    'number' : number,
    'monthlypaymnet' : monthlypaymnet,
    'loanbalanceamount' : loanbalanceamount,
    'intrestrate' : intrestrate,
    'paymentsperyear' : paymentsperyear,
    };
  }
}
class MonthlyIncome{
  late double totalrentalincome,additionalincome;

  MonthlyIncome(this.totalrentalincome, this.additionalincome);

  MonthlyIncome.fromMap(Map<String , dynamic> data){
    totalrentalincome = data['totalrentalincome'];
    additionalincome = data['additionalincome'];
  }

  Map<String , dynamic> tomap(){
    return {
      'totalrentalincome': totalrentalincome,
      'additionalincome': additionalincome,
    };
  }

}
class AdditionalAdjustment{
  late String description;
  late double amount;

  AdditionalAdjustment(this.description, this.amount);

  AdditionalAdjustment.fromMap(Map<String , dynamic> data){
    description = data['description'];
    amount = data['amount'];
  }

  Map<String , dynamic> tomap(){
    return {
      'description': description,
      'amount': amount,
    };
  }
}

class MonthlyExpense{
  late double realestatetaxes , insurance , naturalgas, electric, water , trash, supplies,
  lawn, accounting, associationfees , propertymanager, payroll , floodinsurance, others;

  MonthlyExpense(
      this.realestatetaxes,
      this.insurance,
      this.naturalgas,
      this.electric,
      this.water,
      this.trash,
      this.supplies,
      this.lawn,
      this.accounting,
      this.associationfees,
      this.propertymanager,
      this.payroll,
      this.floodinsurance,
      this.others);


  MonthlyExpense.fromMap(Map<String , dynamic> data){
    realestatetaxes = data['realestatetaxes'];
    insurance = data['insurance'];
    naturalgas = data['naturalgas'];
    electric = data['electric'];
    water = data['water'];
    trash = data['trash'];
    supplies = data['supplies'];
    lawn = data['lawn'];
    accounting = data['accounting'];
    associationfees = data['associationfees'];
    propertymanager = data['propertymanager'];
    payroll = data['payroll'];
    floodinsurance = data['floodinsurance'];
    others = data['others'];

  }

  Map<String , dynamic> tomap(){
    return {
    'realestatetaxes' : realestatetaxes,
    'insurance' : insurance,
    'naturalgas' : naturalgas,
    'electric' : electric,
    'water' : water,
    'trash' : trash,
    'supplies' : supplies,
    'lawn' : lawn,
    'accounting' : accounting,
    'associationfees' : associationfees,
    'propertymanager' : propertymanager,
    'payroll' : payroll,
    'floodinsurance' : floodinsurance,
    'others' : others,
    };
  }
}