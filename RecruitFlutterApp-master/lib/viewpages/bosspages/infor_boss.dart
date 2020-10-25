import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusdialog_kf.dart';
import 'package:recruit_app/cuswidget/cusdialog_remind.dart';
import 'package:recruit_app/viewmodel/listdata_me.dart';
import 'package:recruit_app/viewmodel/model_idenss.dart';
import 'package:recruit_app/viewpages/bosspages/page_jobmange.dart';
import 'package:recruit_app/viewpages/empye/editinfo_compy.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/loginreg/login_pd_page.dart';
import 'package:recruit_app/viewpages/message/page_agre.dart';
import 'package:recruit_app/viewpages/mine/m_pushset.dart';
import 'package:recruit_app/viewpages/mine/mine_infor.dart';
import 'package:recruit_app/viewpages/mine/mpage_feed.dart';
import 'package:recruit_app/viewpages/mine/mset_yinsi.dart';
import 'package:recruit_app/viewpages/setting/new_sets.dart';
import '../cusbtn.dart';
import '../page_findzs.dart';
import '../page_permweb.dart';
import '../page_saveresumes.dart';
import '../shareprefer_utils.dart';
import '../storage_manager.dart';
import 'infor_comp.dart';

class InforBoss extends StatefulWidget {
  @override
  _InforBossState createState() {
    // TODO: implement createState
    return _InforBossState();
  }
}

class _InforBossState extends State<InforBoss> {

  List<MineBean> options=List();

  int num1 = 0;
  int num2 = 0;
  int num3 = 0;
  void getNUms(){
    Map params = Map();
    params["user_mail"] = SharepreferUtils.getBosss().userMail;
    params["class"] = 1;
    new PinPinReponse().getResumeSaveListByType(params).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){

        setState(() {
          List data = reponse["result"];
          num1= data.length;
        });

      }
    });

    params["class"] = 2;
    new PinPinReponse().getResumeSaveListByType(params).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){

        setState(() {
          List data = reponse["result"];
          num2= data.length;
        });

      }
    });

    params["class"] = 0;
    new PinPinReponse().getResumeSaveListByType(params).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){

        setState(() {
          List data = reponse["result"];
          num3= data.length;
        });

      }
    });

  }
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
getNUms();

  }

  Widget getSmrz(){
      if(SharepreferUtils.getBosss().realStatus == "1") {
      return Container();
    }else{

      return GestureDetector(

        onTap: () async{

        bool isRefresh =  await Navigator.push(context,MaterialPageRoute(builder: (context)=>PagePermWeb(),),);
        if(isRefresh != null && isRefresh){
          setState(() {

          });
        }

        },
        child:Card(
          elevation: 2,
          color: Colors.redAccent,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
//        ),
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
                        fontWeight: FontWeight.bold,
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
      );}

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
              color: ColorsUtils.app_main,
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
                                    SharepreferUtils.getBosss().headImg,
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
                                          SharepreferUtils.getBosss().userName,
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
                                          SharepreferUtils.getBosss().mail,
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
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>MineViewInfor(0),),);
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
                                        num1.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '浏览过',
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
                                              PageSaveResumes("浏览过")));
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
                                              PageSaveResumes("已沟通")));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                     num2.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '已沟通',
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
                                     num3.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '已收藏',
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
                                              PageSaveResumes("已收藏")));
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>PageJobManage(),),);
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
                              Image.asset("images/pp_boss1.png",height: 30,width: 30),
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
                                  builder: (context) =>  EditInfoCompy()));
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
                              Image.asset("images/pp_boss2.png",height: 30,width: 30),
                              SizedBox(width: 4,),
                              Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Text(
                                    "企业认证",
                                    style: TextStyle(


                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "实名认证",style: TextStyle(
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

                                  builder: (context) => InforComp()));
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
                              Image.asset("images/pp_boss3.png",height: 30,width: 30),
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
                                    "完善信息",style: TextStyle(
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
                              'images/pp_ic_arrow_gray.png',
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
                 model.changeIdentity( Identity.boss);
                 StorageManager.localStorage.deleteItem(SharepreferUtils.BOSSUser);
                 StorageManager.sharedPreferences.setBool(
                     SharepreferUtils.is_BossLogin, false);
                 Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                         builder: (context) => PdLoginPage(0)));
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
                  color: Color.fromRGBO(245, 246, 246, 1),
                  height: 0.4
                )
              ],
            );
          }, childCount: options.length)),

    SliverToBoxAdapter(
    child: SizedBox(height: 20,),
    ),
          SliverToBoxAdapter(
            child: Consumer<ModelIdenss>(
                builder: (context, model, child) {
                  return Cusbtn(
                    btnColor: ColorsUtils.app_main,
                    text: "切换至求职者",
                    margin: 16,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustDialogRemind(
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
                                StorageManager.localStorage.deleteItem(SharepreferUtils.BOSSUser);
                                StorageManager.sharedPreferences.setBool(
                                    SharepreferUtils.is_BossLogin, false);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PdLoginPage(1)));
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
             '',
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
