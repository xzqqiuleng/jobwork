import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/account/login/login_type.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/share_helper.dart';

import 'account/register/User.dart';
import 'employe/company_edit.dart';
import 'mine/mine_infor.dart';
import 'mine/online_resume.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void _autoTurn(BuildContext context) async{

    bool isBossLogin =await ShareHelper.isBossLogin();
    bool isUserLogin =await ShareHelper.isLogin();
    if(isBossLogin){
      _model.changeIdentity( Identity.boss);
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
      _model.changeIdentity(
          Identity.employee);
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
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginType(),
          ));
    }


  }
  IdentityModel _model;
  int indes = 3;

  delay(BuildContext context){
    Future.delayed(Duration(seconds: 1), (){
      if(indes == 0){
        _autoTurn(context);
      }else{
        setState(() {
          indes--;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    delay(context);
    return Scaffold(
        body:  Consumer<IdentityModel>(
            builder: (context, model, child) {
              _model = model;
              return Stack(
                children: [
              Positioned(
                left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child:   Image.asset("images/start_icon.jpg",width: 100,height:400,fit: BoxFit.fill,),
              ),
                
                  Positioned(
                    top: 30,
                    right: 16,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()=>_autoTurn(context),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10,4,10,4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12
                        ),
                        child: Text(
                          "${indes}s |  跳过",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
                ],

              );
            }

        )
    );
  }
}

