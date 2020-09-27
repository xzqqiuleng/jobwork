import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class NormalWord extends StatefulWidget {
  @override
  _NormalWordState createState() => _NormalWordState();
}

class _NormalWordState extends State<NormalWord> {

  TextEditingController _phoneController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }
  _saveData(){
    if(_phoneController.text.isNotEmpty){
      ShareHelper.putNormal(_phoneController.text);
    }else{
      showToast("请先输入内容");
    }
  Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("添加常用语",
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
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/complete.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {_saveData();}),
        ],
      ),
      body:  Container(
        margin: EdgeInsets.all(20),
        child: LogRegTextField(
          line: 2,
          label:"请输入你经常使用的聊天内容",
          controller:  _phoneController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          obscureText: false,

        ),
      ),
    );
  }
}
