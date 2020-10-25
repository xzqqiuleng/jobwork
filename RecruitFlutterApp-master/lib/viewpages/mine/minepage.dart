import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusdialog_kf.dart';
import 'package:recruit_app/cuswidget/cusdialog_remind.dart';
import 'package:recruit_app/viewmodel/listdata_me.dart';
import 'package:recruit_app/viewmodel/model_idenss.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/loginreg/login_pd_page.dart';
import 'package:recruit_app/viewpages/message/page_agre.dart';
import 'package:recruit_app/viewpages/setting/new_sets.dart';
import '../cusbtn.dart';
import '../page_jobsave.dart';
import '../page_nojz.dart';
import '../shareprefer_utils.dart';
import '../page_findzs.dart';
import '../storage_manager.dart';
import 'm_pushset.dart';
import 'mine_infor.dart';
import 'mintent_jobs.dart';
import 'mpage_feed.dart';
import 'mset_yinsi.dart';
import 'online_resumeinfor.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() {
    // TODO: implement createState
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  List<MineBean> options=List();

  List save;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    options.add( MineBean(imgPath: 'images/pp_me6.png', itemName: '隐私设置', itemStatus: ''));
    options.add( MineBean(imgPath: 'images/pp_me1.png', itemName: '通知提醒', itemStatus: ''));
    options.add( MineBean(imgPath: 'images/pp_me2.png', itemName: '意见反馈', itemStatus: ''));
    options.add( MineBean(imgPath: 'images/pp_me3.png', itemName: '给个好评', itemStatus: ''));
    options.add( MineBean(imgPath: 'images/pp_me4.png', itemName: '用户隐私协议', itemStatus: ''));
    options.add( MineBean(imgPath: 'images/pp_me5.png', itemName: '设置', itemStatus: ''));
    options.add( MineBean(imgPath: 'images/pp_hz.png', itemName: '福利招商', itemStatus: ''));
    String jsonStr=    StorageManager.sharedPreferences.getString(SharepreferUtils.getUser().userId+"work");
   if(jsonStr !=null &&jsonStr!="" ){
     save =  json.decode(jsonStr);
   }
    getNUms();
  }
 int num1 = 0;
 int num2 = 0;
 int num3 = 0;
 int num = 0;
