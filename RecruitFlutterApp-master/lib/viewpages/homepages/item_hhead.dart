import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/model_top_banner.dart';
import 'package:recruit_app/viewmodel/midtab_bean.dart';
import 'package:recruit_app/viewpages/jobpages/jobcon/page_alljobs.dart';
import 'package:recruit_app/viewpages/jobpages/jobcon/page_bzjobs.dart';
import 'package:recruit_app/viewpages/jobpages/jobcon/page_jijobs.dart';
import 'package:recruit_app/viewpages/jobpages/locselec_jobs.dart';
import 'package:recruit_app/viewpages/utils/util_resour.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';



import 'item_hbanner.dart';


class ItemHPlan extends StatelessWidget {
  final List<ModelTopBanner> bannerDatas;
  final List<MidTabBean> topicTabMenus;


  final double height;
  final double bannerHeight;
  

  ItemHPlan({Key key,this.bannerDatas,this.bannerHeight,this.topicTabMenus,this.height}):super(key:key);



  Widget _buildMiddelBar(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: topicTabMenus.map((model){

          return  Expanded(
              flex: 1,
              child:GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:(){
                  switch(model.link){
                    case"职位库":
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PageAllJobs()));
                      break;
                    case"找工作":
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => LocSelelcJobs()));
                      break;
                    case"急聘":
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PageJiJobs()));
                      break;
                    case"官方保障":
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PageBzJobs()));
                      break;
                  }


                },
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
      width: ScreenUtils.width,
      height: height,
      color: Color.fromARGB(255, 242, 242, 245),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new ItemHBanner(bannerModels: bannerDatas,height: bannerHeight,placeholder:  globalPlaceHolderImage),

          new Container(
            alignment: Alignment.center,
            margin: new EdgeInsets.only(top: 0.0),
            padding: new EdgeInsets.only(left: 0.0,right: 0.0,bottom: 0,top: 20),
            width: ScreenUtils.width,
            height: 100,
            color: Colors.white,
            child: _buildMiddelBar(context),
          ),

        ],
      ),
    );
  }
}