import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/utils/resource.dart';
import 'package:recruit_app/pages/utils/screen.dart';


import 'home_banner.dart';


class HomeHeadPlan extends StatelessWidget {
  final List<BannerModel> bannerDatas;
  final List<TopicTabModel> topicTabMenus;


  final double height;
  final double bannerHeight;
  

  HomeHeadPlan({Key key,this.bannerDatas,this.bannerHeight,this.topicTabMenus,this.height}):super(key:key);



  Widget _buildMiddelBar() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: topicTabMenus.map((model){
          return Expanded(
            flex: 1,
            child: new Container(
              child: new FadeInImage.assetNetwork(
                placeholder: globalPlaceHolderImage,
                image: model.picture ?? '',
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return new Container(
      width: Screen.width,
      height: height,
      color: Color.fromARGB(255, 242, 242, 245),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new HomeBanner(bannerModels: bannerDatas,height: bannerHeight,placeholder:  globalPlaceHolderImage),

          new Container(
            margin: new EdgeInsets.only(top: 10.0),
            padding: new EdgeInsets.only(left: 15.0,right: 15.0),
            width: Screen.width,
            height: 68,
            color: Colors.white,
            child: _buildMiddelBar(),
          ),

        ],
      ),
    );
  }
}