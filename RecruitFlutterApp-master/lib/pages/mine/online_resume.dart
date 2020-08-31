import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_intent_list.dart';
import 'package:recruit_app/model/mine_edu_list.dart';
import 'package:recruit_app/model/mine_project_list.dart';
import 'package:recruit_app/model/mine_work_list.dart';
import 'package:recruit_app/pages/account/login/login_type.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/mine/edu_item.dart';
import 'package:recruit_app/pages/mine/job_intent_item.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';
import 'package:recruit_app/pages/mine/me_gzjl.dart';
import 'package:recruit_app/pages/mine/me_qw.dart';
import 'package:recruit_app/pages/mine/mine_infor.dart';
import 'package:recruit_app/pages/mine/project_item.dart';
import 'package:recruit_app/pages/mine/work_item.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'me_edu.dart';

class OnlineResume extends StatefulWidget {
  @override
  _OnlineResumeState createState() {
    // TODO: implement createState
    return _OnlineResumeState();
  }
}

class _OnlineResumeState extends State<OnlineResume> {


  String name ="";
  String desc ="";
  String work ="";
  String money ="";
  String city ="";
  String work_company ="";
  String work_pos ="";
  String work_infro = "";
  String start_time = "";
  String stop_time = "";
  String school = "";
  String  zy= "";
  String xl = "";
  String  by_time = "";
  String  jl = "";
  String jlState="";
  String job_id;

  Map qwMap;
  Map eduMap;
  Map workMap;