void getNUms(){
  Map params = Map();
  params["user_mail"] = SharepreferUtils.getUser().userMail;
  params["class"] = 1;
    new PinPinReponse().getJodSaveListByType(params).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){

        setState(() {
          List data = reponse["result"];
          num1= data.length;
        });

      }
    });

  params["class"] = 2;
  new PinPinReponse().getJodSaveListByType(params).then((value) {
    var reponse = json.decode(value.toString());
    if(reponse["status"] == "success"){

      setState(() {
        List data = reponse["result"];
        num2= data.length;
      });

    }
  });

  params["class"] = 0;
  new PinPinReponse().getJodSaveListByType(params).then((value) {
    var reponse = json.decode(value.toString());
    if(reponse["status"] == "success"){

      setState(() {
        List data = reponse["result"];
        num3= data.length;
      });

    }
  });
  new PinPinReponse().getComList(params).then((value) {
    var reponse = json.decode(value.toString());
    if(reponse["status"] == "success"){


      setState(() {
        List data = reponse["result"];
        num= data.length;
      });

    }
  });
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/pp_kf.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustDialogKF();
                        },
                      );

              }),
        ],
        backgroundColor: ColorsUtils.app_main,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(

            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(48),
                  right: ScreenUtil().setWidth(48),
                  bottom: ScreenUtil().setWidth(48),
                  top: ScreenUtil().setWidth(30)),
              color:  ColorsUtils.app_main,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>MineViewInfor(1),),);
                    },
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(70),
                          ),
                          child: Image.network(
                            SharepreferUtils.getUser().headImg,
                            width: ScreenUtil().setWidth(140),
                            height: ScreenUtil().setWidth(140),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(30),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text(
                             SharepreferUtils.getUser().userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(40),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: ScreenUtil().setWidth(10),
                            ),
                            GestureDetector(
                              child:    Text(
                                "在线编辑简历",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(30),
                                ),
                              ),
                              onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => OnlineResumeInfor()));

                              },
                            )


                          ],

                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: ScreenUtil().setWidth(76),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            children: <Widget>[
                              Text(
                                num1.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(36),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '浏览过',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color.fromRGBO(227, 226, 226, 1),
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),

                            ],
                          ),
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>PageNoJz("浏览过"),),);

                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                        ),
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setHeight(28),
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                               num2.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(36),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '已沟通',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color.fromRGBO(227, 226, 226, 1),
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {    Navigator.push(context,MaterialPageRoute(builder: (context)=>PageNoJz("已沟通"),),);},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                        ),
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setHeight(28),
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                num3.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(36),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '已收藏',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color.fromRGBO(227, 226, 226, 1),
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>PageNoJz("已收藏"),),);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(

            child:Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child:GestureDetector(
                      onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>PageJobSave(),),);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Card(
                        elevation: 2,
                             shape:RoundedRectangleBorder(
                               borderRadius:BorderRadius.circular(2)
                             ),
                             child: Row(
                               children: <Widget>[
                                 SizedBox(width: 8,),
                                 Image.asset("images/pp_mine1.png",height: 30,width: 30),
                                 SizedBox(width: 4,),
                                 Column(

                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     SizedBox(height: 16),
                                     Text(
                                       "公司收藏",
                                       style: TextStyle(


                                       ),
                                     ),
                                     SizedBox(
                                       height: 7,
                                     ),
                                     Text(
                                       "${num}个",style: TextStyle(
                                         color: Colors.grey,
                                         fontSize: 10,
                                         fontWeight: FontWeight.w100
                                     ),
                                     ),
                                     SizedBox(height: 16),
                                   ],
                                 ),
                               ],
                             ),
                             )
                    )
                ),    Expanded(
                    flex: 1,
                    child:GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MineJobsIntent()));
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Card(
                          elevation: 2,
                          shape:RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(2)
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 4,),
                              Image.asset("images/pp_mine2.png",height: 30,width: 30),
                              SizedBox(width: 4,),
                              Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Text(
                                    "求职意向",
                                    style: TextStyle(


                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                   SharepreferUtils.getUser().resumeStatus==null?"离职-找工作": SharepreferUtils.getUser().resumeStatus,style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w100
                                  ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ],
                          ),
                        )
                    )
                ),
                Expanded(
                    flex: 1,
                    child:GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnlineResumeInfor()));
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Card(
                          elevation: 2,
                          shape:RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(2)
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 4,),
                              Image.asset("images/pp_mine3.png",height: 30,width: 30),
                              SizedBox(width: 4,),
                              Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Text(
                                    "在线简历",
                                    style: TextStyle(


                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "已编辑",style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w100
                                  ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ],
                          ),
                        )
                    )
                ),
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<ModelIdenss>(
                  builder: (context, model, child) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(48),
                          vertical: ScreenUtil().setWidth(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              options[index].imgPath,
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setWidth(40),
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(20),
                            ),
                            Expanded(
                              child: Text(
                                options[index].itemName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Color.fromRGBO(57, 57, 57, 1),
                                    fontSize: ScreenUtil().setSp(32)),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(20),
                            ),
                            Text(
                              options[index].itemStatus,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Color.fromRGBO(194, 203, 202, 1),
                                fontSize: ScreenUtil().setSp(24),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(20),
                            ),
                            Image.asset(
                              'images/pp_img_arrow_right_blue.png',
                              width: ScreenUtil().setWidth(10),
                              height: ScreenUtil().setWidth(20),
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      onTap: () async{
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MSetYinsi()));
                        }
                        else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MPushSet()));
                        } else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MPageFeed()));
                        } else if (index == 3) {
                          LaunchReview.launch(androidAppId: "com.pinpin.jobwork");
                        }else if(index == 4){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageAgre()));
                        }else if(index == 5){
                       bool result =await   Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewSets()));
                       if(result != null && result){

                         model.changeIdentity( Identity.employee);
                         StorageManager.localStorage.deleteItem(SharepreferUtils.kUser);
                         StorageManager.sharedPreferences.setBool(
                             SharepreferUtils.is_Login, false);
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => PdLoginPage(1)));
                       }
                        }else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageFindZs()));
                        }
                      },
                    );
                  },
                ),
                Container(
                  color: Colors.grey,
                  height:  ScreenUtil().setWidth(0.2)

                )
              ],
            );
          }, childCount: options.length)),
          SliverToBoxAdapter(
            child: Container(
              margin:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(48)),
              height: ScreenUtil().setWidth(50),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<ModelIdenss>(
    builder: (context, model, child) {
      return Cusbtn(
        btnColor: ColorsUtils.app_main,
        text: "切换至BOSS身份",
        margin: 16,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) {
                return CustDialogRemind(
                  title: '您将切换至BOSS身份',
                  titleColor: Color.fromRGBO(57, 57, 57, 1),
                  content: '系统将为您切换对应功能',
                  contentColor: Color.fromRGBO(57, 57, 57, 1),
                  cancelText: '取消',
                  cancelColor: Color.fromRGBO(142, 190, 245, 1),
                  confirmText: '确定',
                  confirmColor: Color.fromRGBO(142, 190, 245, 1),
                  cancel: (){
                    Navigator.pop(context);
                  },
                  confirm: (){
                    model.changeIdentity( Identity.boss);
                    StorageManager.localStorage.deleteItem(SharepreferUtils.kUser);
                    StorageManager.sharedPreferences.setBool(
                        SharepreferUtils.is_Login, false);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdLoginPage(0)));
                  },
                );
              });
        },
      );
    }) ,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(48)),
              height: ScreenUtil().setWidth(50),
            ),
          ),
        ],
      ),
    );
  }
}
