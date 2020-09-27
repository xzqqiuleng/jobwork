import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/code_send_btn.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class ForgetPage extends StatefulWidget{
  int type;
  ForgetPage(this.type);
  @override
  _ForgetState createState() {
    // TODO: implement createState
    return _ForgetState();
  }


}

class _ForgetState extends State<ForgetPage>{
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
        else{

      MiviceRepository().forgetPd(_phoneController.text, _newPdController.text,widget.type).then((value) {
        var reponse = json.decode(value.toString());
        if(reponse["status"] == "success") {
              Navigator.of(context).pop();
              showToast("密码修改成功");
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
    print(widget.type);
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
                        Navigator.of(context).pop();
                      },
                    ) ,

                  ),
                  Card(
                      margin: EdgeInsets.only(left: 16,right: 16,top:88),
                      elevation: 1,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.fromLTRB(16, 16, 16, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Text(
                              "设置新密码",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
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
                                        child: CodeSendBtn(1,key:_codeSendKey),
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
                            SizedBox(height: 20,),
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

