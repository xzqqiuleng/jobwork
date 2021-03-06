import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/jobpages/page_chatline.dart';
import 'package:recruit_app/viewpages/mine/mine_desc.dart';

import '../page_jub.dart';
import '../page_permweb.dart';
import '../shareprefer_utils.dart';


class PageEmpyDetail extends StatefulWidget {
  String jobId;
  PageEmpyDetail(this.jobId);

  @override
  _PageEmpyDetailState createState() {
    // TODO: implement createState
    return _PageEmpyDetailState();
  }
}

class _PageEmpyDetailState extends State<PageEmpyDetail> {
  List tags=[""];
  String headImag = "";
  Map infor;
  String replayId="";

  int is_collect = 0;

  _saveByType(int type,int classStr){
    Map params = Map();
    params["user_mail"] = SharepreferUtils.getBosss().userMail;
    params["job_id"] = widget.jobId;
    params["class"] = classStr;
    params["type"] = type;
    new PinPinReponse().saveResumeByType(params).then((value) {

    });
  }
_getDetail() {
  new PinPinReponse().getResumeInfo(widget.jobId,SharepreferUtils.getBosss().userMail).then((value) {
    var reponse = json.decode(value.toString());
    print(reponse);
    if (reponse["status"] == "success") {
      String inforJson = reponse["result"]["info"]['info'].toString();
      headImag= reponse["result"]["info"]['head_img'].toString();
      replayId =  reponse["result"]["info"]['reply_id'].toString();
      infor = json.decode(inforJson);
      is_collect =  reponse["result"]["info"]["is_collect"];
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
//               Text("${infor==null?"":infor["start_time"]}-${infor==null?"":infor["stop_time"]}",
//                   style: TextStyle(
//                       wordSpacing: 1,
//                       letterSpacing: 1,
//                       fontSize: 14,
//                       color: Color.fromRGBO(159, 160, 161, 1))),
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
    _saveByType(1,1);
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
              'images/pp_ic_back_arrow.png',
              width: 20,
              height: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        actions: <Widget>[
//          IconButton(
//              icon: Image.asset(
//                'images/ic_action_favor_off_black.png',
//                width: 24,
//                height: 24,
//              ),
//              onPressed: () {}),
//          IconButton(
//              icon: Image.asset(
//                'images/ic_action_share_black.png',
//                width: 24,
//                height: 24,
//              ),
//              onPressed: () {}),
          IconButton(
              icon: Image.asset(
                is_collect == 1 ?'images/pp_save_yes.png':'images/pp_save_no.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {

                setState(() {
                  if( is_collect == 1){
                    is_collect = 0;
                    _saveByType(0, 0);
                  }else{
                    is_collect = 1;
                    _saveByType(1, 0);

                  }
                });

              }),
          IconButton(
              icon: Image.asset(
                'images/pp_ic_action_report_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageJub(4,widget.jobId)));

              })
        ],
      ),
      body: SafeArea(
        top: false,
        child:Stack(
          children: [
            Column(
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
                                child: Image.network(
                                 headImag,
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
                                    color: ColorsUtils.app_main,
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
                              color: ColorsUtils.app_main,
                            ),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MineDesc(0),
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
                                    color: ColorsUtils.app_main,
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
                                    color: ColorsUtils.app_main,
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
                                    color: ColorsUtils.app_main,
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

            Positioned(
              bottom: 0,
              right: 20,
              left: 20,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: MaterialButton(
                    color: ColorsUtils.app_main,
                    onPressed: () {
                      _saveByType(1,2);
                      if(SharepreferUtils.getBosss().realStatus == "1"){

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PageChatLine(head_icon: headImag,title: infor["姓名"],reply_id:  replayId,user_id: SharepreferUtils.getBosss().userId,type: 0,)));
                      }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagePermWeb(),
                            ));
                      }

                    },
                    textColor: Colors.white,
                    child: Text("立即沟通"),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  )),
            ),
          ],
        )
      ),
    );
  }
}
