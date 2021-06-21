import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Interface/drawerinterface.dart';
import 'package:flutter/material.dart';

class CDrawer extends StatelessWidget {

  Drawerinterface drawerinterface;

  CDrawer(this.drawerinterface);

  late double width , height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.7,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: CColors.graybg,
          ),

          ListTile(
            onTap: (){
              drawerinterface.dclick(0, 'Return on Cash');
            },
            title: Text('Return on Cash'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),
          ListTile(
            onTap: (){
              drawerinterface.dclick(1, 'Annual Return');
            },
            title: Text('Annual Return'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),

          ListTile(
            onTap: (){
              drawerinterface.dclick(2, 'Annual Return');
            },
            title: Text('Mortgage'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),
          ListTile(
            onTap: (){
              drawerinterface.dclick(3, 'Annual Return');
            },
            title: Text('Monthly Income'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),
          ListTile(
            onTap: (){
              drawerinterface.dclick(4, 'Annual Return');
            },
            title: Text('Additional Adjustment'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),

          ListTile(
            onTap: (){
              drawerinterface.dclick(5, 'Annual Return');
            },
            title: Text('Monthly Expense'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),

          ListTile(
            onTap: (){
              drawerinterface.dclick(9, 'New File');
            },
            title: Text('Add New File'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),

          ListTile(
            onTap: (){
              drawerinterface.dclick(10, 'Logout');
            },
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward_ios , color: CColors.primary,),
          ),
        ],
      ),
    );
  }
}
