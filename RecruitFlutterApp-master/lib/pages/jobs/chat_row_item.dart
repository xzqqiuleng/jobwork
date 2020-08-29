import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/event_bus.dart';
import 'package:recruit_app/model/chat_list.dart';
import 'package:recruit_app/pages/employe/boss_chat_room_intro.dart';
import 'package:recruit_app/pages/jobs/chat_room_intro.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';

class ChatRowItem extends StatelessWidget {
  final Chat chat;
  final int index;
  final bool isBoss;

  const ChatRowItem({
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
      if(ShareHelper.isBossLogin()){
        userId = ShareHelper.getBosss().userId;
      }else{
        userId = ShareHelper.getUser().userId;
      }
      Map map = new Map();
      map["msg"] =json.encode(msgMap);
      map["user_id"] =userId;
      map["reply_id"] =chat.replayId;
      map["uuid"] =msgMap["uuid"];
      MiviceRepository().agreeRe(map).then((value) {
        print(value);
               eventBus.fire(ChatReplayEvent(type));
           });
    }

  }
  Function  refum(){
    if(chat.content.contains("state")&&chat.content.contains("msg")&&chat.content.contains("type")&&chat.content.contains("userId")){
      Map msgMap = json.decode(chat.content);
      msgMap["state"] ="1";
      String userId;
      if(ShareHelper.isBossLogin()){
        userId = ShareHelper.getBosss().userId;
      }else{
        userId = ShareHelper.getUser().userId;
      }
      Map map = new Map();
      map["msg"] =json.encode(msgMap);
      map["user_id"] =userId;
      map["reply_id"] =chat.replayId;
      map["uuid"] =msgMap["uuid"];
      MiviceRepository().agreeRe(map).then((value) {
        eventBus.fire(ChatReplayEvent("-1"));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if(chat.content.contains("state")&&chat.content.contains("msg")&&chat.content.contains("type")&&chat.content.contains("userId")){
      String  id;

      if(ShareHelper.isBossLogin()){
        id = ShareHelper.getBosss().userId;
      }else{
        id = ShareHelper.getUser().userId;
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
                                   color: Colours.app_main
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
                           color: Colours.app_main
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
