import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';

/// 登录页面表单字段框封装类
class CusFieldLogReg extends StatefulWidget {

  final String label;

  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputType textInputType;
  final int  line;


  CusFieldLogReg({
    this.label,
    this.icon,
    this.controller,
    this.obscureText: false,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.textInputType,
    this.line,


  });

  @override
  _CusFieldLogRegState createState() {
    // TODO: implement createState
     return _CusFieldLogRegState();
  }

}

class _CusFieldLogRegState extends State<CusFieldLogReg>{
  TextEditingController controller;

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;
  int line;
  TextInputType textInputType;
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);

    if(widget.line == null){
      line =1;
    }else{
      line =widget.line;
    }
    if(widget.textInputType == null){
      textInputType=  TextInputType.text;
    }
    super.initState();
  }
  @override
  void dispose() {
    obscureNotifier.dispose();
    // 默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return TextField(
      keyboardType: textInputType,
      autofocus: false,
      controller: controller,
     focusNode: widget.focusNode,
     textInputAction: widget.textInputAction,
       obscureText: widget.obscureText,
      cursorColor: ColorsUtils.app_main,
      maxLines: line,

      decoration: InputDecoration(

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsUtils.gray_33A4AFA3)
          ),
          //获得焦点下划线设为蓝色
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsUtils.app_main),
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black26
          ),
          labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14
          ),

      ),
    );
  }

}