import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {

  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
    );
  }
}