  _back(){
    if(jlState != "1"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginType(),
          ));
    }else{
       Navigator.of(context).pop();
    }
  }

  _pubResume(){
    if(money.length<1||xl.length<1||city.length<1||work.length<1||desc.length<1||work_company.length<1||work_pos.length<1
    ||work_infro.length<1||start_time.length<1||stop_time.length<1||school.length<1||zy.length<1||by_time.length<1||jl.length<1

    ){
      showToast("请填写完整信息");
      return;
    }
    Map infors = Map();
    infors["姓名"]=  ShareHelper.getUser().userName;
    infors["年龄"]=  "";
    infors["性别"]=  ShareHelper.getUser().userSex;
    infors["民族"]=  "";
    infors["婚姻状况"]=  "";
    infors["希望月薪"]=  money;
    infors["政治面貌"]=  "";
    infors["教育经历"]=  xl;
    infors["求职地区"]= city;
    infors["求职意向"]=  work;
    infors["求职行业"]=  desc;
    infors["目前状态"]=  ShareHelper.getUser().resumeStatus;
    infors["户籍所在地"]=  city;
    infors["目前所在地"]=  city;

    infors["工作公司"]=work_company;
    infors["工作职位"]=work_pos;
    infors["工作内容"]=work_infro;
    infors["入职时间"]=start_time;
    infors["离职时间"]=stop_time;
    infors["学校"]=school;
    infors["专业"]=zy;
    infors["毕业时间"]=by_time;
    infors["在校经历"]=jl;
  String inforJson = json.encode(infors);
  Map data = Map();
  data["province"]=city;
  data["type"]=work;
  data["education"]=xl;
  data["info"]=inforJson;
  data["head_img"]=ShareHelper.getUser().headImg;
  data["user_mail"]=ShareHelper.getUser().userMail;
  data["job_id"]=job_id;

    MiviceRepository().pubResumen(data).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        showToast("简历更新成功");
        if(jlState != "1"){

          Map userMap = Map();
          userMap["jl_status"] ="1";
          userMap["user_id"] =ShareHelper.getUser().userId;
          MiviceRepository().updateUser(userMap).then((value){
            User user = ShareHelper.getUser();
            user.jlStatus ="1";
            StorageManager.localStorage.setItem(ShareHelper.kUser, user);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RecruitHomeApp(),
                ));

          });



        }

      }else{
        showToast("简历更新失败");
      }
    });

  }
 _getRumen(){
   MiviceRepository().getRusumen(ShareHelper.getUser().userMail).then((value) {
     var response = json.decode(value.toString());
     print(response);
     if(response["status"] == "success"){
       Map data = response["result"];
       city = data["province"];
       work = data["type"];
       xl = data["education"];

       job_id = data["job_id"].toString();
      String   inforJson = data["info"];
       var infors = json.decode(inforJson);

       money =  infors["希望月薪"] ;
       xl =infors["教育经历"];
       city =infors["求职地区"];
       desc = infors["求职行业"];
       work_company =infors["工作公司"];
       work_pos = infors["工作职位"];
       work_infro = infors["工作内容"];
       start_time = infors["入职时间"];
       stop_time= infors["离职时间"];
       school =infors["学校"];
       zy =infors["专业"];
       by_time = infors["毕业时间"];
       jl = infors["在校经历"];

       qwMap = Map();
       qwMap["work_type"] = work;
       qwMap["money"] = money;
       qwMap["city"] = city;
       workMap = Map();
       workMap["work_company"] = work_company;
       workMap["work_pos"] = work_pos;
       workMap["work_infro"] = work_infro;
       workMap["start_time"] = start_time;
       workMap["stop_time"] = stop_time;
       eduMap = Map();
       eduMap["school"] = school;
       eduMap["zy"] = zy;
       eduMap["by_time"] = by_time;
       eduMap["jl"] = jl;
       eduMap["xl"] = xl;
       setState(() {

       });
     }else{

     }
   });
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jlState = ShareHelper.getUser().jlStatus;
    if(jlState == "1"){
      _getRumen();
    }
  }

  Widget getTop(){
    if(jlState == "1"){
    return  GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MineInfor(1),
              ));
        },
        child:   Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                ShareHelper.getUser().headImg,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          ShareHelper.getUser().userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(37, 38, 39, 1),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(  ShareHelper.getUser().resumeStatus == null?"正在求职中": ShareHelper.getUser().resumeStatus,
                      style: const TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: 14,
                        color: Color.fromRGBO(164, 165, 166, 1),
                      )),
                ],
              ),
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
      );

    }else{
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        _back();
      },

      child: Scaffold(

        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Image.asset(
                'images/ic_back_arrow.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                _back();
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          centerTitle: true,
          title: Text('我的在线简历',
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
          child: Stack(

            children: <Widget>[

               SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 18, bottom: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        getTop(),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          color: Color.fromRGBO(242, 243, 244, 1),
                          height: 1,
                        ),
                        Text(
                          '* 自我介绍',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async{
                            var  mdesc = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MeDesc(3),
                                ));
                            if(mdesc != null){
                              setState(() {
                                desc = mdesc;
                              });
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child:   Text(desc,
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

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '* 工作期望',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 16,),
//                       GestureDetector(
//                         onTap: (){
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => MeQW(),
//                               ));
//                         },
//                         child: Text(
//                           "添加",
//                           style: TextStyle(
//                               color: Colours.app_main,
//                               fontWeight: FontWeight.bold
//                           ),
//                         )
//                       )
//                         ,
                          ],
                        ),
                        SizedBox(height: 16,),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async{
                            Map rdat = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MeQW(qw:qwMap),
                                ));
                            if(rdat != null){
                              qwMap = rdat;
                              work= qwMap["work_type"] ;
                              money=  qwMap["money"] ;
                              city=  qwMap["city"] ;
                            }
                            setState(() {

                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${work}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                wordSpacing: 1,
                                                letterSpacing: 1,
                                                fontSize: 14,
                                                color: Color.fromRGBO(37, 38, 39, 1))),
                                        SizedBox(height: 8),
                                        Text('${city} ${money}',
                                            style: TextStyle(
                                                wordSpacing: 1,
                                                letterSpacing: 1,
                                                fontSize: 14,
                                                color: Color.fromRGBO(136, 138, 138, 1))),
                                      ],
                                    )),
                                SizedBox(width: 15),
                                Image.asset('images/ic_arrow_gray.png',
                                    width: 10, height: 10, fit: BoxFit.cover)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          color: Color.fromRGBO(242, 243, 244, 1),
                          height: 1,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '* 工作经历',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
