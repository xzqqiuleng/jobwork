import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/JobPage.dart';
import 'package:recruit_app/pages/jobs/all/job_libsboard.dart';
import 'package:recruit_app/pages/jobs/all/joball_page.dart';
import 'package:recruit_app/pages/utils/resource.dart';
import 'package:recruit_app/pages/utils/screen.dart';


import 'home_banner.dart';


class HomeHeadPlan extends StatelessWidget {
  final List<BannerModel> bannerDatas;
  final List<TopicTabModel> topicTabMenus;


  final double height;
  final double bannerHeight;
  

  HomeHeadPlan({Key key,this.bannerDatas,this.bannerHeight,this.topicTabMenus,this.height}):super(key:key);



  Widget _buildMiddelBar(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: topicTabMenus.map((model){
          return  Expanded(
              flex: 1,
              child:GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:()=>  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => JobAllPage())),
                child:new Column(
                children: [
                Image(
        width: 50,
        height: 50,
        image: AssetImage(model.picture),
        ),
        SizedBox(
        height: 5,
        ),
        Text(
        model.link,
        style: TextStyle(
        fontWeight: FontWeight.w500
        ),
        )
        ],
        )
        )
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
            alignment: Alignment.center,
            margin: new EdgeInsets.only(top: 0.0),
            padding: new EdgeInsets.only(left: 0.0,right: 0.0,bottom: 0,top: 20),
            width: Screen.width,
            height: 100,
            color: Colors.white,
            child: _buildMiddelBar(context),
          ),

        ],
      ),
    );
  }
}