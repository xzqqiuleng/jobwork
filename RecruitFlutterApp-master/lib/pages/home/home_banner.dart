import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/pages/jobs/all/joball_page.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'banner/banner.dart';

class HomeBanner extends StatelessWidget {
  final List<BannerModel> bannerModels;
  final double height;
  final String placeholder;
  HomeBanner({Key key,this.bannerModels,this.height,this.placeholder}) :super(key:key);

  @override
  Widget build(BuildContext context) {

    if (bannerModels == null || bannerModels.length == 0) {
      return SizedBox();
    }

    return Container(
      alignment: Alignment.center,
      height: height,
      child: new BannerWidget(
        height: height,
        autoPlay: true,
        content: bannerModels.map((model){
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => JobAllPage()));
              },
              behavior: HitTestBehavior.opaque,
             child: Container(
                  width: Screen.width,
                  margin: new EdgeInsets.symmetric(horizontal: 0.0),
                  child: Image.asset(
                    model.imageUrl,
                    fit: BoxFit.cover,
                  )
              )
          );
        }).toList(),
      )
    );
  }
}