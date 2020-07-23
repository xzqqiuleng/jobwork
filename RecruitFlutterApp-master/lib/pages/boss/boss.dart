import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/model/me_list.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/boss/company_info.dart';
import 'package:recruit_app/pages/boss/job_manage.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/employe/company_edit.dart';
import 'package:recruit_app/pages/jz_no.dart';
import 'package:recruit_app/pages/mine/feedback.dart';
import 'package:recruit_app/pages/mine/mine_infor.dart';
import 'package:recruit_app/pages/mine/push_set.dart';
import 'package:recruit_app/pages/mine/ys_set.dart';
import 'package:recruit_app/pages/msg/agreement.dart';
import 'package:recruit_app/pages/permision_web.dart';
import 'package:recruit_app/pages/setting/new_setting.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/widgets/remind_dialog.dart';

import '../share_helper.dart';

class BossMine extends StatefulWidget {
  @override
  _BossMineState createState() {
    // TODO: implement createState
    return _BossMineState();
  }
}

class _BossMineState extends State<BossMine> {

  List<Me> options=List();


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


  }

  Widget getSmrz(){
    return  GestureDetector(

      onTap: (){

        Navigator.push(context,MaterialPageRoute(builder: (context)=>PermissionWeb(),),);

      },
      child:Card(
        elevation: 2,
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16,
            ),
            Expanded(
                child:  Text(
                  "请先进行实名认证",
                  style: TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w100,
                    color: Colors.white
                  ),
                )
            ),
            Container(
              height: 30,
              width: 70,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(16,6,14,6),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(4),
                  border: new Border.all(color: Colors.white, width: 0.5),
              ),
              child: Text(
                "前去认证",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Colours.app_main,
              child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GestureDetector(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    ShareHelper.getBosss().headImg,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          ShareHelper.getBosss().userName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          ShareHelper.getBosss().mail,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>MineInfor(0),),);
                            },
                            behavior: HitTestBehavior.opaque,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '0',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '已邀请',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JZNo("已邀请")));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,

                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JZNo("已面试")));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '0',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '已面试',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '0',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '已拒绝',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JZNo("已拒绝")));
                                },
                              ),
                            ),
//                            Expanded(
//                              flex: 1,
//                              child: GestureDetector(
//                                behavior: HitTestBehavior.opaque,
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(
//                                      '0',
//                                      maxLines: 1,
//                                      overflow: TextOverflow.ellipsis,
//                                      style: TextStyle(
//                                          color: Colors.white, fontSize: 18),
//                                    ),
//                                    SizedBox(
//                                      height: 5,
//                                    ),
//                                    Text(
//                                      '收藏',
//                                      maxLines: 1,
//                                      overflow: TextOverflow.ellipsis,
//                                      style: TextStyle(
//                                          color: Colors.white70, fontSize: 12),
//                                    ),
//                                  ],
//                                ),
//                                onTap: () {
//
//                                },
//                              ),
//                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
//            SliverAppBar(
//              pinned: true,
//              floating: false,
//              snap: false,
//              expandedHeight: 250.0,
//              title: Text('狐说'),
//              flexibleSpace: FlexibleSpaceBar(
//                  collapseMode: CollapseMode.parallax,
//                  background: SafeArea(
//                    top: true,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Container(
//                          color: Color.fromRGBO(0, 0, 0, 1),
//                          height: 56,
//                        )
//                      ],
//                    ),
//                  )),
//              backgroundColor: Color.fromRGBO(70, 192, 182, 1),
//              elevation: 2.0,
//              forceElevated: true,
//            ),
        SliverToBoxAdapter(
          child: getSmrz(),
        ),
          SliverToBoxAdapter(
            child:Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child:GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>JobManage(),),);
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
                              Image.asset("images/boss1.png",height: 30,width: 30),
                              SizedBox(width: 4,),
                              Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Text(
                                    "职位管理",
                                    style: TextStyle(


                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "发布即上推荐",style: TextStyle(
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
                                  builder: (context) =>  CompanyEdit()));
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
                              Image.asset("images/boss2.png",height: 30,width: 30),
                              SizedBox(width: 4,),
                              Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Text(
                                    "企业管理",
                                    style: TextStyle(


                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "未实名",style: TextStyle(
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

                                  builder: (context) => CompanyInfo()));
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
                              Image.asset("images/boss3.png",height: 30,width: 30),
                              SizedBox(width: 4,),
                              Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Text(
                                    "公司信息",
                                    style: TextStyle(


                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "未完善",style: TextStyle(
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
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              options[index].imgPath,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                options[index].itemName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Color.fromRGBO(39, 40, 41, 1),
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              options[index].itemStatus,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Color.fromRGBO(164, 165, 166, 1),
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              'images/ic_arrow_gray.png',
                              width: 10,
                              height: 10,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
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
                 model.changeIdentity( Identity.employee);
                 StorageManager.localStorage.deleteItem(ShareHelper.BOSSUser);
                 StorageManager.sharedPreferences.setBool(
                     ShareHelper.is_BossLogin, false);
                 Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                         builder: (context) => LoginPdPage(1)));
                 }
                        }
                      },
                    );
                  },
                ),
                Container(
                  color: Color.fromRGBO(245, 246, 246, 1),
                  height: 0.4
                )
              ],
            );
          }, childCount: options.length)),


          SliverToBoxAdapter(
            child: Consumer<IdentityModel>(
                builder: (context, model, child) {
                  return CustomBtnWidget(
                    btnColor: Colours.app_main,
                    text: "切换至求职者",
                    margin: 16,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return RemindDialog(
                              title: '您将切换至求职者身份',
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
                                model.changeIdentity( Identity.employee);
                                StorageManager.localStorage.deleteItem(ShareHelper.BOSSUser);
                                StorageManager.sharedPreferences.setBool(
                                    ShareHelper.is_BossLogin, false);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPdPage(1)));
                              },
                            );
                          });
                    },
                  );
                }) ,
          ),
          SliverToBoxAdapter(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                '客服电话 400-666-6666 工作时间9:30-18:30',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromRGBO(188, 188, 188, 1), fontSize: 12),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
