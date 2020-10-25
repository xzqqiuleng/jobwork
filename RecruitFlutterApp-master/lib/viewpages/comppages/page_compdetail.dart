import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewmodel/listjobs.dart';
import 'package:recruit_app/viewmodel/picss_comp.dart';
import 'package:recruit_app/viewpages/comppages/welfitem_compy.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/jobpages/page_jobdetail.dart';

import '../cusbtn.dart';
import '../map_nav.dart';
import '../page_jub.dart';
import '../shareprefer_utils.dart';
import '../url_constant.dart';
import 'compy_bean.dart';
import 'item_compjos.dart';
import 'jobs_comp.dart';

class PageCompDetail extends StatefulWidget {
  int id;
  PageCompDetail(this.id);
  @override
  _PageCompDetailState createState() => _PageCompDetailState();
}

class _PageCompDetailState extends State<PageCompDetail> {
  List<CompyPicBean> _picList = PicssCompy.loadCompanyPicList();
  Map infors ;
//  List<String> labels=["五险一金"];
  List<String>tip=["五险一金"];
  List datalist=List() ;
  List<SJobBean> _jobList = ListJobs.loadJobs();
  Map com_label;
  Map compay_info;
  String address="";
  String lat="";
  String lng="";
  List<CompyBean> gsInfos=List();
  int is_collect = 0;

  @override
  void initState() {
    super.initState();



    _loadData();
  }

