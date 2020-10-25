import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:recruit_app/colors_utils.dart';

class PageNorweb extends StatelessWidget{
  String url;
 PageNorweb(this.url);


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(

      body: WebviewScaffold(
          url: url)


    );

  }

}