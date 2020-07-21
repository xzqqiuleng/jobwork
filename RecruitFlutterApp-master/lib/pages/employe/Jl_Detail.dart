import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_intent_list.dart';
import 'package:recruit_app/model/mine_edu_list.dart';
import 'package:recruit_app/model/mine_project_list.dart';
import 'package:recruit_app/model/mine_work_list.dart';
import 'package:recruit_app/pages/mine/edu_item.dart';
import 'package:recruit_app/pages/mine/job_intent_item.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';
import 'package:recruit_app/pages/mine/me_gzjl.dart';
import 'package:recruit_app/pages/mine/me_qw.dart';
import 'package:recruit_app/pages/mine/project_item.dart';
import 'package:recruit_app/pages/mine/work_item.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

class JLDetail extends StatefulWidget {
  String jobId;
  JLDetail(this.jobId);

  @override
  _JLDetailState createState() {
    // TODO: implement createState
    return _JLDetailState();
  }
}

class _JLDetailState extends State<JLDetail> {
  List<IntentData> _intentList = JobIntentList.loadJobIntent();
  List<MineWorkData> _workList = MineWorkList.loadWorkList();
  List<MineProjectData> _projectList = MineProjectList.loadProjectList();
  List<MineEduData> _eduList = MineEduList.loadEduList();
  List tags=[""];
  Map infor;
_getDetail() {
  new MiviceRepository().getResumeInfo(widget.jobId).then((value) {
    var reponse = json.decode(value.toString());
    print(reponse);
    if (reponse["status"] == "success") {
      String inforJson = reponse["result"]["info"]['info'].toString();
      infor = json.decode(inforJson);
      tags.clear();
      if (infor["性别"] != "") {
        tags.add(infor["性别"]);
      }
      if (infor["教育经历"] != "") {
        tags.add(infor["教育经历"]);
      }
      if (infor["求职地区"] != "") {
        tags.add(infor["求职地区"]);
      }
      if (infor["年龄"] != "") {
        tags.add(infor["年龄"]);
      }
      if (infor["民族"] != "") {
        tags.add(infor["民族"]);
      }
      if (infor["婚姻状况"] != "") {
        tags.add(infor["婚姻状况"]);
      }
      if (infor["政治面貌"] != "") {
        tags.add(infor["政治面貌"]);
      }
      setState(() {

      });
    }
  });
}
 Widget _getWork(){
   if (null != infor &&  null != infor["工作公司"]) {
     return Padding(
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
                 child: Text(infor==null?"":infor["工作公司"],
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
               Text("${infor==null?"":infor["start_time"]}-${infor==null?"":infor["stop_time"]}",
                   style: TextStyle(
                       wordSpacing: 1,
                       letterSpacing: 1,
                       fontSize: 14,
                       color: Color.fromRGBO(159, 160, 161, 1))),
               SizedBox(width: 15),

             ],
           ),
           SizedBox(height: 5),
           Text(infor==null?"":infor["工作职位"],
               style: TextStyle(
                   wordSpacing: 1,
                   letterSpacing: 1,
                   fontSize: 14,
                   color: Color.fromRGBO(136, 138, 138, 1))),
           SizedBox(height: 8),
           Text(infor==null?"":infor["工作内容"],
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
     );
   }else{
     return Padding(
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
                 child: Text("公司名隐藏",
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
               Text("2019-到今",
                   style: TextStyle(
                       wordSpacing: 1,
                       letterSpacing: 1,
                       fontSize: 14,
                       color: Color.fromRGBO(159, 160, 161, 1))),
               SizedBox(width: 15),

             ],
           ),
           SizedBox(height: 5),
           Text(infor==null?"":infor["求职意向"],
               style: TextStyle(
                   wordSpacing: 1,
                   letterSpacing: 1,
                   fontSize: 14,
                   color: Color.fromRGBO(136, 138, 138, 1))),
           SizedBox(height: 8),
           Text(infor==null?"":infor["求职行业"],
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
     );
   }
}

  Widget _geSchool(){
    if (null != infor &&null != infor["学校"]) {
    return  Padding(
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
                  child: Text(infor==null?"":infor["学校"],
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
                  width: 10,
                ),
                Text(infor==null?"":infor["毕业时间"],
                    style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: 14,
                        color: Color.fromRGBO(159, 160, 161, 1))),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
            Text('${infor==null?"":infor["教育经历"]}•${infor==null?"":infor["专业"]}',
                style: TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Color.fromRGBO(136, 138, 138, 1))),
            SizedBox(height: 10),
            Text(infor==null?"":infor["在校经历"],
                style: TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Colors.black87)),
          ],
        ),
      );
    }else{
      return  Padding(
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
                  child: Text("学校隐藏中",
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
                  width: 5,
                ),
                Text(infor==null?"":infor["政治面貌"],
                    style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: 14,
                        color: Color.fromRGBO(159, 160, 161, 1))),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
            Text('${infor==null?"":infor["教育经历"]}•${infor==null?"":infor["年龄"]}',
                style: TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Color.fromRGBO(136, 138, 138, 1))),
            SizedBox(height: 10),
            Text("",
                style: TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Colors.black87)),
          ],
        ),
      );
    }
    }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _getDetail();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar:  AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 20,
              height: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/ic_action_favor_off_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {}),
          IconButton(
              icon: Image.asset(
                'images/ic_action_share_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {}),
          IconButton(
              icon: Image.asset(
                'images/ic_action_report_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {})
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      Row(
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
                                        infor==null?"":infor["姓名"],
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
                                Text(infor==null||infor["目前状态"]==null?"离职-正在找工作":infor["目前状态"],
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
                             Text(
                               infor==null?"":infor["希望月薪"],
                               style: TextStyle(
                                 color: Colours.app_main,
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold
                               ),
                             )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        runSpacing: 6,
                        children: tags.map((item) {
                          return new Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: new BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              child: Text(item,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, color: Colors.grey[600])));
                        }).toList(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),
                      Text(
                        '* 简介',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colours.app_main,
                        ),
                      ),
                      SizedBox(height: 8),
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
                                child:   Text(   infor==null?"":infor["求职行业"],
                                    style: TextStyle(
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontSize: 14,
                                        color: Color.fromRGBO(136, 138, 138, 1))),
                            ),
                            SizedBox(width: 8,),

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
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),


                        ],
                      ),
                      SizedBox(height: 8,),
                      Padding(
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
                                    Text( infor==null?"":infor["求职意向"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(37, 38, 39, 1))),
                                    SizedBox(height: 8),
                                    Text('${infor==null?"":infor["求职地区"]} • ${infor==null?"":infor["希望月薪"]}',
                                        style: TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 14,
                                            color: Color.fromRGBO(136, 138, 138, 1))),
                                  ],
                                )),
                            SizedBox(width: 15),

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
                              '* 工作经历',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),


                        ],
                      ),
                      SizedBox(height: 8,),
                      _getWork(),

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
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),

                        ],
                      ),
                      SizedBox(height: 8,),
                      _geSchool(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