  _saveByType(int type){
    Map params = Map();
    params["user_mail"] = SharepreferUtils.getUser().userMail;
    params["com_id"] = widget.id;
    params["type"] = type;
    new PinPinReponse().saveCom(params).then((value) {

    });
  }
  _loadData(){

    if(widget.id == null){
      widget.id = 8192;
    }
    new PinPinReponse().getCompanyDetail(widget.id,SharepreferUtils.getUser().userMail).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        var   data = reponse["result"];

        print(data);
        setState(() {
          infors = data["com"];
          is_collect= infors["is_collect"];
          address = infors["address"];
          lat = infors["lat"];
          lng = infors["lng"];
        List  jobList = data["jobs"];
        datalist.clear();
          datalist.addAll(jobList);
          try{
            compay_info = json.decode(infors["company_info"].toString());
          }catch(e){

          }


          if(infors["label"] !=null && infors["label"] != ""){
            com_label = json.decode(infors["label"].toString());
          }

             if( data["tip"]!= null && data["tip"]!= "" ){
               tip = data["tip"].toString().split(" ");
             }


          _getContent();


        });

      }
    });
  }
  void _getContent(){
    gsInfos.clear();
    if(com_label == null){
      return;
    }
    com_label.forEach((key, value) {
 CompyBean gsInfo = CompyBean(key, value);
     gsInfos.add(gsInfo);
     });
    }




  Widget _getInfor(){
    List<Widget> contentWidget=[];
    if(compay_info == null || compay_info == ""){
      return Text("");
    }
    compay_info.forEach((key, value) {

        contentWidget.add( Text(key.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))));
        contentWidget.add(SizedBox(
          height: 8,
        ));
        contentWidget.add(Html(data: value.toString().replaceAll("微信分享", "").replaceAll("地图", "")));
        contentWidget.add(SizedBox(height: 30));
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: contentWidget,
    );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/pp_bg_wjd_share_init.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 30,
              sigmaX: 30,
            ),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          AppBar(
            leading: IconButton(
                icon: Image.asset(
                  'images/pp_ic_action_back_white.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            automaticallyImplyLeading: false,
            centerTitle: true,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Colors.transparent,
            title: Text(
              '公司详情',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Image.asset(
                    is_collect == 1 ?'images/pp_save_yes.png':'images/pp_save_no.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {

                    setState(() {
                      if( is_collect == 1){
                        is_collect = 0;
                        _saveByType(0);
                      }else{
                        is_collect = 1;
                        _saveByType(1);

                      }
                    });

                  }),

              IconButton(
                  icon: Image.asset(
                    'images/pp_ic_action_report_black.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageJub(2,widget.id.toString())));
                  })
            ],
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: kToolbarHeight),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 18, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 1,

                        child: Container(
                          height:160,
                          child: Stack(
                            children: <Widget>[
                               Positioned(
                                 left: 76,
                                 top: 22,
                                 right: 90,
                                 child:  Text( infors == null?"": infors["name"],
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                     style: const TextStyle(
                                         wordSpacing: 1,
                                         letterSpacing: 1,
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.black87)),
                               ),
                              Positioned(
                                left: 16,
                                top: 20,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  child: Image.network(
                                      infors == null|| infors["company_img"].toString() ==""?UrlConstant.deault_compay:infors["company_img"],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                left: 76,
                                top: 80,
                                child:Row(
                                  children: <Widget>[
                                    Image.asset('images/pp_company_icon1.png',
                                        width: ScreenUtil().setWidth(24),
                                        height: ScreenUtil().setWidth(24),
                                        fit: BoxFit.cover),
                                    SizedBox(width: ScreenUtil().setWidth(6)),
                                    Text(
                                      '企业认证',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        color: Color.fromRGBO(151, 151, 151,6),
                                      ),
                                    ),
                                    SizedBox(width: ScreenUtil().setWidth(26)),
                                    Image.asset('images/pp_company_icon2.png',
                                        width: ScreenUtil().setWidth(24),
                                        height: ScreenUtil().setWidth(24),
                                        fit: BoxFit.cover),
                                    SizedBox(width: ScreenUtil().setWidth(6)),
                                    Text(
                                      '绿色保障',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        color: Color.fromRGBO(151, 151, 151, 1),
                                      ),
                                    ),
                                    SizedBox(width: ScreenUtil().setWidth(26)),
                                    Image.asset('images/pp_company_icon3.png',
                                        width: ScreenUtil().setWidth(24),
                                        height: ScreenUtil().setWidth(24),
                                        fit: BoxFit.cover),
                                    SizedBox(width: ScreenUtil().setWidth(6)),
                                    Text(
                                      '极速反馈',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        color: Color.fromRGBO(151, 151, 151, 1),
                                      ),
                                    ),
                                  ],
                                )),
//                              Positioned(
//                                right: 16,
//                                top: 16,
//                                child: Container(
//                                  alignment: Alignment.center,
//                                  height: 26,
//                                  width: 66,
//                                  decoration: BoxDecoration(
//
//                                      borderRadius: BorderRadius.circular(20),
//                                      color: Colours.app_main
//
//                                  ),
//                                  child: Text(
//                                    "＋ 关注",
//                                    style: TextStyle(
//                                      color: Colors.white
//                                    ),
//                                  ),
//                                ),
//                              ),
                              Positioned(
                                bottom: 20,
                                left:16,
                                right: 16,
                                child:  GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => JobsComp(datalist),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              '热招中: ',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(30),
                                                color: Color.fromRGBO(151, 151, 151, 1),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                datalist.length == 0? "暂无招聘职位":datalist[0]["title"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(30),
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(22),
                                      ),
                                      Text(
                                        datalist.length.toString(),
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(32),
                                            color: ColorsUtils.app_main,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        '个岗位',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(30),
                                          color: Color.fromRGBO(151, 151, 151, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(22),
                                      ),
                                      Image.asset('images/pp_img_arrow_right_blue.png',
                                          width: ScreenUtil().setWidth(10),
                                          height: ScreenUtil().setWidth(20),
                                          color: Colors.black87,
                                          fit: BoxFit.cover)
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tip.length,
                            itemBuilder: (context, index) {
                              if (index < tip.length) {
                                return WelfItemCompy(
                                  welfareData: tip[index],
                                  index: index,
                                  isLastItem: index == tip.length - 1,
                                );
                              }
                              return null;
                            }),
                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Expanded(
//                            child: Wrap(
//                                crossAxisAlignment: WrapCrossAlignment.center,
//                                spacing: 20,
//                                runSpacing: 10,
//                                children: <Widget>[
//                                  Text('上午10:00-下午07:00',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                  Text('双休',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                  Text('弹性工作',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                ]),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Text('更多福利',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  wordSpacing: 1,
//                                  letterSpacing: 1,
//                                  fontSize: 14,
//                                  color: Color.fromRGBO(181, 182, 183, 1))),
//                          SizedBox(
//                            width: 8,
//                          ),
//                          Image.asset(
//                            'images/f3_right_arrow_white.png',
//                            width: 10,
//                            height: 10,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      _getInfor(),
//                      Text('公司照片',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black87)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Container(
//                        height: 150,
//                        child: ListView.builder(
//                            physics: BouncingScrollPhysics(),
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                            itemCount: _picList.length,
//                            itemBuilder: (context, index) {
//                              if (index < _picList.length) {
//                                return CompanyPicItem(
//                                  picData: _picList[index],
//                                  index: index,
//                                  isLastItem: index == _picList.length - 1,
//                                );
//                              }
//                              return null;
//                            }),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
                      Text('公司地址',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapNavWeb(address,lat,lng)));
                        },
                        child:  Container(
                          height: 80,
                          child:  Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(2)),
                                  child: Image.asset('images/pp_map_icon.jpg',
                                      height: 100, fit: BoxFit.cover),
                                ),
                              ),

                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                height: 44,
                                margin: EdgeInsets.only(left: 30,right: 30),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('images/pp_loc_address.png',
                                        width: 16,
                                        height: 16, fit: BoxFit.cover),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(

                                      address.length>13?address.substring(0,14):address,

                                    )
                                  ],

                                ),
                              )


                            ],

                          ),
                        ),
                      ),


                      SizedBox(
                        height: 20,
                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text('公司还有9个其他办公地址',
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: const TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Colors.white)),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Text('查看全部',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: const TextStyle(
//                                  wordSpacing: 1,
//                                  letterSpacing: 1,
//                                  fontSize: 14,
//                                  color: Color.fromRGBO(181, 182, 183, 1))),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Text('公司官网',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.white)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text('http://www.tencent.com',
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: const TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Colors.white)),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Image.asset(
//                            'images/f3_right_arrow_white.png',
//                            width: 10,
//                            height: 10,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
                      Text('工商信息',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 30,
                      ),
                     gsInfos.length == 0? Text("暂无信息"):
                     ListView.builder(itemBuilder: (BuildContext context,int index){
                       return GsItemwidget(gsInfos[index]);
                     },
                       itemCount: gsInfos.length,
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics()
                     ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('在招职位',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 8,
                      ),

                      ListView.builder(itemBuilder: (BuildContext context,int index){
                        if(datalist.length ==0 || datalist[index]== null){

                          return Text("");
                        }else{
                          return PositionItem(datalist[index]);
                        }

                      },
                          itemCount: datalist.length >3 ? 3 :datalist.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Cusbtn(
                        radius: 30,
                        fontSize: 12,
                        text:"查看所有职位",
                        btnColor: ColorsUtils.app_main,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobsComp(datalist),
                              ));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
//          BottomDrawerWidget(
//            child: buildJobDrawer(),
//            marginTop: kToolbarHeight,
//            smallHeight: 56,),
        ],
      ),
    );
  }



  Widget buildJobDrawer() {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        margin: EdgeInsets.only(top: kToolbarHeight),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 56,
              alignment: Alignment.centerLeft,
              child: Text('职位',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index < _jobList.length) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: ItemCompJobs(
                            job: _jobList[index],
                            index: index,
                            lastItem: index == _jobList.length - 1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageJobDetail(1),
                              ));
                        });
                  }
                  return null;
                },
                itemCount: _jobList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),);
  }
}
class GsItemwidget extends StatelessWidget{
  CompyBean gsInfo;
  GsItemwidget(this.gsInfo);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(gsInfo.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Colors.black54)),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(gsInfo.txt,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 14,
                      color: Colors.black54)),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

}



class PositionItem extends StatelessWidget{
  Map info;
  PositionItem(this.info);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Text(info["title"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 16,
                    color: Colors.black87)),
            SizedBox(
              height: 12,
            ),
         Text(info["salary"],

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color: ColorsUtils.app_main)),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 4,
          color:Color(0xfff8f8f8),
        ),
      ],
    );
  }

}