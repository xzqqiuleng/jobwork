import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/model_top_banner.dart';
import 'package:recruit_app/viewpages/jobpages/jobcon/page_alljobs.dart';
import 'package:recruit_app/viewpages/provider/provider_update.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';
import '../page_norweb.dart';
import 'cusbanner/cust_banner.dart';


class ItemHBanner extends StatelessWidget {
  final List<ModelTopBanner> bannerModels;
  final double height;
  final String placeholder;
  ItemHBanner({Key key,this.bannerModels,this.height,this.placeholder}) :super(key:key);

  @override
  Widget build(BuildContext context) {

    if (bannerModels == null || bannerModels.length == 0) {
      return SizedBox();
    }

    return Container(
      alignment: Alignment.center,
      height: height,
      child: new CustBanner(
        height: height,
        autoPlay: true,
        content: bannerModels.map((model){
          return GestureDetector(
              onTap: (){
                if(model.go_type != null){
                  if(model.go_type == "app"){
                    downloadUrlApp(context,model.link);

                  }else{

                    Navigator.push(context,MaterialPageRoute(builder: (context)=>PageNorweb(model.link)));

                  }
                }else{
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PageAllJobs()));
                }

              },
              behavior: HitTestBehavior.opaque,
             child: Container(
                  width: ScreenUtils.width,
                  margin: new EdgeInsets.symmetric(horizontal: 0.0),
                  child:  model.go_type == null?Image.asset(
                    model.imageUrl,
                    fit: BoxFit.cover,
                  ):Image.network( model.imageUrl,
                    fit: BoxFit.cover,)
              )
          );
        }).toList(),
      )
    );
  }
}