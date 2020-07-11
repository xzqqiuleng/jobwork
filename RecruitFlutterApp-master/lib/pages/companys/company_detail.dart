import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/company_pic_list.dart';
import 'package:recruit_app/model/company_welfare_list.dart';
import 'package:recruit_app/model/job_list.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/companys/company_job_item.dart';
import 'package:recruit_app/pages/companys/company_pic_item.dart';
import 'package:recruit_app/pages/companys/company_welfare_item.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/widgets/bottom_drawer_widget.dart';

class CompanyDetail extends StatefulWidget {
  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  List<WelfareData> _welfareList = WelfareList.loadWelfareList();
  List<CompanyPicData> _picList = CompanyPicList.loadCompanyPicList();

  List<Job> _jobList = JobData.loadJobs();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/bg_wjd_share_init.jpg',
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
                  'images/ic_action_back_white.png',
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
                    'images/ic_action_settings.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {}),
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
                                 child:  Text('腾讯',
                                     maxLines: 1,
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
                                  child: Image.asset(
                                      'images/ic_ask_resume_action.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                left: 76,
                                top: 60,
                                child:Row(
                                  children: <Widget>[
                                    Image.asset('images/company_icon1.png',
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
                                    Image.asset('images/company_icon2.png',
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
                                    Image.asset('images/company_icon3.png',
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
                              Positioned(
                                right: 16,
                                top: 16,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 26,
                                  width: 66,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(20),
                                      color: Colours.app_main

                                  ),
                                  child: Text(
                                    "＋ 关注",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left:16,
                                right: 16,
                                child:  Row(
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
                                              "2222",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(30),
                                                color: Colors.black54,
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
                                      "2",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: Colours.app_main,
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
                                    Image.asset('images/img_arrow_right_blue.png',
                                        width: ScreenUtil().setWidth(10),
                                        height: ScreenUtil().setWidth(20),
                                        fit: BoxFit.cover)
                                  ],
                                ),
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
                            itemCount: _welfareList.length,
                            itemBuilder: (context, index) {
                              if (index < _welfareList.length) {
                                return CompanyWelfareItem(
                                  welfareData: _welfareList[index],
                                  index: index,
                                  isLastItem: index == _welfareList.length - 1,
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
                      Text('公司介绍',
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
                      Text(
                          '深圳市腾讯计算机系统有限公司成立于1998年11月，由马化腾、张志东、许晨晔、陈一丹、曾李青五位创始人共同创立。是中国最大的互联网综合服务提供商之一，也是中国服务用户最多的互联网企业之一。\n腾讯多元化的服务包括：社交和通信服务QQ及微信/WeChat、社交网络平台QQ空间、腾讯游戏旗下QQ游戏平台、门户网站腾讯网、腾讯新闻客户端和网络视频服务腾讯视频等。\n2004年腾讯公司在香港联交所主板公开上市（股票代号00700），董事会主席兼首席执行官是马化腾。',
                          style: const TextStyle(
                              wordSpacing: 2,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Colors.black54)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('公司照片',
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
                      Container(
                        height: 150,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _picList.length,
                            itemBuilder: (context, index) {
                              if (index < _picList.length) {
                                return CompanyPicItem(
                                  picData: _picList[index],
                                  index: index,
                                  isLastItem: index == _picList.length - 1,
                                );
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.asset('images/img_location_example.png',
                            height: 200, fit: BoxFit.cover),
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
                        height: 20,
                      ),
                     ListView.builder(itemBuilder: (BuildContext context,int index){
                       return GsItemwidget();
                     },
                       itemCount: 4,
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics()
                     ),
                      SizedBox(
                        height: 16,
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
                        height: 16,
                      ),
                      CustomBtnWidget(
                        radius: 30,
                        fontSize: 12,
                        text:"查看职位详情",
                        btnColor: Colours.app_main,
                      ),
                      SizedBox(
                        height: 106,
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
                        child: CompanyJobItem(
                            job: _jobList[index],
                            index: index,
                            lastItem: index == _jobList.length - 1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobDetail(),
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('注册时间',
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
              child: Text('2000-02-24',
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