import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/account/register/forget_page.dart';
import 'package:recruit_app/pages/account/register/reg_page.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class LoginPdPage extends StatefulWidget{

  @override
  _LoginPdState createState() {
    // TODO: implement createState
    return _LoginPdState();
  }


}

class _LoginPdState extends State<LoginPdPage>{
  final _phoneController = TextEditingController();

  final _PdController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
    _PdController.dispose();

    super.dispose();
  }

  void loginPd(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RecruitHomeApp(),
        ));
//    MiviceRepository().loginPd(_phoneController.text,_PdController.text,0).then((value)  {
//      var reponse = json.decode(value.toString());
//
//      if(reponse["status"] == "success") {
//        var data = reponse["result"];
//
//
//        User user = User.fromJson(data);
//        StorageManager.localStorage.setItem(ShareHelper.kUser, user);
//        StorageManager.sharedPreferences.setBool(ShareHelper.is_Login, true);
//        Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//              builder: (context) => RecruitHomeApp(),
//            ));
//      }else{
//        showToast(reponse["msg"]);
//      }
//    });
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
                    Card(
                        margin: EdgeInsets.only(left: 16,right: 16,top:58),
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(16, 16, 16, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Card(
                                shadowColor: Color(0xdd242424),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Image(image: AssetImage("images/icon_hc.png"),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              SizedBox(height: 50),
                              LogRegTextField(

                                label: "手机号",
                                controller:  _phoneController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.phone,
                                obscureText: false,

                              ),

                              SizedBox(height: 30),
                              LogRegTextField(

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
                                      left: 0,
                                      child: GestureDetector(
                                        onTap:()=>  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => RegPage(),
                                            )),
                                        child: Text(
                                          "注册账号",
                                          style: TextStyle(

                                              fontSize: 13,
                                              color: Colours.gray_8A8F8A
                                          ),
                                        ) ,
                                      ),
                                    ),
                                    Positioned(
                                        height: 20,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap:()=>   Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ForgetPage(),
                                              )),
                                          child:Text(
                                            "忘记密码？",
                                            style: TextStyle(

                                                fontSize: 13,
                                                color: Colours.app_main
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
                                    color: Colours.app_main,
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
                     )
                            ],
                          ),
                        )
                    ),

                  ],

                )
  );
  }
  
}


