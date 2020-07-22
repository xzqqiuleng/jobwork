import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/account/login/login_in.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/employe/company_edit.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/mine/mine_infor.dart';
import 'package:recruit_app/pages/mine/online_resume.dart';
import 'package:recruit_app/pages/msg/agreement_detail.dart';
import 'package:recruit_app/pages/permision_web.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';

import '../../../colours.dart';

class LoginType extends StatelessWidget {


  TapGestureRecognizer _tapGestureRecognizer1;
  TapGestureRecognizer _tapGestureRecognizer2;

  void initListen(BuildContext context) {

    _tapGestureRecognizer1 = TapGestureRecognizer();
    _tapGestureRecognizer2 = TapGestureRecognizer();

    _tapGestureRecognizer1.onTap=(){

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgreementDetailPage(0),
          ));
    };

    _tapGestureRecognizer2.onTap=(){

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgreementDetailPage(1),
          ));
    };
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(!ShareHelper.isAgree()){
        _showProtocolDialog(context);

      }

    });
  }

  void _showProtocolDialog(BuildContext context) async{

    await showDialog(context: context,barrierDismissible:false,builder: (BuildContext context){

      return CupertinoAlertDialog(

        title: Text("用户隐私与协议",style: TextStyle(color: Colours.black_1e211c,fontSize: 17,fontWeight: FontWeight.bold),),
        content:Padding(
          padding:EdgeInsets.only(top: 20),
          child: Text.rich(

            TextSpan(
                children: [
                  TextSpan(

                    text: "欢迎使用APP。在使用本APP前，请细阅所有条款及细则",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colours.gray_8A8F8A
                    ),
                  ),
                  TextSpan(
                    text:  "服务协议",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colours.app_main,
                      decoration:TextDecoration.underline,
                    ),
                    recognizer: _tapGestureRecognizer1, //监听器
                  ),
                  TextSpan(
                    text:  "隐私政策",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colours.app_main,
                      decoration:TextDecoration.underline,
                    ),
                    recognizer: _tapGestureRecognizer2, //监听器
                  ),
                  TextSpan(
                    text: "只有在您同意并接受所有条款和条件后，您才能开始我们的服务。",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colours.gray_8A8F8A
                    ),
                    recognizer: _tapGestureRecognizer2,
                  )
                ]
            ),
            textAlign: TextAlign.justify,

          ),
        ),
        actions:<Widget>[

          CupertinoDialogAction(
            child: Text( "不同意",style: TextStyle(color: Colours.gray_C8C7CC,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),

          CupertinoDialogAction(
            child:  Text("同意",style: TextStyle(color: Colours.app_main,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){

              Navigator.of(context).pop();
              StorageManager.sharedPreferences.setBool("is_agree", true);
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.init(context, width: 750, height: 1334);
    initListen(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 255, 254, 1),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: ScreenUtil().setWidth(360),
            child:  CircleAvatar(
              backgroundImage: AssetImage("images/icon_hc.png"),
              radius: 60,
            )
//            child: Image.asset(
//              'images/icon_hc.png',
//              width: ScreenUtil().setWidth(180),
//              height: ScreenUtil().setWidth(180),
//              fit: BoxFit.contain,
//            ),
          ),
          Positioned(
            bottom: ScreenUtil().setWidth(358),
            child: Text(
              '',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(44),
                color: Color.fromRGBO(84, 128, 194, 1),
              ),
            ),
          ),
          Positioned(
            bottom: ScreenUtil().setWidth(226),
            child: Consumer<IdentityModel>(
            builder: (context, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    elevation: 1,
                    color: Colors.white,
                    onPressed: () {
                      model.changeIdentity(
                          Identity.employee);

                      bool isBossLogin = ShareHelper.isBossLogin();
                      bool isUserLogin = ShareHelper.isLogin();
                      if(isUserLogin){
                        User user = ShareHelper.getUser();
                        if(user.infoStatus == "1" && user.jlStatus == "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecruitHomeApp(),
                              ));
                        }else if(user.infoStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MineInfor(1),
                              ));
                        }else if(user.companyStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnlineResume(),
                              ));
                        }
                      }else if(isBossLogin){
                        StorageManager.localStorage.deleteItem(ShareHelper.BOSSUser);
                        StorageManager.sharedPreferences.setBool(ShareHelper.is_BossLogin, false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPdPage(1)),
                        );
                      }else{
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPdPage(1)),
                        );
                      }
                    },
                    textColor: Colours.app_main,
                    child: Text(
                      "我是求职者",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(44),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(70),
                      vertical: ScreenUtil().setWidth(14),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color:  Colours.app_main,
                          width: ScreenUtil().setWidth(2),
                        ),
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(1000))),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(64),
                  ),
                  MaterialButton(
                    elevation: 1,
                    color: Colors.white,
                    onPressed: () {
                      model.changeIdentity( Identity.boss);

                      bool isBossLogin = ShareHelper.isBossLogin();
                      bool isUserLogin = ShareHelper.isLogin();
                      if(isBossLogin){
                        User user = ShareHelper.getBosss();
                        if(user.infoStatus == "1" && user.companyStatus == "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecruitHomeApp(),
                              ));
                        }else if(user.infoStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MineInfor(0),
                              ));
                        }else if(user.companyStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompanyEdit(),
                              ));
                        }
                      }else if(isUserLogin){
                        StorageManager.localStorage.deleteItem(ShareHelper.kUser);
                  StorageManager.sharedPreferences.setBool(ShareHelper.is_Login, false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPdPage(0)),
                        );

                      }else{
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPdPage(0)),
                        );

                      }
                    },
                    textColor:  Colours.app_main,
                    child: Text(
                      "我是BOSS",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(44),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(70),
                      vertical: ScreenUtil().setWidth(14),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color:  Colours.app_main,
                          width: ScreenUtil().setWidth(2),
                        ),
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(1000))),
                  ),
                ],
              );
                }
            ),
          ),
        ],
      ),
    );
  }
}
