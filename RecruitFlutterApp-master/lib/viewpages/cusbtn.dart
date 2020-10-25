import 'package:flutter/material.dart';


class Cusbtn extends StatelessWidget{
  double height;
  double margin;
  double radius;
  String text;
  Color btnColor;
  double fontSize;
  Function onPressed;

  Cusbtn({
    this.height:36,
    this.margin:66,
    this.radius:4,
    this.text,
    this.btnColor,
    this.onPressed,
    this.fontSize:14,



  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
       
      width: double.infinity,
      height: height,
      margin: EdgeInsets.only(left: margin,right: margin),
      child: RaisedButton(
        
        disabledTextColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)

        ),
        onPressed: onPressed,
        child: Text(text,
          style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),
        color: btnColor,
        disabledColor: btnColor,
        textColor: Colors.white,
      ),
    );
  }

}