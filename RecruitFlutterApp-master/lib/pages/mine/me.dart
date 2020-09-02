import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/model/me_list.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/jz_no.dart';
import 'package:recruit_app/pages/mine/comunicate.dart';
import 'package:recruit_app/pages/mine/focus_company_list.dart';
import 'package:recruit_app/pages/mine/job_intent.dart';
import 'package:recruit_app/pages/mine/mine_infor.dart';
import 'package:recruit_app/pages/mine/online_resume.dart';
import 'package:recruit_app/pages/mine/push_set.dart';
import 'package:recruit_app/pages/mine/send_resume.dart';
import 'package:recruit_app/pages/mine/ys_set.dart';
import 'package:recruit_app/pages/msg/agreement.dart';
import 'package:recruit_app/pages/save_job.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/setting/new_setting.dart';
import 'package:recruit_app/pages/setting/setting.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/pages/utils/cashfile_utils.dart';
import 'package:recruit_app/widgets/kf_dialog.dart';
import 'package:recruit_app/widgets/progress_dialog.dart';
import 'package:recruit_app/widgets/remind_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../permision_web.dart';
import '../share_helper.dart';
import 'feedback.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() {
    // TODO: implement createState
    return _MineState();
  }
}

class _MineState extends State<Mine> {
  List<Me> options=List();

  List save;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    options.add( Me(imgPath: 'images/me6.png', itemName: '隐私设置', itemStatus: ''));
    options.add( Me(imgPath: 'images/me1.png', itemName: '通知提醒', itemStatus: ''));
    options.add( Me(imgPath: 'images/me2.png', itemName: '意见反馈', itemStatus: ''));
    options.add( Me(imgPath: 'images/me3.png', itemName: '给个好评', itemStatus: ''));
    options.add( Me(imgPath: 'images/me4.png', itemName: '用户隐私协议', itemStatus: ''));
    options.add( Me(imgPath: 'images/me5.png', itemName: '设置', itemStatus: ''));

    String jsonStr=    StorageManager.sharedPreferences.getString(ShareHelper.getUser().userId+"work");
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
  params["user_mail"] = ShareHelper.getUser().userMail;
  params["class"] = 1;
    new MiviceRepository().getJodSaveListByType(params).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){

        setState(() {
          List data = reponse["result"];
          num1= data.length;
        });

      }
    });

  params["class"] = 2;
  new MiviceRepository().getJodSaveListByType(params).then((value) {
    var reponse = json.decode(value.toString());
    if(reponse["status"] == "success"){

      setState(() {
        List data = reponse["result"];
        num2= data.length;
      });

    }
  });

  params["class"] = 0;
  new MiviceRepository().getJodSaveListByType(params).then((value) {
    var reponse = json.decode(value.toString());
    if(reponse["status"] == "success"){

      setState(() {
        List data = reponse["result"];
        num3= data.length;
      });

    }
  });
  new MiviceRepository().getComList(params).then((value) {
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
                'images/kf.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return KFDialog();
                        },
                      );

              }),
        ],
        backgroundColor: Colours.app_main,
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
              color:  Colours.app_main,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>MineInfor(1),),);
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
                            ShareHelper.getUser().headImg,
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
                             ShareHelper.getUser().userName,
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
    builder: (context) => OnlineResume()));

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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>JZNo("浏览过"),),);

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
                          onTap: () {    Navigator.push(context,MaterialPageRoute(builder: (context)=>JZNo("已沟通"),),);},
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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>JZNo("已收藏"),),);
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SaveJob(),),);
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
                                 Image.asset("images/mine1.png",height: 30,width: 30),
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
                                  builder: (context) => JobIntent()));
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
                              Image.asset("images/mine2.png",height: 30,width: 30),
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
                                   ShareHelper.getUser().resumeStatus==null?"离职-找工作": ShareHelper.getUser().resumeStatus,style: TextStyle(
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
                                  builder: (context) => OnlineResume()));
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
                              Image.asset("images/mine3.png",height: 30,width: 30),
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
                Consumer<IdentityModel>(
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
                              'images/img_arrow_right_blue.png',
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
                                  builder: (context) => YsSetPage()));
                        }
                        else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PushSetPage()));
                        } else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedbackPage()));
                        } else if (index == 3) {
                          LaunchReview.launch(androidAppId: "com.shuibian.jobwork");
                        }else if(index == 4){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AgreementPage()));
                        }else if(index == 5){
                       bool result =await   Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewSetting()));
                       if(result != null && result){

                         model.changeIdentity( Identity.boss);
                         StorageManager.localStorage.deleteItem(ShareHelper.kUser);
                         StorageManager.sharedPreferences.setBool(
                             ShareHelper.is_Login, false);
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => LoginPdPage(0)));
                       }
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
            child: Consumer<IdentityModel>(
    builder: (context, model, child) {
      return CustomBtnWidget(
        btnColor: Colours.app_main,
        text: "切换至BOSS身份",
        margin: 16,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) {
                return RemindDialog(
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
                    StorageManager.localStorage.deleteItem(ShareHelper.kUser);
                    StorageManager.sharedPreferences.setBool(
                        ShareHelper.is_Login, false);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPdPage(0)));
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
