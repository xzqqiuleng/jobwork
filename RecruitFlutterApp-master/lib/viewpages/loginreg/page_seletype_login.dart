import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/viewmodel/model_idenss.dart';
import 'package:recruit_app/viewpages/empye/editinfo_compy.dart';
import 'package:recruit_app/viewpages/homepages/mainhome_recruit.dart';
import 'package:recruit_app/viewpages/message/page_agredetai.dart';
import 'package:recruit_app/viewpages/mine/mine_infor.dart';
import 'package:recruit_app/viewpages/mine/online_resumeinfor.dart';
import '../../colors_utils.dart';
import '../shareprefer_utils.dart';
import '../storage_manager.dart';
import 'myuser.dart';
import 'login_pd_page.dart';

class PageSeleTypeLogin extends StatelessWidget {


  TapGestureRecognizer _tapGestureRecognizer1;
  TapGestureRecognizer _tapGestureRecognizer2;

  void initListen(BuildContext context) {

    _tapGestureRecognizer1 = TapGestureRecognizer();
    _tapGestureRecognizer2 = TapGestureRecognizer();

    _tapGestureRecognizer1.onTap=(){

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageAgreDetail(0),
          ));
    };

    _tapGestureRecognizer2.onTap=(){

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageAgreDetail(1),
          ));
    };
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(!SharepreferUtils.isAgree()){
        _showProtocolDialog(context);

      }

    });
  }

  void _showProtocolDialog(BuildContext context) async{

    await showDialog(context: context,barrierDismissible:false,builder: (BuildContext context){

      return CupertinoAlertDialog(

        title: Text("用户隐私与协议",style: TextStyle(color: ColorsUtils.black_1e211c,fontSize: 17,fontWeight: FontWeight.bold),),
        content:Padding(
          padding:EdgeInsets.only(top: 20),
          child: Text.rich(

            TextSpan(
                children: [
                  TextSpan(

                    text: "欢迎使用APP。在使用本APP前，请细阅所有条款及细则",
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorsUtils.gray_8A8F8A
                    ),
                  ),
                  TextSpan(
                    text:  "服务协议",
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorsUtils.app_main,
                      decoration:TextDecoration.underline,
                    ),
                    recognizer: _tapGestureRecognizer1, //监听器
                  ),
                  TextSpan(
                    text:  "隐私政策",
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorsUtils.app_main,
                      decoration:TextDecoration.underline,
                    ),
                    recognizer: _tapGestureRecognizer2, //监听器
                  ),
                  TextSpan(
                    text: "只有在您同意并接受所有条款和条件后，您才能开始我们的服务。",
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorsUtils.gray_8A8F8A
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
            child: Text( "不同意",style: TextStyle(color: ColorsUtils.gray_C8C7CC,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),

          CupertinoDialogAction(
            child:  Text("同意",style: TextStyle(color: ColorsUtils.app_main,fontSize: 17,fontWeight: FontWeight.bold)),
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
              backgroundImage: AssetImage("images/pp_icon_hc.png"),
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
            child: Consumer<ModelIdenss>(
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

                      bool isBossLogin = SharepreferUtils.isBossLogin();
                      bool isUserLogin = SharepreferUtils.isLogin();
                      if(isUserLogin){
                        MyUser user = SharepreferUtils.getUser();
                        if(user.infoStatus == "1" && user.jlStatus == "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainHomeRecruit(),
                              ));
                        }else if(user.infoStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MineViewInfor(1),
                              ));
                        }else if(user.companyStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnlineResumeInfor(),
                              ));
                        }
                      }else if(isBossLogin){
                        StorageManager.localStorage.deleteItem(SharepreferUtils.BOSSUser);
                        StorageManager.sharedPreferences.setBool(SharepreferUtils.is_BossLogin, false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PdLoginPage(1)),
                        );
                      }else{
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PdLoginPage(1)),
                        );
                      }
                    },
                    textColor: ColorsUtils.app_main,
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
                          color:  ColorsUtils.app_main,
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

                      bool isBossLogin = SharepreferUtils.isBossLogin();
                      bool isUserLogin = SharepreferUtils.isLogin();
                      if(isBossLogin){
                        MyUser user = SharepreferUtils.getBosss();
                        if(user.infoStatus == "1" && user.companyStatus == "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainHomeRecruit(),
                              ));
                        }else if(user.infoStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MineViewInfor(0),
                              ));
                        }else if(user.companyStatus != "1"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditInfoCompy(),
                              ));
                        }
                      }else if(isUserLogin){
                        StorageManager.localStorage.deleteItem(SharepreferUtils.kUser);
                  StorageManager.sharedPreferences.setBool(SharepreferUtils.is_Login, false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PdLoginPage(0)),
                        );

                      }else{
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PdLoginPage(0)),
                        );

                      }
                    },
                    textColor:  ColorsUtils.app_main,
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
                          color:  ColorsUtils.app_main,
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
