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

class AnnualPDF{
  final pdf = pw.Document();


  late double total;
  UserModel userModel;
  AnnualPDF(this.userModel , this.total){

    MonthlyExpense monthlyExpense = MonthlyExpense.fromMap(userModel.monthlyexpense);
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

              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2,color: PdfColor.fromHex("#000000")),

              pw.SizedBox(height: 10),

              pw.Text('Financing',style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline
              )),

              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text('Loan Priority',style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ))
                    ),
                  ),


                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Balance',style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ))
                    ),
                  ),


                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Payments / Year',style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ))
                    ),
                  ),


                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Payments per month',style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ))
                    ),
                  ),


                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Intrest Rate',style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ))
                    ),
                  ),


                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Debt per year',style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ))
                    ),
                  ),
                ]
              ),

              pw.ListView.builder(itemBuilder: (ctx , i){
                Mortgage model = Mortgage.fromMap(userModel.mortage[i]);
                return pw.Container(
                  child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                              ),
                              padding: pw.EdgeInsets.symmetric(vertical: 10),
                              child: pw.Text('Loan ${model.number}',style: pw.TextStyle(
                                fontSize: 14,
                              ))
                          ),
                        ),


                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                              ),
                              padding: pw.EdgeInsets.symmetric(vertical: 10),
                              child: pw.Text('\$${model.loanbalanceamount}',style: pw.TextStyle(
                                fontSize: 14,

                              ))
                          ),
                        ),


                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                              ),
                              padding: pw.EdgeInsets.symmetric(vertical: 10),
                              child: pw.Text('\$${model.paymentsperyear}',style: pw.TextStyle(
                                fontSize: 14,

                              ))
                          ),
                        ),


                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                              ),
                              padding: pw.EdgeInsets.symmetric(vertical: 10),
                              child: pw.Text('\$${model.monthlypaymnet}',style: pw.TextStyle(
                                fontSize: 14,

                              ))
                          ),
                        ),


                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                              ),
                              padding: pw.EdgeInsets.symmetric(vertical: 10),
                              child: pw.Text('${model.intrestrate}%',style: pw.TextStyle(
                                fontSize: 14,

                              ))
                          ),
                        ),


                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                              ),
                              padding: pw.EdgeInsets.symmetric(vertical: 10),
                              child: pw.Text('\$${model.monthlypaymnet * 12}',style: pw.TextStyle(
                                fontSize: 14,

                              ))
                          ),
                        ),
                      ]
                  ),
                );
              }, itemCount: userModel.mortage.length),

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
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Rental Income',style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ))
                      ),
                    ),


                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Additional Income',style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ))
                      ),
                    ),


                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Operating Income',style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                          ))
                      ),
                    ),



                  ]
              ),

              pw.SizedBox(height: 10),

              pw.Row(
                  children: [

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                          ),
                          padding: pw.EdgeInsets.symmetric(vertical: 10),
                          child: pw.Text('\$${rentalincome()}',style: pw.TextStyle(
                            fontSize: 14,

                          ))
                      ),
                    ),

                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                          ),
                          padding: pw.EdgeInsets.symmetric(vertical: 10),
                          child: pw.Text('\$${additionalincome()}',style: pw.TextStyle(
                            fontSize: 14,

                          ))
                      ),
                    ),


                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                          ),
                          padding: pw.EdgeInsets.symmetric(vertical: 9),
                          child: pw.Text('\$${operatingincome()}',style: pw.TextStyle(
                            fontSize: 16,

                          ))
                      ),
                    ),

                  ]
              ),



              pw.SizedBox(height: 10),

              pw.Text('Expense',style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline
              )),

              pw.SizedBox(height: 10),



              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('Real Estate Tax',style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold
                                ))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                ),
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('\$${monthlyExpense.realestatetaxes}',style: pw.TextStyle(
                                  fontSize: 14,

                                ))
                            ),
                          ),
                        ]
                    ),
                  ),


                  pw.SizedBox(width: 5),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Lawn / Landscaping',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.lawn}',style: pw.TextStyle(
                                    fontSize: 14,
                                  ))
                              ),
                            ),
                          ]
                      )
                  ),


                ]
              ),



              pw.SizedBox(height: 10),



              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Insurance',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.insurance}',style: pw.TextStyle(
                                    fontSize: 14,

                                  ))
                              ),
                            ),
                          ]
                      ),
                    ),


                    pw.SizedBox(width: 5),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                    alignment: pw.Alignment.center,
                                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                                    child: pw.Text('Accounting / Legal',style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold
                                    ))
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                    alignment: pw.Alignment.center,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                    ),
                                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                                    child: pw.Text('\$${monthlyExpense.accounting}',style: pw.TextStyle(
                                      fontSize: 14,
                                    ))
                                ),
                              ),
                            ]
                        )
                    ),

                  ]
              ),


              pw.SizedBox(height: 10),



              pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Natural Gas',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.naturalgas}',style: pw.TextStyle(
                                    fontSize: 14,

                                  ))
                              ),
                            ),
                          ]
                      ),
                    ),


                    pw.SizedBox(width: 5),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                    alignment: pw.Alignment.center,
                                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                                    child: pw.Text('Homeowner Association Fees',style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold
                                    ))
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                    alignment: pw.Alignment.center,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                    ),
                                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                                    child: pw.Text('\$${monthlyExpense.associationfees}',style: pw.TextStyle(
                                      fontSize: 14,
                                    ))
                                ),
                              ),
                            ]
                        )
                    ),

                  ]
              ),

            ]
          );
        }));

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context){
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            pw.SizedBox(height: 10),



            pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('Electric',style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold
                                ))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                ),
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('\$${monthlyExpense.electric}',style: pw.TextStyle(
                                  fontSize: 14,

                                ))
                            ),
                          ),
                        ]
                    ),
                  ),


                  pw.SizedBox(width: 5),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Property Manager',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.propertymanager}',style: pw.TextStyle(
                                    fontSize: 14,
                                  ))
                              ),
                            ),
                          ]
                      )
                  ),

                ]
            ),


            pw.SizedBox(height: 10),



            pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('Water',style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold
                                ))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                ),
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('\$${monthlyExpense.water}',style: pw.TextStyle(
                                  fontSize: 14,

                                ))
                            ),
                          ),
                        ]
                    ),
                  ),


                  pw.SizedBox(width: 5),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Payroll',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.payroll}',style: pw.TextStyle(
                                    fontSize: 14,
                                  ))
                              ),
                            ),
                          ]
                      )
                  ),

                ]
            ),


            pw.SizedBox(height: 10),



            pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('Trash',style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold
                                ))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                ),
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('\$${monthlyExpense.trash}',style: pw.TextStyle(
                                  fontSize: 14,

                                ))
                            ),
                          ),
                        ]
                    ),
                  ),


                  pw.SizedBox(width: 5),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Flood Insurance',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.floodinsurance}',style: pw.TextStyle(
                                    fontSize: 14,
                                  ))
                              ),
                            ),
                          ]
                      )
                  ),

                ]
            ),


            pw.SizedBox(height: 10),



            pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('Supplies',style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold
                                ))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                ),
                                padding: pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Text('\$${monthlyExpense.supplies}',style: pw.TextStyle(
                                  fontSize: 14,

                                ))
                            ),
                          ),
                        ]
                    ),
                  ),


                  pw.SizedBox(width: 5),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('Others',style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold
                                  ))
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(color: PdfColor.fromHex("#000000"), width: 2),
                                  ),
                                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                                  child: pw.Text('\$${monthlyExpense.others}',style: pw.TextStyle(
                                    fontSize: 14,
                                  ))
                              ),
                            ),
                          ]
                      )
                  ),

                ]
            ),

            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text('Operating Expense',style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                )),
                pw.SizedBox(width: 10),
                pw.Text('\$${operatingexpense()}',style: pw.TextStyle(
                  fontSize: 22,
                )),
              ]
            ),

            pw.SizedBox(height: 10),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 10),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Annual Operating Income',style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
                  pw.SizedBox(width: 10),
                  pw.Text('\$${operatingincome() * 12}',style: pw.TextStyle(
                    fontSize: 22,
                  )),
                ]
            ),

            pw.SizedBox(height: 10),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Annual Operating Expense',style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
                  pw.SizedBox(width: 10),
                  pw.Text('\$${operatingexpense() * 12}',style: pw.TextStyle(
                    fontSize: 22,
                  )),
                ]
            ),

            pw.SizedBox(height: 10),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Annual Debt Service',style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
                  pw.SizedBox(width: 10),
                  pw.Text('\$${totaldebt() * 12}',style: pw.TextStyle(
                    fontSize: 22,
                  )),
                ]
            ),


            pw.SizedBox(height: 10),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Cash flow before taxes',style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
                  pw.SizedBox(width: 10),
                  pw.Text('\$${cashflowbeforetaxes()}',style: pw.TextStyle(
                    fontSize: 22,
                  )),
                ]
            ),

          ]
        );
      }
    ));
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

  double cashflowbeforetaxes(){
    return (operatingincome() * 12) - (operatingexpense() *12) - (totaldebt() * 12);
  }
}