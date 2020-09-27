import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';
import 'package:recruit_app/pages/account/register/code_send_btn.dart';

class ChangePhone extends StatefulWidget {
  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  GlobalKey<CodeSendBtnState> _codeSendKey = new GlobalKey<CodeSendBtnState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }
  void changePhone(){

    if(_phoneController.text.length != 11 ){
      showToast("手机格式不正确，最低6位数");
    }else {
      Smssdk.commitCode(_phoneController.text,"86",_codeController.text, (dynamic ret, Map err){
        if(err!=null){
          showToast("验证码验证失败");
        }
        else{
           int type = 0;
           String mail;
          if(ShareHelper.isBossLogin()){
            type = 0;
            mail = ShareHelper.getBosss().userMail;
          }else if(ShareHelper.isLogin()){
            type = 1;
            mail = ShareHelper.getUser().userMail;
          }

          MiviceRepository().changePhone(mail,_phoneController.text,type).then((value) {
            var reponse = json.decode(value.toString());
            if(reponse["status"] == "success") {
              Navigator.of(context).pop();
              showToast("绑定新手机成功");
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
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("绑定新手机",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 16,
              height: 16,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,

      ),
      body:  Container(
        margin: EdgeInsets.all(20),
        child:Column(
          children: [
            SizedBox(height: 20,),
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
                        child: CodeSendBtn(2,key:_codeSendKey),
                        onTap: (){
                          _codeSendKey.currentState.clickCode(_phoneController.text);
                        }
                    )
                )
              ],
            ),
            SizedBox(height: 30,),
            GestureDetector(

                onTap: () => changePhone(),

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
          ],
        )
      ),
    );
  }
}
