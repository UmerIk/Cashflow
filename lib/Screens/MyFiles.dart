import 'dart:io';
import 'package:path/path.dart';
import 'package:cashflow/Screens/PdfScreen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyFilesScreen extends StatefulWidget {

  @override
  _MyFilesScreenState createState() => _MyFilesScreenState();
}

class _MyFilesScreenState extends State<MyFilesScreen> {
  late String _futureGetPath;

  List<dynamic> listImagePath = [];

  var _permissionStatus;

  String errortext = 'No Files Added yet';

  late double width , height;

  bool _isbloading = false;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    
    getfile();
  }

  getfile() async{
    _futureGetPath = await _getPath();
    var dir = Directory(_futureGetPath);
    _fetchFiles(dir);
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Files'),
      ),
      body: SafeArea(
        child: listImagePath.length == 0  ?
        Center(child: Text(errortext),)
            :
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: listImagePath.length,
          itemBuilder: (BuildContext context, int index) {
            return _getListImg(listImagePath[index] , context);
          },
          primary: false,

        ),
      ),
    );
  }

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    setState(() => _permissionStatus = status);
  }


  Future<String> _getPath() async{

    if(Platform.isAndroid){
      return '/storage/emulated/0/AWI_Cash_FLow';
    }else{
      Directory directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = [];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(pdf)", caseSensitive: false);
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePath = listImage;
        errortext = 'No Files Added yet';
      });
    });
  }

  Widget _getListImg(dynamic listImagePath , BuildContext context) {
    File file = listImagePath;
    String basenam = basename(file.path);
    print(basenam);
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return PdfScreen(file);
        }));
      },
      leading: Image(
        image: AssetImage('assets/images/pdf.png',),
        width: width * 0.08,
      ),
      title: Text(
        basenam,
        style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'fm'
        ),
        maxLines: 1,
      ),
    );
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return PdfScreen(file);
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01 , vertical: height * 0.005),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              basenam,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'fm'
              ),
              maxLines: 1,
            ),

            Divider(),
          ],
        )
      ),
    );
  }

}
