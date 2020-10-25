import 'package:flutter/material.dart';

class CustCheck extends StatefulWidget {
  final String normalIcon;
  final String checkIcon;
  final double size;
  final Function(bool) onValueChanged;
  CustCheck({Key key,@required this.normalIcon,@required this.checkIcon,this.size = 16,this.onValueChanged}):super(key:key);

  @override
  _CustCheckState createState() => _CustCheckState();
}

class _CustCheckState extends State<CustCheck> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: InkWell(
        onTap: () {
          isCheck = !isCheck;
          if (widget.onValueChanged != null) {
            widget.onValueChanged(isCheck);
          }
          setState(() {
            
          });
        },
        child: new Container(
          child: Image.asset(isCheck ? widget.checkIcon : widget.normalIcon,fit: BoxFit.fitWidth,),
        ),
      ),
    );
  }
}