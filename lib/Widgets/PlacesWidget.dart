import 'package:cashflow/Extras/CColors.dart';
import 'package:cashflow/Screens/Schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlacesWidget extends StatelessWidget {

  List<String> names = [
    'Bovec',
    'Austin',
  ];
  List<String> images = [
    'https://images.unsplash.com/photo-1546587348-d12660c30c50?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fG5hdHVyYWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
    'https://media.istockphoto.com/photos/green-leaf-with-dew-on-dark-nature-background-picture-id1050634172?k=6&m=1050634172&s=612x612&w=0&h=C6CWho9b4RDhCqvaivYOLV2LK6FzygYpAyLPBlF1i2c=',
  ];
  int i;

  PlacesWidget(this.i);

  late double height , width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.015),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: width * 0.35,
                height: width * 0.35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(
                      images[i%3],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: width * 0.35,
                height: width * 0.35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(names[i % 3],style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.06,
                  fontFamily: 'magic'
                ),),
              ),
            ],
          ),
          SizedBox(width: width * 0.03,),
          Expanded(child:
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return Schedule(names[i % 3]);
                    }));
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: height * 0.015),
                      child: Text(
                        'See Schedule',
                        style: TextStyle(
                          color: CColors.primary,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01,),
                Card(
                  color: CColors.primary,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    child: Text(
                      'Notice Board',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
