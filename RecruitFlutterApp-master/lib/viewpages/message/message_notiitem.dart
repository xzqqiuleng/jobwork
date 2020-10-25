import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/cuswidget/cusbtn_slide.dart';

class MessageNotiItem extends StatefulWidget {
  final GlobalKey<CusBtnSlideState> btnKey;
  final String imgPath;
  final String title;
  final String content;
  final String time;
  const MessageNotiItem({Key key, @required this.btnKey, this.imgPath, this.title, this.content,this.time}) : super(key: key);

  @override
  _MessageNotiItemState createState() => _MessageNotiItemState();
}

class _MessageNotiItemState extends State<MessageNotiItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          key: widget.btnKey,

          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(38),
              bottom: ScreenUtil().setWidth(38),
              left: ScreenUtil().setWidth(48),
              right: ScreenUtil().setWidth(48),
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(44))),
                  child: Image.asset(widget.imgPath,
                      width: ScreenUtil().setWidth(88),
                      height: ScreenUtil().setWidth(88),
                      fit: BoxFit.cover),
                ),
                SizedBox(width: ScreenUtil().setWidth(16)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(16),
                          ),
                          Text(
                            widget.time,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(20)),
                      Text(
                        widget.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: ScreenUtil().setSp(24),
                          color: Color.fromRGBO(176, 181, 180, 1),
                        ),
                      ),
                    ],
                  ),),
              ],
            ),
          ),

        ),
        Container(
          margin: EdgeInsets.symmetric(

          ),
          height: ScreenUtil().setWidth(1),
          color: Color(0xfff0f0f0),
        ),
      ],
    );
  }

  InkWell buildAction(
      GlobalKey<CusBtnSlideState> key, Color color, GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(116),
        color: color,
        child: Image.asset(
          'images/pp_img_del_white.png',
          width: ScreenUtil().setWidth(30),
          height: ScreenUtil().setWidth(38),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
