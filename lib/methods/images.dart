import 'package:flutter/material.dart';

class Images{

  Widget Logo(double width, double height, double margin){

    AssetImage assetImage = AssetImage("images/logo.png");
    Image image = Image(image: assetImage, width: width, height: height,);

    return Container(child: image, margin: EdgeInsets.all(margin),);

  }

  Widget CashLogo(double width, double height, double margin){

    AssetImage assetImage = AssetImage("images/cash_logo.png");
    Image image = Image(image: assetImage, width: width, height: height,);

    return Container(child: image, margin: EdgeInsets.all(margin),);

  }

}