import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusfield_logreg.dart';
import 'package:recruit_app/viewpages/empye/editinfo_compy.dart';
import 'package:recruit_app/viewpages/homepages/mainhome_recruit.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/mine/mine_infor.dart';
import 'package:recruit_app/viewpages/mine/online_resumeinfor.dart';
import 'package:recruit_app/viewpages/shareprefer_utils.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';

import '../storage_manager.dart';
import 'myuser.dart';
import 'p_forget.dart';
import 'p_reg.dart';


class PdLoginPage extends StatefulWidget{
  int type;
  PdLoginPage(this.type);
  @override
  _LoginPdState createState() {
    // TODO: implement createState
    return _LoginPdState();
  }


}

class _LoginPdState extends State<PdLoginPage>{
  final _phoneController = TextEditingController();

  final _PdController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
    _PdController.dispose();

    super.dispose();
  }

  void loginPd(){
//    Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(
//          builder: (context) => RecruitHomeApp(),
//        ));
    PinPinReponse().loginPd(_phoneController.text,_PdController.text,widget.type).then((value)  {
      var reponse = json.decode(value.toString());

      if(reponse["status"] == "success") {
        var data = reponse["result"];


        MyUser user = MyUser.fromJson(data);

        if(widget.type == 0){
          StorageManager.localStorage.setItem(SharepreferUtils.BOSSUser, user);
          StorageManager.sharedPreferences.setBool(SharepreferUtils.is_BossLogin, true);
        }else{
          StorageManager.localStorage.setItem(SharepreferUtils.kUser, user);
          StorageManager.sharedPreferences.setBool(SharepreferUtils.is_Login, true);
        }




        if(widget.type == 0){
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
                  builder: (context) => MineViewInfor(widget.type),
                ));
          }else if(user.companyStatus != "1"){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditInfoCompy(),
                ));
          }
        }else{
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
                  builder: (context) => MineViewInfor(widget.type),
                ));
          }else if(user.companyStatus != "1"){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OnlineResumeInfor(),
                ));
          }
        }


      }else{
        showToast(reponse["msg"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Container(

    color:Color(0xfff8f8f8),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
      child:Stack(
                  children: <Widget>[
                    Image.asset("images/pp_bg_use.png",height: 200,width: ScreenUtils.width,fit: BoxFit.fill,),
                    Card(
                        margin: EdgeInsets.only(left: 16,right: 16,top:108),
                        elevation: 0.4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(16, 16, 16, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              SizedBox(
                                height: 16,
                              ),
                              Text(
                               widget.type ==0 ?"BOSS登录":"求职者登录",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(height: 50),
                              CusFieldLogReg(

                                label: "手机号",
                                controller:  _phoneController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.phone,
                                obscureText: false,

                              ),

                              SizedBox(height: 30),
                              CusFieldLogReg(

                                label: "请输入密码",
                                controller:  _PdController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                obscureText: true,
                              ),



                              SizedBox(height: 24),
                              Container(
                                height: 20,
                                child: Stack(

                                  children: <Widget>[

                                    Positioned(
                                        height: 20,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap:()=>   Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PForget(widget.type),
                                              )),
                                          child:Text(
                                            "忘记密码？",
                                            style: TextStyle(

                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.redAccent
                                            ),
                                          ),
                                        )
                                    ),


                                  ],
                                ),
                              ),
                              SizedBox(height:30),
                     GestureDetector(

                        onTap: () => loginPd(),
                          child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                  minHeight : 50,
                                ),
                                child: Card(
                                    color: ColorsUtils.app_main,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Center(
                                      child:Text("登录",
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    )

                                ),
                              )
                     ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                  onTap:()=>    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PReg(widget.type),
                                      )),
                                  child: Text(
                                    "还没有账号，注册一个",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ) ,
                                ),
                              SizedBox(height: 16,),
                            ],
                          ),
                        )
                    ),

                  ],

                )
  );
  }
  
}


