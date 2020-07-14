import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class MeDesc extends StatefulWidget {
  int type; //0,自我介绍 1，公司名称 2，工作职位 3.工作内容
  MeDesc(this.type);
  @override
  _MeDescState createState() => _MeDescState();
}

class _MeDescState extends State<MeDesc> {
  TextEditingController _phoneController = TextEditingController();
  String title = "";
  String hint = "";
  int line = 1;

   Map jl = Map();
  void _updete(String json){
    if(_phoneController.text.trim().length <= 0){
      showToast("请输入内容");
    }
    switch(widget.type){
      case 0:
        jl["desc"] =  _phoneController.text;
        break;
    }
    MiviceRepository().upDateJL(json).then((value) {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.type){
      case 0:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 10;
        break;
      case 1:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 1;
        break;
      case 2:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 1;
        break;
      case 3:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 1;
        break;
      case 4:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 1;
        break;
      case 5:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 1;
        break;
      case 6:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 1;
        break;

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("自我介绍",
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
              onPressed: () {}),
        ],
      ),
      body:  Container(
        margin: EdgeInsets.all(20),
        child: LogRegTextField(

          label: "请用简单的自我介绍，展示你的优势",
          controller:  _phoneController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          obscureText: false,

        ),
      ),
    );

  }
}
