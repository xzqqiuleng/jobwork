import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:recruit_app/colors_utils.dart';

class PageAgreDetail extends StatelessWidget{
  int type;
  String htmlUrl="";
 PageAgreDetail(this.type);


  @override
  Widget build(BuildContext context) {

    List _items=["用户服务协议","用户隐私政策"];
     if(type == 0){
       htmlUrl = "https://18pinpin.com/html/protocol/agreement.html";
     }else{
       htmlUrl = "https://18pinpin.com/html/protocol/private.html";
     }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.bg_color,
        title: Text(_items[type],
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorsUtils.black_212920
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back, color: ColorsUtils.black_212920), //自定义图标
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          );
        },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: WebviewScaffold(
          url: htmlUrl)


    );

  }

}