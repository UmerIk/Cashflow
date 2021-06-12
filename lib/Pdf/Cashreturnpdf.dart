import 'dart:io';
import 'dart:typed_data';

import 'package:cashflow/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class CashReturnPDF{
  final pdf = pw.Document();


  late double total;
  UserModel userModel;
  CashReturnPDF(this.userModel , this.total){
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(userModel.propertyaddress,style: pw.TextStyle(
                color: PdfColor.fromHex("#000000"),
                fontSize: 30,
                fontWeight: pw.FontWeight.bold
              ),),

              pw.SizedBox(height: 10),
              pw.Text(userModel.propertytype,style: pw.TextStyle(
                color: PdfColor.fromHex("#000000"),
                fontSize: 20,
              ),),

              pw.SizedBox(height: 10),

              pw.Row(
                children: [
                  pw.Row(
                      children: [
                        pw.Text('Purchase Price',style: pw.TextStyle(
                          fontSize: 15,
                        )),
                        pw.SizedBox(width: 10),
                        pw.Container(
                            padding: pw.EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                            ),
                            child: pw.Text(
                                '\$${userModel.purchaseprice}',style: pw.TextStyle(
                              fontSize: 18,
                            )
                            )
                        )
                      ]
                  ),

                  pw.SizedBox(width: 20),

                  pw.Row(
                      children: [
                        pw.Text('Original Down Payment',style: pw.TextStyle(
                          fontSize: 15,
                        )),
                        pw.SizedBox(width: 10),
                        pw.Container(
                            padding: pw.EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(width: 2, color: PdfColor.fromHex("#000000")),
                            ),
                            child: pw.Text(
                                '\$${userModel.downpayment}',style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold
                            )
                            )
                        )
                      ]
                  )
                ]
              ),

              pw.Row(
                  children: [
                    pw.Text('Appraised Value',style: pw.TextStyle(
                      fontSize: 15,
                    )),
                    pw.SizedBox(width: 10),
                    pw.Container(
                        padding: pw.EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                        ),
                        child: pw.Text(
                            '\$${userModel.appraisedvalue}',style: pw.TextStyle(
                          fontSize: 18,
                        )
                        )
                    )
                  ]
              ),

              pw.Divider(thickness: 2,color: PdfColor.fromHex("#000000")),

              pw.Text('Credits',style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline
              )),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                    children:[

                      pw.ListView.builder(itemBuilder: (ctx , i){
                        AdditionalAdjustment model = AdditionalAdjustment.fromMap(userModel.additionaladjustment[i]);
                        return pw.Container(
                          child: pw.Row(
                            children: [

                              pw.Container(
                                width: 100,
                                child: pw.Text(model.description,style: pw.TextStyle(
                                  fontSize: 15,
                                )),
                              ),

                              pw.SizedBox(width: 10),
                              pw.Container(
                                  width: 100,
                                  padding: pw.EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                                  ),
                                  child: pw.Text(
                                      '\$${model.amount}',style: pw.TextStyle(
                                    fontSize: 18,
                                  )
                                  )
                              ),

                            ],
                          ),
                        );
                      }, itemCount: userModel.additionaladjustment.length),


                      pw.SizedBox(height: 10),
                      pw.Container(
                        child: pw.Row(
                          children: [

                            pw.Container(
                              width: 100,
                              child: pw.Text('Total Credits',style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                              )),
                            ),

                            pw.SizedBox(width: 5),
                            pw.Container(
                                width: 100,
                                padding: pw.EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                                ),
                                child: pw.Text(
                                    '\$${total}',style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold
                                )
                                )
                            ),

                          ],
                        ),
                      ),

                    ]
                  ),

                  pw.SizedBox(width: 5),

                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Container(
                      width: 3,
                      height: 200,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),

                  pw.SizedBox(width: 5),


                  pw.Container(
                    child: pw.Row(
                      children: [

                        pw.Container(
                          width: 150,
                          child: pw.Text('New Down Payment after Credits',style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          )),
                        ),

                        pw.SizedBox(width: 5),
                        pw.Container(
                            width: 100,
                            padding: pw.EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(width: 3, color: PdfColor.fromHex("#000000")),
                            ),
                            child: pw.Text(
                                '\$${total + userModel.downpayment}',style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold
                            )
                            )
                        ),

                      ],
                    ),
                  ),
                ]
              ),

              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2,color: PdfColor.fromHex("#000000")),
              pw.SizedBox(height: 10),


              pw.Text('Income',style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline
              )),

              pw.SizedBox(height: 10),

              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(),
                  ),

                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text('Monthly',style: pw.TextStyle(
                        color: PdfColor.fromHex("#000000"),
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold
                      ))
                    ),
                  ),

                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Annually',style: pw.TextStyle(
                            color: PdfColor.fromHex("#000000"),
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold
                        ))
                    ),
                  ),
                ]
              ),

              pw.SizedBox(height: 10),

              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          child: pw.Text('Rental Income',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${rentalincome()}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${rentalincome() * 12}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),
                  ]
              ),


              pw.SizedBox(height: 10),

              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          child: pw.Text('Additional Income',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${additionalincome()}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${additionalincome() * 12}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),
                  ]
              ),


              pw.SizedBox(height: 10),

              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          child: pw.Text('Operating Income',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${operatingincome()}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${operatingincome() * 12}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),
                  ]
              ),

              pw.SizedBox(height: 20),
              pw.Divider(thickness: 2,color: PdfColor.fromHex("#000000")),
            ]
          );// Center
        }));

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              pw.SizedBox(height: 10),
              pw.Text('Debt Service',style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline
              )),

              pw.SizedBox(height: 10),

              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Monthly',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Annually',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),
                  ]
              ),

              pw.SizedBox(height: 10),

              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          child: pw.Text('Total Debt Service',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${totaldebt()}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${totaldebt() * 12}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                  ]
              ),


              pw.SizedBox(height: 10),


              pw.Text('Expenses',style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline
              )),


              pw.SizedBox(height: 10),

              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          child: pw.Text('Operating Expense',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${operatingexpense()}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text('\$${operatingexpense() * 12}',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),
                  ]
              ),

              pw.SizedBox(height: 20),
              pw.Divider(thickness: 2,color: PdfColor.fromHex("#000000")),


              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          child: pw.Text('Return on Cash = ',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 25,

                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(
                            color: cashreturn() < 10 ? PdfColor.fromHex("#ff0000") : PdfColor.fromHex("#00ff00"),
                            border: pw.Border.all(width: 1, color: PdfColor.fromHex("#000000")),
                          ),
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('${cashreturn().toStringAsFixed(2)} %',style: pw.TextStyle(
                              color: PdfColor.fromHex("#000000"),
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold
                          ))
                      ),
                    ),
                  ]
              ),


            ]
          );
        }));
  }
  save() async {
    if (await Permission.storage.request().isGranted ) {
      final path = '/storage/emulated/0/AWI_Cash_FLow';
      final output = Directory(path);
      if(!await output.exists()){
        output.createSync();
      }
      final file = File("$path/PDF_AWI_Cash_Flow_${DateTime.now()}.pdf");
      await file.writeAsBytes(await pdf.save());

      Fluttertoast.showToast(msg: "saved to $path");

    }else{
      Map<Permission, PermissionStatus> statuses = await [
        // Permission.manageExternalStorage,
        Permission.storage,
      ].request();
    }
  }

  double rentalincome(){
    return MonthlyIncome.fromMap(userModel.monthlyIncome).totalrentalincome;
  }
  double additionalincome(){
    return MonthlyIncome.fromMap(userModel.monthlyIncome).additionalincome;
  }
  double operatingincome(){
    return (MonthlyIncome.fromMap(userModel.monthlyIncome).additionalincome) + (MonthlyIncome.fromMap(userModel.monthlyIncome).totalrentalincome);
  }
  double vall(){
    return operatingincome() * 12 - operatingexpense() - totaldebt();
  }
  double cashreturn(){
    return vall() / (total + userModel.downpayment);
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
}