import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:url_launcher/url_launcher.dart';

class KFDialog extends Dialog {


  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(60),
                      right: ScreenUtil().setWidth(60),
                      top: ScreenUtil().setWidth(60),
                    ),
                    child: Text(
                      "联系我们",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(36),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      right: ScreenUtil().setWidth(30),
                      top: ScreenUtil().setWidth(20),
                    ),
                    child: Text(
                      "可选择下列任意一个QQ客服",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenUtil().setSp(26),
                      ),
                    ),
                  ),
                  Container(

                    height: ScreenUtil().setWidth(10),

                  ),
                  Column(
                    children: <Widget>[
                       GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                            ),
                            alignment: Alignment.center,
                            height: ScreenUtil().setWidth(90),
                            child: Text(
                              "QQ客服一",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colours.app_main,
                                fontSize: ScreenUtil().setSp(34),
                              ),
                            ),
                          ),
                          onTap:() async{
                            String url;
                            if(Platform.isAndroid){
                              url = 'mqqwpa://im/chat?chat_type=wpa&uin=3008722346';
                            }else{
//                  url = 'mqq://im/chat?chat_type=wpa&uin=$qq&version=1&src_type=web';
                            }
// 确认一下url是否可启动
                            if(await canLaunch(url)){
                              await launch(url); // 启动QQ
                            }else{
                              // 自己封装的一个 Toast

                              showToast('无法启动QQ');
                            }
                            Navigator.of(context).pop();
                          }),


                      Container(
                        width:double.infinity,
                        height: 0.4,
                        color: Color.fromRGBO(177, 177, 179, 1),
                      ),

                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                            ),
                            alignment: Alignment.center,
                            height: ScreenUtil().setWidth(90),
                            child: Text(
                              "QQ客服二",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colours.app_main,
                                fontSize: ScreenUtil().setSp(34),
                              ),
                            ),
                          ),
                          onTap: () async{
                            String url;
                            if(Platform.isAndroid){
                              url = 'mqqwpa://im/chat?chat_type=wpa&uin=3008722348';
                            }else{
//                  url = 'mqq://im/chat?chat_type=wpa&uin=$qq&version=1&src_type=web';
                            }
// 确认一下url是否可启动
                            if(await canLaunch(url)){
                              await launch(url); // 启动QQ
                            }else{
                              // 自己封装的一个 Toast

                              showToast('无法启动QQ');
                            }
                            Navigator.of(context).pop();
                          }),

                      Container(
                        width:double.infinity,
                        height: 0.4,
                        color: Color.fromRGBO(177, 177, 179, 1),
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30),
                          ),
                          alignment: Alignment.center,
                          height: ScreenUtil().setWidth(90),
                          child: Text(
                            "QQ客服三",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colours.app_main,
                              fontSize: ScreenUtil().setSp(34),
                            ),
                          ),
                        ),
                        onTap: () async{
                          String url;
                          if(Platform.isAndroid){
                            url = 'mqqwpa://im/chat?chat_type=wpa&uin=3008722347';
                          }else{
//                  url = 'mqq://im/chat?chat_type=wpa&uin=$qq&version=1&src_type=web';
                          }
// 确认一下url是否可启动
                          if(await canLaunch(url)){
                            await launch(url); // 启动QQ
                          }else{
                            // 自己封装的一个 Toast

                            showToast('无法启动QQ');
                          }
                          Navigator.of(context).pop();
                        }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
