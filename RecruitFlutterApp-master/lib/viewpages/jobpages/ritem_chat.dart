import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/util_event.dart';
import 'package:recruit_app/viewmodel/data_chat.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';

import '../shareprefer_utils.dart';


class RitemChat extends StatelessWidget {
  final ChatBean chat;
  final int index;
  final bool isBoss;

  const RitemChat({
    Key key,
    this.chat,
    this.index,
    this.isBoss,
  }) : super(key: key);
  Function  agree(){
    if(chat.content.contains("state")&&chat.content.contains("msg")&&chat.content.contains("type")&&chat.content.contains("userId")){
      Map msgMap = json.decode(chat.content);
    msgMap["state"] = "2";
      String  type = msgMap["type"];
      String userId;
      if(SharepreferUtils.isBossLogin()){
        userId = SharepreferUtils.getBosss().userId;
      }else{
        userId = SharepreferUtils.getUser().userId;
      }
      Map map = new Map();
      map["msg"] =json.encode(msgMap);
      map["user_id"] =userId;
      map["reply_id"] =chat.replayId;
      map["uuid"] =msgMap["uuid"];
      PinPinReponse().agreeRe(map).then((value) {
        print(value);
               eventBus.fire(ReplayChatEvent(type));
           });
    }

  }
  Function  refum(){
    if(chat.content.contains("state")&&chat.content.contains("msg")&&chat.content.contains("type")&&chat.content.contains("userId")){
      Map msgMap = json.decode(chat.content);
      msgMap["state"] ="1";
      String userId;
      if(SharepreferUtils.isBossLogin()){
        userId = SharepreferUtils.getBosss().userId;
      }else{
        userId = SharepreferUtils.getUser().userId;
      }
      Map map = new Map();
      map["msg"] =json.encode(msgMap);
      map["user_id"] =userId;
      map["reply_id"] =chat.replayId;
      map["uuid"] =msgMap["uuid"];
      PinPinReponse().agreeRe(map).then((value) {
        eventBus.fire(ReplayChatEvent("-1"));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if(chat.content.contains("state")&&chat.content.contains("msg")&&chat.content.contains("type")&&chat.content.contains("userId")){
      String  id;

      if(SharepreferUtils.isBossLogin()){
        id = SharepreferUtils.getBosss().userId;
      }else{
        id = SharepreferUtils.getUser().userId;
      }

        Map msgMap = json.decode(chat.content);
        String  state = msgMap["state"].toString();
        String  msg = msgMap["msg"];
        String  type = msgMap["type"];
        String  userId = msgMap["userId"];
      String typeTxt = "";
      if(type.toString() == "0"){
        typeTxt ="手机号";

      }else if(type.toString() == "1"){
        typeTxt ="微信号";
      }else {
        typeTxt ="邮箱";

      }
        if(userId == id){
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 16),
              child:Text("请求交换${typeTxt}已发出")
            );
        }else{
           if(state.toString() == "0"){
             return Container(
               height:110,
               margin: EdgeInsets.all(20),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(4),
                 color: Colors.white
               ),
               child: Column(
                 children: [
                   SizedBox(
                     height: 16,
                   ),
                   Text("我想要和你交换${typeTxt}，您是否同意?",style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.black87
                   ),),
                   Container(
                     margin: EdgeInsets.symmetric(vertical: 16),
                     height: 0.1,
                     color: Colors.black54,
                   ),
                   Row(
                     children: [
                       Expanded(
                         flex: 1,
                         child: GestureDetector(
                           onTap: agree,
                           behavior: HitTestBehavior.opaque,
                           child:Center(
                             child: Text(

                               "同意",
                               style: TextStyle(
                                   color: ColorsUtils.app_main
                               ),
                             ),
                           )
                         ),
                       ),
                       Expanded(
                         flex: 1,
                         child: GestureDetector(
                           onTap: refum,
                           behavior: HitTestBehavior.opaque,
                           child: Center(
                             child: Text(
                               "拒绝",
                               style: TextStyle(
                                   color: Colors.grey
                               ),
                             ),
                           )
                         ),
                       )
                     ],
                   )
                 ],
               ),
             );
           }else if(state.toString() == "1"){
             return Container(
                 alignment: Alignment.center,
                 padding: EdgeInsets.symmetric(vertical: 16),
                 child:Text("已拒绝交换${typeTxt}的请求")
             );
           }else{

             return Container(
                 height:100,
                 alignment: Alignment.center,
                 margin: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(4),
                         color: Colors.white
                 ),
                 child:Column(
                   children: [
                     SizedBox(
                       height: 16,
                     ),
                     Text(typeTxt,style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Colors.black87
                     ),),
                     SizedBox(
                       height: 16,
                     ),
                     Text(
                       msg,
                       style: TextStyle(
                           color: ColorsUtils.app_main
                       ),
                     ),
                   ],
                 )
             );
           }
        }
    }
    if (chat.isMine) {
      return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(136),
            top: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(48)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Material(
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(
                          ScreenUtil().setWidth(20),
                        ),
                      ),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                      child: Text(
                        chat.content,
                        style: TextStyle(
                          height: 1.4,
                          fontSize: ScreenUtil().setSp(28),
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    elevation: 0.2,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(20),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(10),
                  ),

                ],
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(12),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(44),
              ),
              child: Image.network(
                chat.user_icon,
                width: ScreenUtil().setWidth(88),
                height: ScreenUtil().setWidth(88),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(48),
            top: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(136)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(44),
              ),
              child: Image.network(
                chat.head_icon,
                width: ScreenUtil().setWidth(88),
                height: ScreenUtil().setWidth(88),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(12),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(20),
                    ),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(
                          ScreenUtil().setWidth(20),
                        ),
                      ),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                      child: Text(
                        chat.content,
                        style: TextStyle(
                          height: 1.4,
                          fontSize: ScreenUtil().setSp(28),
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    elevation: 0.2,
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(10),
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
