import 'package:flutter/material.dart';
import 'alone.dart';
import '../methods/images.dart';
import '../screens/group.dart';
import '../methods/clip_path.dart';
import '../colors.dart';

class GroupOrAlone extends StatefulWidget {
  @override
  _GroupOrAloneState createState() => _GroupOrAloneState();
}

class _GroupOrAloneState extends State<GroupOrAlone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Light_yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 350,
              child: RawMaterialButton(
                child: ClipPath(
                  clipper: ImagePath(),
                  child: Container(
                    color: Light_red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.person, color: Colors.white.withOpacity(0.9), size: 120,),
                            Text(
                              "فردي",
                              textScaleFactor: 2,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                              ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Alone();
                    }));
                  });
                },
              )
            ),
            Expanded(
              child: RawMaterialButton(
                child: Container(
                  color: Light_yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.group, color: Colors.white.withOpacity(0.9), size: 120,),
                          Text(
                              "مجموعة",
                              textScaleFactor: 2,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.65),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Group();
                    }));
                  });
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
