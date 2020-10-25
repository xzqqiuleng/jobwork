import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusfield_logreg.dart';
import 'package:recruit_app/viewpages/empye/editinfo_compy.dart';
import 'package:recruit_app/viewpages/homepages/mainhome_recruit.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/loginreg/vercodebtn.dart';
import 'package:recruit_app/viewpages/mine/mine_infor.dart';
import 'package:recruit_app/viewpages/mine/online_resumeinfor.dart';


import '../shareprefer_utils.dart';
import '../storage_manager.dart';
import 'login_pd_page.dart';
import 'myuser.dart';


class PReg extends StatefulWidget{
  int type;
  PReg(this.type);
  @override
  _ForgetState createState() {
    // TODO: implement createState
    return _ForgetState();
  }


}

class _ForgetState extends State<PReg>{
  GlobalKey<VerCodeBtnState> _codeSendKey = new GlobalKey<VerCodeBtnState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _newPdController = TextEditingController();
  TextEditingController _ConfirmPdController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _newPdController.dispose();
    _ConfirmPdController.dispose();

    super.dispose();
  }
  bool isSend = true;
  int send_time = 3;
  delay(){
    Future.delayed(Duration(seconds: 1), (){
      if(send_time == 0){
        isSend = true;
      }else{
          send_time--;
        delay();
      }
    });
  }

  void setNewPd(){
    if(_newPdController.text.length <6 || _ConfirmPdController.text.length<6){
      showToast("密码格式不正确，最低6位数");
    } else if(_newPdController.text != _ConfirmPdController.text){
       showToast("两次密码输入不一致");
    }else if(_codeController.text.length != 6){
      showToast("验证码格式有误，请重新输入");
    }else {
      try{
        if(!isSend){
          showToast("操作过于频繁，请稍后点击！");
          return;
        }
         isSend = false;
        send_time = 3;
        delay();
        Smssdk.commitCode(_phoneController.text,"86",_codeController.text, (dynamic ret, Map err){
          if(err!=null){
            showToast("验证码验证失败");
          }
          else
          {
            PinPinReponse().registerPd(_phoneController.text, _newPdController.text, widget.type).then((value) {
              var reponse = json.decode(value.toString());

              //"result": {
              //        "user_mail": "15671621652",
              //        "type": "1",
              //        "create_time": 1594561222638,
              //        "user_id": "b0fdb885476d46dab13ccc1a82b98070",
              //        "user_name": "15671621652"
              //    },
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
        });
      }catch(e){

      }


    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    body: WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PdLoginPage(widget.type),
            ));
      },
     child: SingleChildScrollView(


        child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20,
                    left: 20,
                    child:IconButton(
                      icon:Icon(Icons.arrow_back,color: Colors.black,) ,
                      iconSize: 30,
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdLoginPage(widget.type),
                            ));
                      },
                    ) ,

                  ),
                  Card(
                      margin: EdgeInsets.only(left: 16,right: 16,top:88),
                      elevation: 0.4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.fromLTRB(16, 16, 16, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.type == 0?"注册为BOSS":"注册为人才",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                            SizedBox(height: 50,),
                            CusFieldLogReg(

                              label: "手机号",
                              controller:  _phoneController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              obscureText: false,

                            ),

                            SizedBox(height: 30,),
                            Stack(
                              children: <Widget>[
                                CusFieldLogReg(

                                  label: "请输入验证码",
                                  controller:  _codeController,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  obscureText: false,

                                ),

                                Positioned(
                                    right: 0,
                                    bottom: 10,
                                    child: GestureDetector(
                                        child: VerCodeBtn(0,key:_codeSendKey),
                                        onTap: (){
                                          _codeSendKey.currentState.clickCode(_phoneController.text);
                                        }
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 30,),
                            CusFieldLogReg(

                              label: "新密码",
                              controller:  _newPdController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              obscureText: true,

                            ),

                            SizedBox(height:30,),
                            CusFieldLogReg(

                              label: "确认密码",
                              controller:  _ConfirmPdController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              obscureText: true,

                            ),

                            SizedBox(height: 30,),
                            GestureDetector(

                                onTap: () => setNewPd(),

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
                                        child:Text("确认",
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
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                  ),



                ],

              )),
    ),
    resizeToAvoidBottomPadding: false,
  );
  }
  
}