//                          GestureDetector(
//                              onTap: (){
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => MeGzjl(),
//                                    ));
//                              },
//                              child: Text(
//                                "添加",
//                                style: TextStyle(
//                                    color: Colours.app_main,
//                                    fontWeight: FontWeight.bold
//                                ),
//                              )
//                          )
                          ],
                        ),
                        SizedBox(height: 8,),
                        GestureDetector(
                            onTap: () async{
                              Map m_wo = await   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MeGzjl(),
                                  ));
                              if(m_wo != null){

                                workMap = m_wo;
                                setState(() {
                                  work_company=   workMap["work_company"];
                                  work_pos = workMap["work_pos"] ;
                                  work_infro =workMap["work_infro"] ;
                                  start_time = workMap["start_time"] ;
                                  stop_time= workMap["stop_time"];
                                });



                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(work_company,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                wordSpacing: 1,
                                                letterSpacing: 1,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(37, 38, 39, 1))),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("${start_time}-${stop_time}",
                                          style: TextStyle(
                                              wordSpacing: 1,
                                              letterSpacing: 1,
                                              fontSize: 14,
                                              color: Color.fromRGBO(159, 160, 161, 1))),
                                      SizedBox(width: 15),
                                      Image.asset('images/ic_arrow_gray.png',
                                          width: 10, height: 10, fit: BoxFit.cover)
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text('${work_pos}',
                                      style: TextStyle(
                                          wordSpacing: 1,
                                          letterSpacing: 1,
                                          fontSize: 14,
                                          color: Color.fromRGBO(136, 138, 138, 1))),
                                  SizedBox(height: 8),
                                  Text('${work_infro}',
                                      style: TextStyle(
                                          wordSpacing: 1,
                                          letterSpacing: 1,
                                          fontSize: 14,
                                          color: Color.fromRGBO(136, 138, 138, 1))),
                                  SizedBox(
                                    height: 8,
                                  ),

                                ],
                              ),
                            )
                        ),


//                      Container(
//                        margin: EdgeInsets.symmetric(vertical: 15),
//                        color: Color.fromRGBO(242, 243, 244, 1),
//                        height: 1,
//                      ),

//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              '项目经历',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: const TextStyle(
//                                fontSize: 16,
//                                fontWeight: FontWeight.bold,
//                                color: Color.fromRGBO(37, 38, 39, 1),
//                              ),
//                            ),
//                          ),
//                          SizedBox(width: 8,),
//                          Image.asset(
//                            'images/icon_increase.png',
//                            width: 18,
//                            height: 18,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
//
//                      SizedBox(height: 8,),
//                      ListView.builder(
//                        itemBuilder: (context, index) {
//                          if (index < _projectList.length) {
//                            return ProjectItem(
//                              projectData: _projectList[index],
//                              index: index,
//                            );
//                          }
//                          return null;
//                        },
//                        shrinkWrap: true,
//                        itemCount: _projectList.length,
//                        physics: const NeverScrollableScrollPhysics(),
//                      ),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          color: Color.fromRGBO(242, 243, 244, 1),
                          height: 1,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '* 教育经历',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                          ],
                        ),
                        SizedBox(height: 8,),
                        GestureDetector(
                          onTap: () async{
                            Map ss =  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MeEdu(),
                                ));
                            if(ss != null){
                              eduMap = ss;
                              setState(() {

                                school =eduMap["school"];
                                zy= eduMap["zy"];
                                by_time= eduMap["by_time"];
                                jl= eduMap["jl"] ;
                                xl= eduMap["xl"] ;
                              });
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(school,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              wordSpacing: 1,
                                              letterSpacing: 1,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(37, 38, 39, 1))),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(by_time,
                                        style: TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 14,
                                            color: Color.fromRGBO(159, 160, 161, 1))),
                                    SizedBox(width: 15),
                                    Image.asset('images/ic_arrow_gray.png',
                                        width: 10, height: 10, fit: BoxFit.cover)
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text('${xl}•${zy}',
                                    style: TextStyle(
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontSize: 14,
                                        color: Color.fromRGBO(136, 138, 138, 1))),
                              ],
                            ),
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          color: Color.fromRGBO(242, 243, 244, 1),
                          height: 1,
                        ),

//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              '* 资格证书',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: const TextStyle(
//                                fontSize: 14,
//                                color: Colours.app_main,
//                              ),
//                            ),
//                          ),
//
//                        ],
//                      ),

                        SizedBox(
                          height: 40,
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
                  text: "发布简历",
                  onPressed: (){
                    _pubResume();
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
