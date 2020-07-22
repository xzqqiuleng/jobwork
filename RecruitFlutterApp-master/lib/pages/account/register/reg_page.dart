import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/account/register/code_send_btn.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/employe/company_edit.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/mine/mine_infor.dart';
import 'package:recruit_app/pages/mine/online_resume.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

import '../../storage_manager.dart';


class RegPage extends StatefulWidget{
  int type;
  RegPage(this.type);
  @override
  _ForgetState createState() {
    // TODO: implement createState
    return _ForgetState();
  }


}

class _ForgetState extends State<RegPage>{
  GlobalKey<CodeSendBtnState> _codeSendKey = new GlobalKey<CodeSendBtnState>();
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

  void setNewPd(){
    if(_newPdController.text.length <6 || _ConfirmPdController.text.length<6){
      showToast("密码格式不正确，最低6位数");
    } else if(_newPdController.text != _ConfirmPdController.text){
       showToast("两次密码输入不一致");
    }else {
      Smssdk.commitCode(_phoneController.text,"86",_codeController.text, (dynamic ret, Map err){
        if(err!=null){
          showToast("验证码验证失败");
        }
        else
        {
          MiviceRepository().registerPd(_phoneController.text, _newPdController.text, widget.type).then((value) {
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


              User user = User.fromJson(data);
              if(widget.type == 0){
                StorageManager.localStorage.setItem(ShareHelper.BOSSUser, user);
                StorageManager.sharedPreferences.setBool(ShareHelper.is_BossLogin, true);
              }else{
                StorageManager.localStorage.setItem(ShareHelper.kUser, user);
                StorageManager.sharedPreferences.setBool(ShareHelper.is_Login, true);
              }




              if(widget.type == 0){
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
                        builder: (context) => MineInfor(widget.type),
                      ));
                }else if(user.companyStatus != "1"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyEdit(),
                      ));
                }
              }else{
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
                        builder: (context) => MineInfor(widget.type),
                      ));
                }else if(user.companyStatus != "1"){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnlineResume(),
                      ));
                }
              }
            }else{
              showToast(reponse["msg"]);
            }
          });

        }
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    body: SingleChildScrollView(


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
                              builder: (context) => LoginPdPage(widget.type),
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
                            LogRegTextField(

                              label: "手机号",
                              controller:  _phoneController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              obscureText: false,

                            ),

                            SizedBox(height: 30,),
                            Stack(
                              children: <Widget>[
                                LogRegTextField(

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
                                        child: CodeSendBtn(key:_codeSendKey),
                                        onTap: (){
                                          _codeSendKey.currentState.clickCode(_phoneController.text);
                                        }
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 30,),
                            LogRegTextField(

                              label: "新密码",
                              controller:  _newPdController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              obscureText: true,

                            ),

                            SizedBox(height:30,),
                            LogRegTextField(

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
                                      color: Colours.app_main,
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

              ),
    ),
    resizeToAvoidBottomPadding: false,
  );
  }
  
}

