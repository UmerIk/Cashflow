import 'package:cashflow/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnualReturn extends StatelessWidget {


  AnnualReturn(this.userModel);

  UserModel userModel;
  late double width , height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                financing(),
                income(),
                expense(),
                annualcashflow(),
              ],
            ),
          ),
        ),
      ),

    );

  }
  Widget financing(){
    return Card(
      elevation: 3,
      shadowColor: Colors.black54,
      margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),

        width: double.infinity,
        child: Column(
          children: [
            Text('Financing',style: TextStyle(
                fontSize: 18,
                fontFamily: 'fh'
            ),),
            SizedBox(height: height * 0.01,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx , i){
              Mortgage model = Mortgage.fromMap(userModel.mortage[i]);
              return Card(
                elevation: 3,
                shadowColor: Colors.black54,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: width * 0.03),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Loan Priority',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fm'
                        ),),

                        Text('Loan ${model.number}',style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futura'
                        ),),
                      ],),
                      SizedBox(height: height * 0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Balance',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fm'
                        ),),

                        Text('\$${model.loanbalanceamount}',style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futura'
                        ),),
                      ],),
                      SizedBox(height: height * 0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Payments/year',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fm'
                        ),),

                        Text('\$${model.paymentsperyear}',style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futura'
                        ),),
                      ],),
                      SizedBox(height: height * 0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Payments per month',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fm'
                        ),),

                        Text('\$${model.monthlypaymnet}',style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futura'
                        ),),
                      ],),
                      SizedBox(height: height * 0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Intrest Rate',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fm'
                        ),),

                        Text('${model.intrestrate} %',style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futura'
                        ),),
                      ],),
                      SizedBox(height: height * 0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Debt per year',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fm'
                        ),),

                        Text('\$${model.monthlypaymnet * 12}',style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'futura'
                        ),),
                      ],),
                      SizedBox(height: height * 0.01,),
                    ],
                  ),
                ),
              );
            },itemCount: userModel.mortage.length,
            shrinkWrap: true,)
          ],
        ),
      ),
    );
  }
  Widget income(){
    MonthlyIncome model = MonthlyIncome.fromMap(userModel.monthlyIncome);
    return Card(
      elevation: 3,
      shadowColor: Colors.black54,
      margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),

        width: double.infinity,
        child: Column(
          children: [
            Text('Income',style: TextStyle(
                fontSize: 18,
                fontFamily: 'fh'
            ),),

            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rental Income',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.totalrentalincome}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Additional Income',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.additionalincome}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Operating Income',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fh'
                ),),

                Text('\$${model.additionalincome + model.totalrentalincome}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'fm'
                ),),
              ],),
          ],
        ),
      ),
    );
  }
  Widget expense(){
    MonthlyExpense model = MonthlyExpense.fromMap(userModel.monthlyexpense);
    return Card(
      elevation: 3,
      shadowColor: Colors.black54,
      margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),

        width: double.infinity,
        child: Column(
          children: [
            Text('Expense',style: TextStyle(
                fontSize: 18,
                fontFamily: 'fh'
            ),),

            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Real Estate Taxes',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.realestatetaxes}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Insurance',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.insurance}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Natural Gas',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.naturalgas}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Electric',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.electric}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Water',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.water}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trash',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.trash}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Supplies',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.supplies}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lawn / Landscaping',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.lawn}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Accounting / Legal',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.accounting}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Association Fees',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.associationfees}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Property Manager',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.propertymanager}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payroll',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.payroll}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Flood Insurance',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.floodinsurance}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Others',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${model.others}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Operating Expense',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fh'
                ),),

                Text('\$${operatingexpense()}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'fm'
                ),),
              ],),
            SizedBox(height: height * 0.01,),
          ],
        ),
      ),
    );
  }

  double operatingexpense(){
    double expense = 0;
    MonthlyExpense monthlyExpense = MonthlyExpense.fromMap(userModel.monthlyexpense);
    expense = monthlyExpense.accounting + monthlyExpense.associationfees + monthlyExpense.electric
        + monthlyExpense.floodinsurance + monthlyExpense.insurance + monthlyExpense.lawn + monthlyExpense.naturalgas+
        monthlyExpense.others + monthlyExpense.payroll + monthlyExpense.propertymanager + monthlyExpense.realestatetaxes+
        monthlyExpense.supplies + monthlyExpense.trash + monthlyExpense.water;

    return expense;
  }
  double totaldebt(){
    double totaldebt = 0;
    userModel.mortage.forEach((element) {
      Mortgage mortgage = Mortgage.fromMap(element);
      totaldebt = totaldebt + mortgage.monthlypaymnet;
    });
    return totaldebt;
  }

  Widget annualcashflow(){
    return Card(
      elevation: 3,
      shadowColor: Colors.black54,
      margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),

        width: double.infinity,
        child: Column(
          children: [
            Text('Annual Cash Flow',style: TextStyle(
                fontSize: 18,
                fontFamily: 'fh'
            ),),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Annual Operating Income',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${operatingincome() * 12}',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                  ),
                ),
              ],),
            SizedBox(height: height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Annual Operating Expense',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${operatingexpense() * 12}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),
            SizedBox(height: height * 0.01,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Annual Debt Service',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fm'
                ),),

                Text('\$${totaldebt() * 12}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'futura'
                ),),
              ],),

            SizedBox(height: height * 0.01,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cash Flow before Taxes',style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'fh'
                ),),

                Text('\$${cashflowbeforetaxes()}',style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'fm'
                ),),
              ],),
          ],
        ),
      ),
    );
  }
  double operatingincome(){
    return (MonthlyIncome.fromMap(userModel.monthlyIncome).additionalincome) + (MonthlyIncome.fromMap(userModel.monthlyIncome).totalrentalincome);
  }
  double cashflowbeforetaxes(){
    return (operatingincome() * 12) - (operatingexpense() *12) - (totaldebt() * 12);
  }
}
