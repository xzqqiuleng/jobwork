import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/widgets/slide_button.dart';

class MsgChatItem extends StatefulWidget {
  final GlobalKey<SlideButtonState> btnKey;
  final  Map mapData;
  const MsgChatItem({Key key, @required this.btnKey,this.mapData}) : super(key: key);

  @override
  _MsgChatItemState createState() => _MsgChatItemState();
}

class _MsgChatItemState extends State<MsgChatItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SlideButton(
          key: widget.btnKey,
          singleButtonWidth: ScreenUtil().setWidth(116),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(38),
              left: ScreenUtil().setWidth(48),
              right: ScreenUtil().setWidth(48),
              bottom: ScreenUtil().setWidth(38),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(44))),
                  child: Image.network(widget.mapData["comInfo"]["company_img"],
                      width: ScreenUtil().setWidth(88),
                      height: ScreenUtil().setWidth(88),
                      fit: BoxFit.cover),
                ),
                SizedBox(width: ScreenUtil().setWidth(32)),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.mapData["comInfo"]["company_name"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(36),
                                    color: Color.fromRGBO(20, 20, 20, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(16),
                              ),
                              Text(
                                '在线',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                  color: Color.fromRGBO(176, 181, 180, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          widget.mapData["pub_time"],
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromRGBO(159, 199, 235, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setWidth(12)),
                    SizedBox(height: ScreenUtil().setWidth(14)),
                    Text(
                      widget.mapData["msg"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(26),
                        color: Color.fromRGBO(176, 181, 180, 1),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          buttons: <Widget>[
            buildAction(widget.btnKey, Colors.red, () {
              widget.btnKey.currentState.close();
            }),
          ],
        ),
        Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            height: ScreenUtil().setWidth(6)),
      ],
    );
  }

  InkWell buildAction(
      GlobalKey<SlideButtonState> key, Color color, GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(116),
        color: color,
        child: Image.asset(
          'images/img_del_white.png',
          width: ScreenUtil().setWidth(30),
          height: ScreenUtil().setWidth(38),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
