import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oktoast/oktoast.dart';


const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class MapLoc extends StatefulWidget {


  @override
  _ComponentWebviewState createState() => _ComponentWebviewState();
}

class _ComponentWebviewState extends State<MapLoc> {

   String url="https://18pinpin.com/html/map/local.html";
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
getCurrentPosition(desiredAccuracy: LocationAccuracy.best,forceAndroidLocationManager :true).then((value) {
print(position.longitude.toString());
});

  }
   initJS( ){

//    _onProgressChanged =
//        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
//          print(progress);
//          if (progress == 1.0) {
//            if(!isLoad){
//
////              var str = "湖北省武汉市洪山区珞喻路1037号"+"|"+"114.42164"+"|"+"30.517324""|"+position.longitude.toString()+"|"+position.latitude.toString();
//
////              print(str);
////              isLoad = true;
////              _timer = new Timer(const Duration(milliseconds: 1000), () {
//////                print(position.longitude.toString());
////                flutterWebViewPlugin.evalJavascript("setLoc()");
////              });
//            }
//
//          }
//        });
  }
   Timer _timer;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer != null){
      _timer.cancel();
    }

//    _onProgressChanged.cancel();
  }
  @override
  Widget build(BuildContext context) {
    //加载  远程网页 OR 本地网页
//    Set<JavascriptChannel> jsChannels = [
//
//    ].toSet();
    return Scaffold(
        body:url =="" ?Text(""):WebviewScaffold(
          url: url,
//          javascriptChannels: jsChannels,
          mediaPlaybackRequiresUserGesture: false,
          appBar:AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text('地址定位',
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
            actions: <Widget>[
              IconButton(
                  icon: Image.asset(
                    'images/pp_complete.png',
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () {
                    flutterWebViewPlugin.evalJavascript("getAddress()").then((String value) {


                      if(value.isEmpty || value == ""){
                        Navigator.of(context).pop();
                        showToast("地址不能为空");
                      }else{
                        value = value.substring(1,value.length-2);
                        Navigator.of(context).pop(value);
                      }

                    });

                  }),
            ],
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