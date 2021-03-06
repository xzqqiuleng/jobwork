import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/cuswidget/cusbtn_slide.dart';


class ChatItemMessage extends StatefulWidget {
  final  Map mapData;
  const ChatItemMessage({Key key,this.mapData}) : super(key: key);

  @override
  _ChatItemMessageState createState() => _ChatItemMessageState();
}

class _ChatItemMessageState extends State<ChatItemMessage> {
  String msg="";
  @override
  Widget build(BuildContext context) {
    if( widget.mapData["msg"].contains("state")&& widget.mapData["msg"].contains("msg")&& widget.mapData["msg"].contains("type")&& widget.mapData["msg"].contains("userId")){
      msg = "Boss，人才交换消息";
    }else{
      msg=widget.mapData["msg"];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
       Container(
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

                Stack(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setWidth(44))),
                      child: Image.network(widget.mapData["comInfo"]["company_img"],
                          width: ScreenUtil().setWidth(88),
                          height: ScreenUtil().setWidth(88),
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 0,
                      child: Offstage(
                      offstage: widget.mapData["unread_num"].toString()=="0"?true:false ,
                      child: Container(
                        width: 14,
                        height: 14,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.redAccent
                        ),
                        child: Text(
                          widget.mapData["unread_num"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ),
                       )
                    ),
                  ],
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

                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          widget.mapData["pub_time"].toString().split(" ")[0],
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setWidth(12)),
                    SizedBox(height: ScreenUtil().setWidth(14)),
                    Text(
                      msg,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(26),
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),


        Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            height: ScreenUtil().setWidth(4)),
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
