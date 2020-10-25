import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CusWidgetBDrawer extends StatefulWidget {
  final double smallHeight;
  final double marginTop;
  final Widget child;

  const CusWidgetBDrawer(
      {Key key, this.marginTop, this.smallHeight, this.child})
      : super(key: key);

  @override
  _CusWidgetBDrawerState createState() => _CusWidgetBDrawerState();
}

class _CusWidgetBDrawerState extends State<CusWidgetBDrawer> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 0),
      child: widget.child,
    );
  }
}
