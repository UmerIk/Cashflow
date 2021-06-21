import 'dart:typed_data';

import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Extras/indicator.dart';
import 'package:cashflow/Models/UserModel.dart';
import 'package:cashflow/Pdf/Cashreturnpdf.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class CashReturn extends StatefulWidget {
  CashReturn(this.userModel);

  UserModel userModel;

  @override
  _CashReturnState createState() => _CashReturnState();
}
class _CashReturnState extends State<CashReturn> {
  late double width , height;


  double operatingexpense(){
    double expense = 0;
    MonthlyExpense monthlyExpense = MonthlyExpense.fromMap(widget.userModel.monthlyexpense);
    expense = monthlyExpense.accounting + monthlyExpense.associationfees + monthlyExpense.electric
    + monthlyExpense.floodinsurance + monthlyExpense.insurance + monthlyExpense.lawn + monthlyExpense.naturalgas+
    monthlyExpense.others + monthlyExpense.payroll + monthlyExpense.propertymanager + monthlyExpense.realestatetaxes+
    monthlyExpense.supplies + monthlyExpense.trash + monthlyExpense.water;

    return expense;
  }
  double totaldebt(){
    double totaldebt = 0;
    widget.userModel.mortage.forEach((element) {
      Mortgage mortgage = Mortgage.fromMap(element);
      totaldebt = totaldebt + mortgage.monthlypaymnet;
    });
    return totaldebt;
  }

  late Uint8List _imageFile;

