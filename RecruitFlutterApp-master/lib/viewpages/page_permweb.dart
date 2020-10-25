import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/viewpages/loginreg/myuser.dart';
import 'package:recruit_app/viewpages/storage_manager.dart';
import 'http/pinpin_response.dart';
import 'shareprefer_utils.dart';



const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class PagePermWeb extends StatefulWidget {


  @override
  _PagePermWebState createState() => _PagePermWebState();
}

class _PagePermWebState extends State<PagePermWeb> {

   String url="";
  @override
  void initState() {
    super.initState();

    PinPinReponse().getToken().then((value) {

      if(null != value&& value != ""){

     setState(() {
       url ="https://brain.baidu.com/face/print/?token=${value}&successUrl=http://18pinpin.com/html/fail.html&failedUrl=http://18pinpin.com/html/success.html";
     });
      }
    });
  }
 initSMRZ()async{
   Map userMap = Map();
   userMap["real_status"] ="1";
   userMap["user_id"] =SharepreferUtils.getBosss().userId;
   PinPinReponse().updateUser(userMap).then((value) {

       MyUser user = SharepreferUtils.getBosss();
       user.realStatus="1";
       StorageManager.localStorage.setItem(SharepreferUtils.BOSSUser, user);
       Navigator.of(context).pop(true);
       showToast("实名认证成功");
   });
 }
  @override
  Widget build(BuildContext context) {
    //加载  远程网页 OR 本地网页
    Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'faceResult',
          onMessageReceived: (JavascriptMessage message)  {
            print(message.message);
            if(message.message == "success"){
            initSMRZ();

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
                  'images/pp_ic_back_arrow.png',
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