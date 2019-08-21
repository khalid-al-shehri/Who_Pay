import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/group_or_alone.dart';
import 'methods/images.dart';

void main() {

  runApp(MaterialApp(

    // From line 15 to 22 is for screen direction

    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("ar", "SA"), // OR Locale('ar', 'AE') OR Other RTL locales
    ],
    locale: Locale("ar", "SA"), // OR Locale('ar', 'AE') OR Other RTL locales,

    debugShowCheckedModeBanner: false,

    title: "من يحاسب ؟",
    home: splashPage(),

    theme: ThemeData(
        primaryColor: Colors.white, // AppBar, border of textField //Light_blue
        accentColor: Colors.white, //Shadow from swipe up or down
        fontFamily: 'sans',

    ),
  ));
}


var imagesMethod = Images();

class splashPage extends StatefulWidget {
  @override
  _splashPageState createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  void initState(){
    super.initState();

    Future.delayed(
        Duration(seconds: 3),
            (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context)=> GroupOrAlone()
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage("images/backgrounds/background1.png"),
//              fit: BoxFit.cover,
//            ),
//          ),
          child:Center(
            child: imagesMethod.Logo(400, 400, 0),
          )
      ),
    );
  }
}
