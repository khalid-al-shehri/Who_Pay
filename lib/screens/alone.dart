import 'dart:math';

import 'package:flutter/material.dart';
import '../colors.dart';

class Alone extends StatefulWidget {
  @override
  _AloneState createState() => _AloneState();
}

List Names = List();

TextEditingController NameController = TextEditingController();

class _AloneState extends State<Alone> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight + 100) / 12;
    final double itemWidth = size.width / 2;


    return Scaffold(
      appBar: AppBar(
        title: Text("فردي",textScaleFactor: 1.2 , style: TextStyle(color: Colors.white.withOpacity(0.8)),),
        iconTheme: IconThemeData(color: Colors.white.withOpacity(0.8)),
        backgroundColor: Light_red,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.grey.withOpacity(0.1),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            // Error Message
            Container(
              child: Text(
                ErrorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),

            // أسم الشخص
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 5.0),
              child: TextFormField(
                controller: NameController,
                maxLength: 20,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'الاسم فارغ ، الرجاء كتابة اسم';
                  }
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'اسم الشخص',
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),

            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // add name +
                RawMaterialButton(
                  child: Icon(Icons.add),
                  onPressed: (){
                    setState(() {
                      AddName(NameController.text);
                    });
                  },
                ),

                // clear all X
                RawMaterialButton(
                  child: Icon(Icons.clear, color: Colors.red,),
                  onPressed: (){
                    setState(() {
                      ClearName();
                    });
                  },
                ),

                // remove last one -
                RawMaterialButton(
                  child: Icon(Icons.remove),
                  onPressed: (){
                    setState(() {
                      RemoveName();
                    });
                  },
                ),

              ],
            ),

            // List of Names
            Expanded(
              flex: 2,
              child: Container(
                    height: 270,
                    padding: EdgeInsets.only(top: 5),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List<Widget>.generate(Names.length, (index){
                        return Container(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Wrap(
                            children: <Widget>[
                              FlatButton(
                                splashColor: Light_red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                          height: 35.0, // height of the button
                                          width: 35.0, // width of the button
                                          child: Center(
                                              child: Text(
                                                (index+1).toString(),
                                                textScaleFactor: 1.2,
                                                style: TextStyle(
                                                  color: Light_red,
                                                ),
                                              )),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Light_red, width: 2),
                                          )),
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Text(
                                        Names[index],
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                          letterSpacing: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                onPressed: (){
                                  setState(() {
                                    print(Names[index]);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
            ),

            // Who will pay
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text(
                          WhoWillPay.length == 0 ? "" : "الحساب على $WhoWillPay  ",
                          textScaleFactor: 1.6,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),

                        Icon(Icons.monetization_on, color: WhoWillPay.length == 0 ? Colors.transparent : Light_red, size: 40,)

                      ],
                    )
                  ),
                ],
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 15),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                          color: Light_red,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('إختيار  ', textScaleFactor: 1.2,),
                              Icon(Icons.insert_emoticon, color: Colors.white)
                            ],
                          ),
                          onPressed: (){
                            setState(() {
                              WhoPay();
                            });
                          }
                      ),
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  String WhoWillPay = "";
  var rng = new Random(); // For WhoPay()
  int randomCode;

  void WhoPay(){

    if(Names.isEmpty){

      ErrorMessage == "لا يوجد اسماء مضافه لاختيار منها";

    }
    else {

      WhoWillPay = "";
      ErrorMessage = "";

      // Variable = min + rng.nextInt(max - min);

      randomCode = 0 + rng.nextInt(Names.length - 0);

      WhoWillPay = Names[randomCode];


    }

    // TODO: Error Message not changed when click on chose button, it should change the message to : 'fill the list before click chose'

  }

  void ClearName(){
    WhoWillPay = "";
    ErrorMessage = "";
    Names.clear();
  }

  void RemoveName(){

    WhoWillPay = "";
    ErrorMessage = "";
    if(Names.length != 0){
      Names.removeLast();
    }
  }

  String ErrorMessage = "";
  Icon warnningIcon = Icon(Icons.warning, color: Colors.red,);

  Widget AddName(String Name){

    // to check value of name not nothing !
    if(Name.length > 0){
      // to check just 8 names in list
      if(Names.length == 8){

        ErrorMessage = "الحد الاقصى ثمانية اشخاص";

        return Text(
          ErrorMessage,
          style: TextStyle(color: Colors.red),
        );
      }
      else{
        Names.add(Name);
        NameController.clear();
      }
    }
  }

}
