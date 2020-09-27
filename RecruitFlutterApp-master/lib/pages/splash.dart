import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/account/login/login_type.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/provider/app_update.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/pages/web_page.dart';

import 'account/register/User.dart';
import 'employe/company_edit.dart';
import 'mine/mine_infor.dart';
import 'mine/online_resume.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void _autoTurn() async{
   indes = 0;
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
 Map admap;
   _getBanner(){
    new MiviceRepository().getHomeBaner().then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success") {
        var resdata = reponse["result"];
       print(resdata);
        String open_status = resdata["open_status"].toString();
        StorageManager.sharedPreferences.setString("open_status", open_status);
        List data = resdata["list"];
        List bannStr1 = List();
        List bannStr2 = List();
        List bannStr3 = List();

        for (var itme in data) {

          if (itme["level"].toString() == "one") {  //启动页
            bannStr1.add(itme);
          } else if (itme["level"].toString() == "two") { // 悬浮baner
            bannStr2.add(itme);
          } else if (itme["level"].toString() == "three") {  //首页banner
            bannStr3.add(itme);
          }
        }
        if(bannStr1.length>0 && open_status != "0"){
         setState(() {
           admap = bannStr1[0];
         });

        }
        if(bannStr2.length>0){
          ShareHelper.saveBanner(bannStr2, "two");
        }
        if(bannStr3.length>0){
          ShareHelper.saveBanner(bannStr3, "three");
        }
      }else{

      }
    });
  }
  delay(){
    Future.delayed(Duration(seconds: 1), (){
      if(indes == 1){
        _autoTurn();
      }else{
        setState(() {
          indes--;
        });
        delay();
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    delay();
    _getBanner();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
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
              child: GestureDetector(
                onTap: (){
                  if(admap == null){
                    return;
                  }
                  if(admap["go_type"] == "app"){
                      downloadUrlApp(context,admap["link_url"]);

                  }else{

                      Navigator.push(context,MaterialPageRoute(builder: (context)=>WebPage(admap["link_url"])));

                  }
                },
                child: admap == null? Image.asset("images/start_icon.jpg",fit: BoxFit.fill):Image.network(admap["img_url"],fit: BoxFit.fill),
              )
              ),
                
                  Positioned(
                    top: 30,
                    right: 16,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()=>_autoTurn(),
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

