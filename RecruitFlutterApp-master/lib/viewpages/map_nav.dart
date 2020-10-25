import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:geolocator/geolocator.dart';

import 'maputli.dart';



const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class MapNavWeb extends StatefulWidget {
  String address;
  String lat;
  String lng;
  MapNavWeb(this.address,this.lat,this.lng);
  @override
  _ComponentWebviewState createState() => _ComponentWebviewState();
}

class _ComponentWebviewState extends State<MapNavWeb> {

   String url="https://18pinpin.com/html/map/map_nav.html";
   StreamSubscription<double> _onProgressChanged;
   bool isLoad =  false;
   var flutterWebViewPlugin = FlutterWebviewPlugin();


  @override
  void initState() {
    super.initState();
    initLoc();

    initJS();


  }
   Position position;
  initLoc()async{
    LocationPermission permission = await requestPermission();
getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest).then((value) {
print(position.longitude.toString());
});

  }
   initJS( ){

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
          print(progress);
          if (progress == 1.0) {
            if(!isLoad){

//              var str = "湖北省武汉市洪山区珞喻路1037号"+"|"+"114.42164"+"|"+"30.517324""|"+position.longitude.toString()+"|"+position.latitude.toString();
              var str = widget.address+"|"+widget.lng+"|"+widget.lat;
              print(str);
              isLoad = true;
              _timer = new Timer(const Duration(milliseconds: 1000), () {
//                print(position.longitude.toString());
                flutterWebViewPlugin.evalJavascript("setStartLoc('"+str+"')");
              });
            }

          }
        });
  }
   Timer _timer;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer != null){
      _timer.cancel();
    }

    _onProgressChanged.cancel();
  }
  @override
  Widget build(BuildContext context) {
    //加载  远程网页 OR 本地网页
    Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'navGo',
          onMessageReceived: (JavascriptMessage message)  {
            print(message.message);
           if(message.message.contains("百度")){
             MapUtil.gotoBaiduMap(114.42164,30.517324);
           }else if(message.message.contains("高德")){
             MapUtil.gotoAMap(114.42164,30.517324);
           }else if(message.message.contains("腾讯")){
             MapUtil.gotoTencentMap(114.42164,30.517324);
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
            title: Text('地图导航',
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
          geolocationEnabled: true,
          withOverviewMode: true,

        ));
  }
}