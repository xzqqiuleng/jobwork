import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class MeDesc extends StatefulWidget {
  int type; //0,姓名 1，公司名称 2，工作职位 3.工作内容
  String mhint;
  MeDesc(this.type,{this.mhint});
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

   _saveData(){
    if(_phoneController.text != null && _phoneController.text.trim().length >1){
          Navigator.of(context).pop(_phoneController.text);
    }else{
      showToast("请输入正确文本");
    }
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.type){
      case 0:
        title = "姓名编辑";
        hint = "请填写真实姓名，以保证求职沟通顺畅";
        line = 1;
        break;
      case 1:
        title = "微信编辑";
        hint = "请输入常用微信号";
        line = 1;
        break;
      case 2:
        title = "邮箱编辑";
        hint = "请输入常用邮箱，以便及时接到求职结果";
        line = 1;
        break;
      case 3:
        title = "自我介绍";
        hint = "请用简短的话，来描述你的优势";
        line = 20;
        break;
      case 4:
        title = "公司名称";
        hint = "最近就职公司的名称";
        line = 2;
        break;
      case 5:
        title = "公司职位";
        hint = "公司中担任的职位";
        line = 1;
        break;
      case 6:
        title = "工作描述";
        hint = "工作详情描述";
        line = 10;
        break;
      case 7:
        title = "毕业院校";
        hint = "请填写完整的学校名称";
        line = 1;
        break;
      case 8:
        title = "专业";
        hint = "请填写你的专业";
        line = 1;
        break;
      case 9:
        title = "在校经历";
        hint = "优秀的在校经历，能为你的简历加分";
        line = 10;
        break;
      case 10:
        title = "职位描述";
        hint = "简单描述你想招聘的职位";
        line = 10;
        break;
      case 11:
        title = "工作详情";
        hint = "请详细的描述工作岗位所需要的条件";
        line = 10;
        break;
      case 12:
        title = "公司介绍";
        if(widget.mhint != null){
          _phoneController.text = widget.mhint;
        }else{
          hint = "请详细的描述公司概况";
        }

        line = 10;
        break;
      case 13:
        title = "产品及领域";
        if(widget.mhint != null){
          _phoneController.text = widget.mhint;
        }else{
          hint = "请详细的描述产品概况，以及涉及的领域";
        }
        line = 10;
        break;
      case 14:
        title = "投资发展";
        if(widget.mhint != null){
          _phoneController.text = widget.mhint;
        }else{
          hint = "请详细的描述公司前景，投资概况";
        }
        line = 10;
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
        title: Text(title,
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
          line: line,
          label:hint,
          controller:  _phoneController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          obscureText: false,

        ),
      ),
    );

  }
}
