import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart'; //used in split the array to many groups
import '../methods/navigate_methods.dart';
import '../colors.dart';

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

List Names = List();
List GetNames = List();

TextEditingController NameController = TextEditingController();

class _GroupState extends State<Group> {

  var NumberOfMembers = ['2', '3', '4']; // array for dropdwon button
  TextEditingController NumberOfMembersController = TextEditingController();
  var NumberOfMembersName = "عدد كل مجموعة";

  final _NameformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var navigateMethods = new navigate_methods();

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight + 30) / 12;
    final double itemWidth = size.width / 2;


    return WillPopScope(
      onWillPop: () {
        // Here is code to controll things, when user press back button in (( DEVICE ))

        Names.clear();

        NameController.clear();

        NumberOfMembersController.clear();

        navigateMethods.MoveToLastScreen(context);

      },

      child: Scaffold(
        appBar: AppBar(
          title: Text("مجموعة",textScaleFactor: 1.2 , style: TextStyle(color: Colors.white.withOpacity(0.8)),),
          iconTheme: IconThemeData(color: Colors.white.withOpacity(0.8)),
          backgroundColor: Light_yellow,
          centerTitle: true,

          // I need this leading because when I use drawer the back arrow will be gone !!
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Here is code to controll things, when user press back button in (( AppBar ))
              Names.clear();

              NameController.clear();

              NumberOfMembersController.clear();

              navigateMethods.MoveToLastScreen(context);
            },
          )
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

              TextFieldWithCupertinoPicker(NumberOfMembersController, NumberOfMembers, NumberOfMembersName),

              // أسم الشخص


              Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5.0),
                  child: Form(
                    key: _NameformKey,
                    child: TextFormField(
                      controller: NameController,
                      maxLength: 15,
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
                  )
              ),

              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  // add name +
                  RawMaterialButton(
                    child: Icon(Icons.add),
                    onPressed: (){
                      if (_NameformKey.currentState.validate()) {
                        // if all true do this section
                        setState(() {
                          AddName(NameController.text);
                        });
                      }
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

              Expanded(
                child: ListView(
                  children: <Widget>[
                    // List of Names
                    Container(
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
                                  splashColor: Light_yellow,
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
                                                    color: Light_yellow,
                                                  ),
                                                )),
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Light_yellow, width: 2),
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

                    // Who will pay
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    WhoWillPay.length == 0 ? "" : "الحساب على   ",
                                    textScaleFactor: 1.3,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    WhoWillPayMethod(),
                                    textScaleFactor: 1.3,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),

                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5, top: 15),
                                child: Container(
                                  height: 50,
                                  child: RaisedButton(
                                      color: Light_yellow,
                                      textColor: Colors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('إختيار مجموعة ؟', textScaleFactor: 1.2,),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  List WhoWillPay = List();

  String WhoWillPayMethod(){

    if(WhoWillPay.isEmpty){
      return "";
    }
    else if(WhoWillPay.length == 1){
      return "1- "+WhoWillPay[0].toString();
    }
    else if(WhoWillPay.length == 2){
      return "1- "+WhoWillPay[0].toString()+"\n"+"2- "+WhoWillPay[1].toString();
    }
    else if(WhoWillPay.length == 3){
      return "1- "+WhoWillPay[0].toString()+"\n"+"2- "+WhoWillPay[1].toString()+"\n"+"3- "+WhoWillPay[2].toString();
    }
    else if(WhoWillPay.length == 4){
      return "1- "+WhoWillPay[0].toString()+"\n"+"2- "+WhoWillPay[1].toString()+"\n"+"3- "+WhoWillPay[2].toString()+"\n"+"4- "+WhoWillPay[3].toString();
    }

  }

  var rng = new Random(); // For WhoPay()
  int randomCode;
  List Groups = List();

  // shuffle method is for reorder list RANDOMLY
//  List shuffle(List items) {
//
//    var random = new Random();
//
//    // Go through all elements.
//    for (var i = items.length - 1; i > 0; i--) {
//
//      // Pick a pseudorandom number according to the list length
//      var n = random.nextInt(i + 1);
//
//      var temp = items[i];
//      items[i] = items[n];
//      items[n] = temp;
//    }
//
//    return items;
//  }
  
  Widget WhoPay(){

    if(Names.isEmpty){

      ErrorMessage == "لا يوجد اسماء مضافه للإختيار منها";

    }
    else{

      ErrorMessage = "";


      /*

      1- GetNames is list defined in the beginning of this file, It get the list of names the user add it before click on pick,
         we don't use Names list directly because the show of names will changed.

      2- Use Shuffle method to reorder list RANDOMLY.

      3- Use partition to divide one list to groups.

      4- Define List and save step 3 in it as List, because we need to select group randomly.

      5-

    */

      GetNames = Names;

      // var NamesToGroups = partition( LIST_YOU_WANT_USE , LENGTH_OF_EACH_GROUP );
      var NamesToGroups = partition(GetNames, int.parse(NumberOfMembersController.text));
      Groups = NamesToGroups.toList();

      var rng = new Random(); // For WhoPay()
      int n = 0 + rng.nextInt(Groups.length - 0);

      WhoWillPay = Groups[n];

      print(Groups[n].toString());

    }

    // TODO: Error Message not changed when click on chose button, it should change the message to : 'fill the list before click chose'

  }

  void ClearName(){
    WhoWillPay.clear();
    ErrorMessage = "";
    Names.clear();
  }

  void RemoveName(){

    WhoWillPay.clear();
    ErrorMessage = "";
    if(Names.length != 0){
      Names.removeLast();
    }
  }

  String ErrorMessage = "";
  Icon warnningIcon = Icon(Icons.warning, color: Colors.red,);

  Widget AddName(String Name){

    if(Name.trim().length == 0){

      ErrorMessage = "لا يمكن ادخال مسافة فقط";
      NameController.clear();

    }
    else{

      ErrorMessage = "";

      if(Names.length == 8){

        ErrorMessage = "الحد الاقصى ثمانية اشخاص";

      }
      else{
        Names.add(Name);
        NameController.clear();
      }
    }

  }


  // Cupertino Picker
  int selected_item = 0;

  Widget TextFieldWithCupertinoPicker(TextEditingController Controller, var items, var labelName){
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      // Sup Location Drop Down button
      child: TextField(
          focusNode: AlwaysDisabledFocusNode(),
          controller: Controller,
          // to change value of textField to what user select from items
          onTap: () async {
//            selected_item = 0;
            await showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Color(0xFF737373),
                  height: 220,
                  child: Container(
                    child : _CupertinoPicker(items,Controller),
                    // call method to show items in bottom sheet
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                        )
                    ),
                  ),
                );
              },
            );
          },
          decoration: InputDecoration(
              labelText: labelName,
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(5.0),
              ))),
    );
  }

  Widget _CupertinoPicker(var items, TextEditingController TextFieldController) {

    final FixedExtentScrollController scrollController = new FixedExtentScrollController(initialItem: selected_item);

    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("اختيار" , style: TextStyle(color: Light_yellow),),
              onPressed: (){
                setState(() {
                  TextFieldController.text = items[selected_item==null? 0:selected_item];
                  Navigator.pop(context);
                });
              },
            ),
            Spacer(flex: 2,),
            FlatButton(
                child: Text("رجوع" , style: TextStyle(color: Light_yellow),),
                onPressed: (){
                  setState(() {
                    Navigator.pop(context);
                  });
                }
            ),
          ],
        ),
        Container(
            height: 150,
            child: CupertinoPicker(
              scrollController: scrollController, // keep last select to inital selection next time
              itemExtent: 48,
              squeeze: 1.3,
              backgroundColor: Colors.transparent,
              onSelectedItemChanged: (index) {
                selected_item = index;
  //                setState(() {
  //                  TextFieldController.text = items[selected_item][NameOfList];
  //                });
              },
              children: List<Widget>.generate(items.length, (index) {
                return Center(
                  child: Text(
                    items[index],
                    style: TextStyle(fontSize: 25.0),
                  ),
                );
              }),
            ),
        )
      ],
    );
    }

}

// used to hide keyboard in Text Field
class AlwaysDisabledFocusNode extends FocusNode {
  bool get hasFocus => false;
}