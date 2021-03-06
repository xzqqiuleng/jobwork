import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colors_utils.dart';

class VerCodeBtn  extends StatefulWidget{
//  PhoneCodeModel model;
//  CodeSendBtn(this.model);
  int type;
  VerCodeBtn(this.type,{Key key}) : super(key: key);
  @override
  VerCodeBtnState createState() {
    // TODO: implement createState
   return VerCodeBtnState();
  }

}

class VerCodeBtnState extends State<VerCodeBtn>{

  Timer _timer;
  int _countdownTime = 0;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
        width:72 ,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: ColorsUtils.app_main
        ),
        child:Text(

          _countdownTime > 0 ? '${_countdownTime}s' : '获取验证码',

          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w100
          ),
        ) ,

    ) ;
  }

  void clickCode(String phone){
    getSmsCode( phone);
    if (_countdownTime == 0 ) {

    setState(() {
    _countdownTime = 60;
    });
    //开始倒计时
    startCountdownTimer();
  }
  }
   void getSmsCode(String phone) async{
    String code;
      if(widget.type == 0){
        code="8827336";             //注册
      }else  if(widget.type == 1){
        code="8827337";  ///忘记密码
      }else {
        code="14373645"; //绑定手机
      }
    print(phone);
    Smssdk.getTextCode(phone,"86",code, (dynamic ret, Map err){
      if(err!=null){
        print(err);
      }
      else
      {

      }
    });
  }
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };

    _timer = Timer.periodic(oneSec, callback);
  }
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }



}