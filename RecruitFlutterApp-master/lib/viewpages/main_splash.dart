import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/viewmodel/model_idenss.dart';
import 'package:recruit_app/viewpages/page_norweb.dart';
import 'package:recruit_app/viewpages/provider/provider_update.dart';
import 'package:recruit_app/viewpages/shareprefer_utils.dart';
import 'package:recruit_app/viewpages/storage_manager.dart';
import 'empye/editinfo_compy.dart';
import 'homepages/mainhome_recruit.dart';
import 'http/pinpin_response.dart';
import 'loginreg/page_seletype_login.dart';
import 'loginreg/myuser.dart';
import 'mine/mine_infor.dart';
import 'mine/online_resumeinfor.dart';

class MainSplash extends StatefulWidget {
  @override
  _MainSplashState createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {

  void _autoTurn() async{
   indes = 0;
    bool isBossLogin =await SharepreferUtils.isBossLogin();
    bool isUserLogin =await SharepreferUtils.isLogin();
    if(isBossLogin){
      _model.changeIdentity( Identity.boss);
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
      _model.changeIdentity(
          Identity.employee);
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
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PageSeleTypeLogin(),
          ));
    }


  }
  ModelIdenss _model;
  int indes = 3;
 Map admap;
   _getBanner(){
    new PinPinReponse().getHomeBaner().then((value) {
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
        if(bannStr2.length>0){
          SharepreferUtils.saveBanner(bannStr2, "two");
        }
        if(bannStr3.length>0){
          SharepreferUtils.saveBanner(bannStr3, "three");
        }
        if(bannStr1.length>0 && open_status != "0"){
         setState(() {
           admap = bannStr1[0];
           isSHow = false;
         });

        }else{
          _autoTurn();
        }

      }else{
             _autoTurn();
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
    _getBanner();
    delay();

  }
  bool isSHow = true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
        body:  Consumer<ModelIdenss>(
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

                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PageNorweb(admap["link_url"])));

                  }
                },
                child: admap == null? Image.asset("images/pp_start_icon.jpg",fit: BoxFit.fill):Image.network(admap["img_url"],fit: BoxFit.fill),
              )
              ),
                
                  Positioned(
                    top: 30,
                    right: 16,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()=>_autoTurn(),
                      child:Offstage(
                        offstage: isSHow,
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
                )
                    ),
                  )
                ],

              );
            }

        )
    );
  }
}

