import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/city_page.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/work_page.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class WorkPost extends StatefulWidget {
 Map data;
  WorkPost({this.data});
  @override
  _WorkPostState createState() => _WorkPostState();
}

class _WorkPostState extends State<WorkPost> {
  TextEditingController _ConfirmPdController = TextEditingController();
  String type="";
  String workStr="";
  String xl="";
  String work_time="";
  String salary="";
  String work_deteail ="";
  String address ="";
  String job_id;
 String city="";
String company="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompany();
    if(widget.data != null){
      workStr = widget.data["title"];
      address = widget.data["address"];

      if(address.contains("·")){
        city = address.split("·")[0];
        _ConfirmPdController.text = address.split("·")[1];
      }

      salary = widget.data["salary"];
      workStr = widget.data["title"];
      job_id = widget.data["job_id"].toString();

      if(widget.data["summary"] != null && widget.data["summary"] != "" ){
        Map map  = json.decode(widget.data["summary"]);
        work_deteail = map["工作详情"];
      }
      type = widget.data["label"].toString().split("|")[1];
      xl = widget.data["label"].toString().split("|")[2];
      work_time = widget.data["label"].toString().split("|")[3];
    }
  }
  _pubResume(){
if(shState == "0"){
  showToast("对不起，你的公司信息审核不通过，暂时不能发布职位");
  return;
}
    Map dMap = Map();
    dMap["工作详情"] = work_deteail;
     String dJson  = json.encode(dMap);


     String tip = "五险一金 绩效奖金 弹性工作 通讯补贴";

    if(city ==""||salary==""||workStr==""||type==""||xl==""||work_time==""||work_deteail==""||type=="" ||_ConfirmPdController.text.isEmpty){
      showToast("请填写完整的招聘内容");
          return;
    }
    Map data = Map();
    address = city+"·"+_ConfirmPdController.text;
    data["salary"] = salary;
    data["user_mail"] = ShareHelper.getBosss().userMail;
    data["company"] =company;
    data["title"] =workStr;
    data["address"] =address;
    data["label"] ="${address}|${type}|${xl}|${work_time}";
    data["tip"] =tip;
    data["summary"] =dJson;
    data["mook_img"] ="";
    data["job_id"] =job_id;


    MiviceRepository().pubJob(data).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        showToast("职位已更新");
        Navigator.of(context).pop();
      }else{
        showToast("简历更新失败");
      }
    });

  }
  String shState ="1";
  _getCompany(){
    MiviceRepository().getCompany(ShareHelper.getBosss().userMail).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        Map data = reponse["result"];
        company=  data["name"];
        shState=  data["shState"];

      }else{

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: Text('职位编辑',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
      ),
      body: SafeArea(
        top: false,
        child:Stack(

          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 18, bottom: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '* 职位类型',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()async{
                      var mtype= await  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkPage(),
                            ));
                      if(mtype != null){
                        setState(() {
                          type = mtype;
                        });
                      }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(type,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),
                    Text(
                      '* 招聘职位',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async{
                      var ss = await  Navigator.push (
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeDesc(10),
                            ));
                      if(ss != null){
                        setState(() {
                          workStr = ss;
                        });
                      }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(workStr,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),
                    Text(
                      '* 学历要求',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        _showSexPop(context,0);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(xl,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),
                    Text(
                      '* 工作年限',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        _showSexPop(context,1);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(work_time,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),     Text(
                      '* 薪资要求',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        _showSexPop(context,2);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(salary,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),
                    Text(
                      '* 职位详情',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()async{
                     var aa=  await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeDesc(11),
                            ));
                     if(aa != null){
                       setState(() {
                         work_deteail = aa;
                       });
                     }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(work_deteail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),
                    Text(
                      '* 工作地点',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()async{
                     var  cc=await   Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityPage(),
                            ));
                     if(cc != null){
                       setState(() {
                         city = cc;
                       });
                     }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(city,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,),
                          Image.asset(
                            'images/arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      color: Color.fromRGBO(242, 243, 244, 1),
                      height: 1,
                    ),
                    LogRegTextField(

                      label: "请输入具体的地址",
                      controller:  _ConfirmPdController,
                      textInputType: TextInputType.text,

                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: CustomBtnWidget(
                margin: 20,
                btnColor: Colours.app_main,
                text: "发布职位",
                onPressed: (){
                  _pubResume();
                },
              ),
            )
          ],
        )
      ),
    );
  }
  List xlList=["不限","初中", "高中", "中专" , "大专", "本科", "硕士", "博士"];
  List salaryList=[ "面议" ,"4-6千/月", "6-8千/月", "0.8-1万/月", "1-1.5万/月", "1.5-2万/月 ",
    "15-20万/年", "20-30万/年", "30-40万/年"];
  List timeList=["不限","1年经验", "2年经验", "3-4年经验", "5-7年经验", "8-9年经验","10年及以上"];

  void _showSexPop(BuildContext contex, int type){
     List popList = List();
    if(type == 0){
      popList = xlList;
    }else if(type == 1){
      popList = timeList;
    }else if(type == 2){
       popList = salaryList;
    }

    FixedExtentScrollController  scrollController = FixedExtentScrollController(initialItem:0);
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context){
          return _buildBottonPicker(
              CupertinoPicker(

                magnification: 1,
                itemExtent:58 ,
                backgroundColor: Colors.white,
                useMagnifier: true,
                scrollController: scrollController,
                onSelectedItemChanged: (int index){
                  if(mounted){
                    setState(() {

                       if(type == 0){
                         xl = popList[index];
                       }else if(type == 1){
                         work_time = popList[index];
                       }else if(type == 2){
                         salary= popList[index];
                       }



                    });
                  }
                },
                children: List<Widget>.generate(popList.length, (index){
                  return Center(
                    child: Text(popList[index]),
                  );
                }),
              )
          );
        });
  }
  DateTime _initDate = DateTime.now();
  String birthday="";

  void _showDatePop(BuildContext context){

    showCupertinoModalPopup<void>(context: context, builder: (BuildContext cotext){

      return _buildBottonPicker(CupertinoDatePicker(
        minimumYear: _initDate.year-100,
        maximumYear: _initDate.year,
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _initDate,
        onDateTimeChanged: (DateTime dataTime){
          if(mounted){
            setState(() {

              birthday =  formatDate(dataTime, [yyyy,"-",mm,"-",dd]);

            });
          }
        },
      ));
    });
  }
  Widget _buildBottonPicker(Widget picker){
    return Container(
      height: 190,
      padding: EdgeInsets.only(top: 6),
      color: Colors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
            color:Colors.black87,
            fontSize: 18
        ),
        child: GestureDetector(
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
