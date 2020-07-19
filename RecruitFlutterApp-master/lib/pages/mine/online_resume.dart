import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_intent_list.dart';
import 'package:recruit_app/model/mine_edu_list.dart';
import 'package:recruit_app/model/mine_project_list.dart';
import 'package:recruit_app/model/mine_work_list.dart';
import 'package:recruit_app/pages/btn_widget.dart';
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

import 'me_edu.dart';

class OnlineResume extends StatefulWidget {
  @override
  _OnlineResumeState createState() {
    // TODO: implement createState
    return _OnlineResumeState();
  }
}

class _OnlineResumeState extends State<OnlineResume> {
  List<IntentData> _intentList = JobIntentList.loadJobIntent();
  List<MineWorkData> _workList = MineWorkList.loadWorkList();
  List<MineProjectData> _projectList = MineProjectList.loadProjectList();
  List<MineEduData> _eduList = MineEduList.loadEduList();

  String name ="哈哈哈";
  String desc ="我是一个自我介绍";
  String work ="哈哈哈";
  String money ="7000以上";
  String city ="武汉";
  String work_company ="找铁网";
  String work_pos ="Android开发";
  String work_infro = "开发App";
  String start_time = "2019-02-20";
  String stop_time = "2020-02-20";
  String school = "武汉大学";
  String  zy= "自动化";
  String xl = "本科";
  String  by_time = "2020-01-20";
  String  jl = "我是一名大神";


  _pubResume(){

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

    MiviceRepository().pubResumen(data).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        showToast("简历更新成功");
      }else{
        showToast("简历更新失败");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 18, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MineInfor(),
                              ));
                        },
                        child:   Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'images/avatar_15.png',
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
                                          '狐说',
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
                                  Text('5年经验•26岁•本科',
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
                      ),

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
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeDesc(0),
                              ));
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
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _intentList.length) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MeQW(),
                                    ));
                              },
                              child: JobIntentItem(
                                intentData: _intentList[index],
                                index: index,
                              ),
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
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
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _workList.length) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MeGzjl(),
                                    ));
                              },
                                behavior: HitTestBehavior.opaque,
                              child:  WorkItem(
                                workData: _workList[index],
                                index: index,
                              )
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: _workList.length,
                        physics: const NeverScrollableScrollPhysics(),
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
//                          GestureDetector(
//                              onTap: (){
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => MeEdu(),
//                                    ));
//                              },
////                              child: Text(
////                                "添加",
////                                style: TextStyle(
////                                    color: Colours.app_main,
////                                    fontWeight: FontWeight.bold
////                                ),
////                              )
//                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _eduList.length) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MeEdu(),
                                    ));
                              },
                              child: EduItem(
                                eduData: _eduList[index],
                                index: index,
                              )
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: _eduList.length,
                        physics: const NeverScrollableScrollPhysics(),
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
                      Container(
                        margin: EdgeInsets.only(top: 15,bottom: 50),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),
                        SizedBox(
                          height: 40,
                        )
                    ],
                  ),
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
    );
  }
}