  //Create an instance of ScreenshotController
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01 , horizontal: width * 0.03),
                        width: double.infinity,
                        color: CColors.primary,
                          child: Row(
                            children: [
                              Text(
                                  widget.userModel.propertyaddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'fm',
                                  fontSize: 18
                                ),
                              ),

                              // GestureDetector(
                              //   onTap: (){
                              //     CashReturnPDF(widget.userModel , total).save();
                              //   },
                              //   child: Text('Save',style: TextStyle(
                              //     color: Colors.white,
                              //   ),),
                              // )
                            ],
                          ),
                      ),
                      piechart(),
                      SizedBox(height: height * 0.01,),
                      info('Purchase Price', '\$ ${widget.userModel.purchaseprice}'),
                      info('Original Down Payment', '\$ ${widget.userModel.downpayment}'),
                      info('Appraised Value', '\$ ${widget.userModel.appraisedvalue}'),
                      info('Security Deposits', '\$ ${widget.userModel.securitydepositproration}'),

                      info('Total Credits', '\$ ${total}'),
                      info('New Down Payments after Credit', '\$ ${total + widget.userModel.downpayment}'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text('Income',style: TextStyle(
                            color: CColors.textblack,
                            fontSize: 18,
                            fontFamily: 'fh'
                          ),)
                      ),

                      Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Monthly', style: TextStyle(
                                    color: CColors.textblack,
                                    fontFamily: 'fm',
                                    fontSize: 15
                                  ),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Annually', style: TextStyle(
                                      color: CColors.textblack,
                                      fontFamily: 'fm',
                                      fontSize: 15
                                  ),),
                                ),
                              ),
                            ],
                          )
                      ),
                      info2('Rental income', '\$${rentalincome()}', '\$${rentalincome() * 12}'),
                      info2('Additional income', '\$${additionalincome()}', '\$${additionalincome() * 12}'),
                      info2('Operating income', '\$${operatingincome()}', '\$${operatingincome() * 12}'),


                      Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text('Debt Service',style: TextStyle(
                              color: CColors.textblack,
                              fontSize: 18,
                              fontFamily: 'fh'
                          ),)
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Monthly', style: TextStyle(
                                      color: CColors.textblack,
                                      fontFamily: 'fm',
                                      fontSize: 15
                                  ),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Annually', style: TextStyle(
                                      color: CColors.textblack,
                                      fontFamily: 'fm',
                                      fontSize: 15
                                  ),),
                                ),
                              ),
                            ],
                          )
                      ),

                      info2('Total Debt', '\$${totaldebt()}', '\$${totaldebt() * 12}'),
                      info2('Operating Expense', '\$${operatingexpense()}', '\$${operatingexpense() * 12}'),

                    ],
                  ),
                ),
              ),


              Card(
                margin: EdgeInsets.all(0),
                elevation: 30,
                color: cashreturn()<10 ? Colors.red : Colors.green,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.15 , vertical: height * 0.02),
                  child: Column(
                    children: [

                      Text('${cashreturn().toStringAsFixed(2)}%',style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'fh'
                      ),),
                      Text('Cash Return',style: TextStyle(
                        color: CColors.textblack,
                        fontSize: 15,
                        fontFamily: 'fm'
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int touchedIndex = -1;
  piechart(){
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40) , bottomRight: Radius.circular(40)),
      ),
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: Column(

        children: [
          SizedBox(height: height * 0.03,),
          Text('Credits',style: TextStyle(
            color: CColors.primary,
            fontFamily: 'fh',
            fontSize: 22
          ),),
          Row(
            children: <Widget>[

              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                                pieTouchResponse.touchInput is! PointerUpEvent;
                            if (desiredTouch && pieTouchResponse.touchedSection != null) {
                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            } else {
                              touchedIndex = -1;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: indicators,
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }

  double total = 0;
  List<Widget> indicators = [];
  List<PieChartSectionData> showingSections() {

    List<PieChartSectionData> list = [];
    List<AdditionalAdjustment> alist = [];


    // total = 0;
    total = widget.userModel.securitydepositproration;
    indicators.clear();
    for(int i = 0 ; i < this.widget.userModel.additionaladjustment.length ; i++){
      final element = this.widget.userModel.additionaladjustment[i];

      AdditionalAdjustment additionalAdjustment = AdditionalAdjustment.fromMap(element);
      alist.add(additionalAdjustment);
      total = total + additionalAdjustment.amount;

      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 15;
      final double radius = isTouched ? 80 : 70;

      indicators.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          child: Indicator(
            color: colors[i % colors.length],
            text: additionalAdjustment.description,
            isSquare: true,
          ),
        ),
      );
      list.add(
          PieChartSectionData(
            color: colors[i % colors.length],
            value: (additionalAdjustment.amount),
            title: '\$${additionalAdjustment.amount}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          )
      );
    }
    return list;

  }

  List<Color> colors = [
    Color(0xffF44336),
    Color(0xffE91E63),
    Color(0xffFFC107),
    Color(0xff673AB7),
    Color(0xff8BC34A),
    Color(0xffFFC107),
    Color(0xff9C27B0),
    Color(0xffFF5722),
    Color(0xff03A9F4),
    Color(0xff4CAF50),
  ];

  double rentalincome(){
    return MonthlyIncome.fromMap(widget.userModel.monthlyIncome).totalrentalincome;
  }
  double additionalincome(){
    return MonthlyIncome.fromMap(widget.userModel.monthlyIncome).additionalincome;
  }
  double operatingincome(){
    return (MonthlyIncome.fromMap(widget.userModel.monthlyIncome).additionalincome) + (MonthlyIncome.fromMap(widget.userModel.monthlyIncome).totalrentalincome);
  }
  double vall(){
    return (operatingincome() * 12) - (operatingexpense() * 12) - (totaldebt() * 12);
  }
  double cashreturn(){
    return (vall() / (total + widget.userModel.downpayment)) * 100;
  }


  Widget info(String title , String desc){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: CColors.lightgray, width: 1)
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height* 0.01),
      margin: EdgeInsets.symmetric(vertical: height* 0.0025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: TextStyle(
            color: CColors.greentext,
            fontSize: 18,
            fontFamily: 'fm',
          ),),

          Text(desc , style: TextStyle(
            color: CColors.textgray,
            fontSize: 15,
            fontFamily: 'futura',
          ),)
        ],
      ),
    );
  }
  Widget info2(String title , String desc , desc2){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: CColors.lightgray, width: 1)
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height* 0.01),
      margin: EdgeInsets.symmetric(vertical: height* 0.0025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(title , style: TextStyle(
              color: CColors.greentext,
              fontSize: 18,
              fontFamily: 'fm',
            ),),
          ),

          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(desc , style: TextStyle(
                color: CColors.textgray,
                fontSize: 15,
                fontFamily: 'futura',
              ),),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(desc2 , style: TextStyle(
                color: CColors.textgray,
                fontSize: 15,
                fontFamily: 'futura',
              ),),
            ),
          )
        ],
      ),
    );
  }
}