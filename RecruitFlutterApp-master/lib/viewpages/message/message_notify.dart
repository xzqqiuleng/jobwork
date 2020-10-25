import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/cuswidget/cuswidget_combar.dart';

import 'details_notify.dart';
import 'items_notif.dart';


class MessageNotify extends StatefulWidget {
  @override
  _MessageNotifyState createState() => _MessageNotifyState();
}

class _MessageNotifyState extends State<MessageNotify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: CusWidgetComBar(
        leading: 'images/pp_img_arrow_left_black.png',
        leftListener: () {
          Navigator.pop(context);
        },
        center: Text(
          '通知',
          style: TextStyle(
              color: Colors.black87,
              fontSize: ScreenUtil().setSp(36),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(48),right:ScreenUtil().setWidth(48),bottom: ScreenUtil().setWidth(48),),
        itemBuilder: (context, index) {
          if (index < 5) {
            return GestureDetector(
                child:ItemsNotify(),
               behavior: HitTestBehavior.opaque,
               onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsNotify()))
            );
          }
          return null;
        },
        itemCount: 1,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
