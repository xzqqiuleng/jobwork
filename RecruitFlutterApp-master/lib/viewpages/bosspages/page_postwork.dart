import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/mine/mine_desc.dart';

import '../cusbtn.dart';
import '../page_fd.dart';
import '../page_worsk.dart';
import '../shareprefer_utils.dart';


class PagePostWork extends StatefulWidget {
 Map data;
  PagePostWork({this.data});
  @override
  _PagePostWorkState createState() => _PagePostWorkState();
}

class _PagePostWorkState extends State<PagePostWork> {
  TextEditingController _ConfirmPdController = TextEditingController();
  String type="";
  String workStr="";
  String xl="";
  String work_time="";
  String salary="";
  String work_deteail ="";
  String address ="暂无";
  String job_id;
 String city="暂无";
String company="";
String jsonFuli;
String fuliStr="";


  Widget  _getShWidget(){
    if(shState =="0"){
      return  Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Text(
          "公司资质认证失败，不能发布职位！",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      );
    } else if(shState =="2"){
      return  Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Text(
          "公司资质正在审核中，暂时不能发布职位！",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      );
    }else{
      return Text("");
    }
  }
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

      jsonFuli =  widget.data["tips"];
      if(jsonFuli.isNotEmpty){
        List<dynamic>FLs = json.decode(jsonFuli);
        for(var item in FLs){
          fuliStr = item +","+fuliStr;
        }
      }
    }
  }
  _pubResume(){
if(shState == "0"){
  showToast("对不起，你的公司资质审核不通过，暂时不能发布职位");
  return;
}
if(shState == "2"){
  showToast("对不起，你的公司资质正在审核中，暂时不能发布职位");
  return;
}
    Map dMap = Map();
    dMap["工作详情"] = work_deteail;
     String dJson  = json.encode(dMap);


     String tip = "五险一金 绩效奖金 弹性工作 通讯补贴";

    if(city ==""||salary==""||workStr==""||type==""||xl==""||work_time==""||work_deteail==""||type=="" ||_ConfirmPdController.text.isEmpty||jsonFuli == null){
      showToast("请填写完整的招聘内容");
          return;
    }
    Map data = Map();
    address = city+"·"+"暂无";
    data["salary"] = salary;
    data["user_mail"] = SharepreferUtils.getBosss().userMail;
    data["company"] =company;
    data["title"] =workStr;
    data["address"] =address;
    data["label"] ="${address}|${type}|${xl}|${work_time}";
    data["tip"] =tip;
    data["summary"] =dJson;
    data["mook_img"] ="";
    data["job_id"] =job_id;
    data["tips"] =jsonFuli;


    PinPinReponse().pubJob(data).then((value) {
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
    PinPinReponse().getCompany(SharepreferUtils.getBosss().userMail).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        Map data = reponse["result"];
        company=  data["name"];
        shState=  data["sh_state"].toString();
         setState(() {

         });
      }else{

      }
    });
  }
  void showBottomFl(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset(
              'images/pp_ic_back_arrow.png',
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
                    _getShWidget(),
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
                              builder: (context) => PageWorsk(),
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
                            'images/pp_arrow_right.png',
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
                              builder: (context) => MineDesc(10),
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
                            'images/pp_arrow_right.png',
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
                            'images/pp_arrow_right.png',
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
                            'images/pp_arrow_right.png',
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
                            'images/pp_arrow_right.png',
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
                              builder: (context) => MineDesc(11),
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
                            'images/pp_arrow_right.png',
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
                      '* 福利待遇',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async{
                     List<String>resultList = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageFd(),
                            ));
                     if(resultList == null){
                       return;
                     }
                     jsonFuli = json.encode(resultList);
                     for(var item in resultList){
                        fuliStr =item+"," +fuliStr;
                     }
                     setState(() {

                     });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(fuliStr,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 138, 138, 1))),
                          ),
                          SizedBox(width: 8,height: 40,),
                          Image.asset(
                            'images/pp_arrow_right.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
//                    Container(
//                      margin: EdgeInsets.symmetric(vertical: 10),
//                      color: Color.fromRGBO(242, 243, 244, 1),
//                      height: 1,
//                    ),
//                    Text(
//                      '* 工作地点',
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                      style: const TextStyle(
//                          fontSize: 13,
//                          fontWeight: FontWeight.w600
//                      ),
//                    ),
//                    SizedBox(height: 8),
//                    GestureDetector(
//                      behavior: HitTestBehavior.opaque,
//                      onTap: ()async{
//                     var  cc=await   Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => CityPage(),
//                            ));
//                     if(cc != null){
//                       setState(() {
//                         city = cc.toString().split("|")[1];
//                       });
//                     }
//                      },
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child:   Text(city,
//                                style: TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Color.fromRGBO(136, 138, 138, 1))),
//                          ),
//                          SizedBox(width: 8,),
//                          Image.asset(
//                            'images/arrow_right.png',
//                            width: 18,
//                            height: 18,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.symmetric(vertical: 15),
//                      color: Color.fromRGBO(242, 243, 244, 1),
//                      height: 1,
//                    ),
//                    LogRegTextField(
//
//                      label: "请输入具体的地址",
//                      controller:  _ConfirmPdController,
//                      textInputType: TextInputType.text,
//
//                    ),
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
              child: Cusbtn(
                margin: 20,
                btnColor: ColorsUtils.app_main,
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



  String mxl ="不限" ;
  String mwork_time="不限";
  String msalary="面议";
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
                         mxl = popList[index];
                       }else if(type == 1){
                         mwork_time = popList[index];
                       }else if(type == 2){
                         msalary= popList[index];
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
          ,type);
        });
  }
  DateTime _initDate = DateTime.now();
  String birthday="";



  Widget _buildBottonPicker(Widget picker,int type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 52,
          color: Color(0xfff6f6f6),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(

                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消",
                    style: TextStyle(
                        color: ColorsUtils.black_212920,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                    ),),
                ),
              ),
              Positioned(
                right: 20,
                child: GestureDetector(
                  onTap: () {

                    Navigator.pop(context);
                    setState(() {
                      if(mounted){
                        setState(() {

                          if(type == 0 && mxl != null){
                            xl = mxl;
                          }else if(type == 1 && mwork_time != null){
                            work_time = mwork_time;
                          }else if(type == 2 && msalary != null){
                            salary= msalary;
                          }



                        });
                      }
                    });
                  },
                  child: Text("确定",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: ColorsUtils.app_main,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 190,
          padding: EdgeInsets.only(top: 6),
          color: Colors.white,
          child: DefaultTextStyle(
            style: const TextStyle(
                color: ColorsUtils.black_212920,
                fontSize: 18
            ),
            child: GestureDetector(
              child: SafeArea(
                top: false,
                child: picker,
              ),
            ),
          ),
        )
      ],

    );
  }

}
