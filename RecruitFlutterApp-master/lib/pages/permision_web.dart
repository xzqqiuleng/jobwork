import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'share_helper.dart';



const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class PermissionWeb extends StatefulWidget {


  @override
  _ComponentWebviewState createState() => _ComponentWebviewState();
}

class _ComponentWebviewState extends State<PermissionWeb> {

   String url="";
  @override
  void initState() {
    super.initState();

    MiviceRepository().getToken().then((value) {

      if(null != value&& value != ""){

     setState(() {
       url ="https://brain.baidu.com/face/print/?token=${value}&successUrl=http://116.62.45.24/html/success.html&failedUrl=http://116.62.45.24/html/fail.html";
     });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //加载  远程网页 OR 本地网页
    Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'faceResult',
          onMessageReceived: (JavascriptMessage message) {
            print(message.message);
            if(message.message == "success"){
              Map userMap = Map();
              userMap["real_status"] ="1";
              userMap["user_id"] =ShareHelper.getBosss().userId;
              MiviceRepository().updateUser(userMap).then((value) {

              });

            }else{
              showToast("验证失败");

            }
          }),
    ].toSet();
    return Scaffold(
        body:url =="" ?Text(""):WebviewScaffold(
          url: url,
          javascriptChannels: jsChannels,
          mediaPlaybackRequiresUserGesture: false,
          appBar:AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text('身份实名认证',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(37, 38, 39, 1))),
            leading: IconButton(
                icon: Image.asset(
                  'images/ic_back_arrow.png',
                  width: 18,
                  height: 18,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          ),
          withZoom: false,
          withLocalStorage: true,
          hidden: true,

          useWideViewPort: true,

          displayZoomControls:false,

          withOverviewMode: true,
        ));
  }
}