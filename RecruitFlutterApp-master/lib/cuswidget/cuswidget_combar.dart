import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusWidgetComBar extends StatefulWidget implements PreferredSizeWidget {
  final String leading;
  final String leftText;
  final Widget center;
  final Widget rightAction;
  final Color backgroundColor;
  final Function() leftListener;

  CusWidgetComBar(
      {this.leading,
      this.leftText='',
      this.center,
      this.rightAction,
      this.backgroundColor,
      this.leftListener});

  @override
  _CusWidgetComBarState createState() => _CusWidgetComBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(56);
}

class _CusWidgetComBarState extends State<CusWidgetComBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: SafeArea(child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap:widget.leftListener,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(
                      widget.leading,
                      width: ScreenUtil().setWidth(30),
                      height: ScreenUtil().setWidth(30),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(16),
                    ),
                    Text(
                      widget.leftText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: ScreenUtil().setSp(36),
                        color: Color.fromRGBO(159, 199, 235, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: widget.center,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: widget.rightAction,
          ),
        ],
      ),),
    );
  }
}
