import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/companys/company_detail.dart';
import 'package:recruit_app/pages/jobs/chat_room.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'job_row_item.dart';

class JobDetail extends StatefulWidget {
  @override
  _JobDetailState createState() {
    // TODO: implement createState
    return _JobDetailState();
  }
}
//这次基础款结帐一次，以后每次大版本更新再另算（包括新需求，新模块）。小功能的话，修bug免费。
class _JobDetailState extends State<JobDetail> {
  Map infors ;
  List datalist=List() ;
  List<String> labels;
  List<Widget> itemWidgetList=[];
  List<Widget> contentWidget=[];
  String userImg="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2519824424,1132423651&fm=26&gp=0.jpg";
  String user="HR发布";
  Map summary;
  _loadData(){


    new MiviceRepository().getJobDetail(121026442).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        var   data = reponse["result"];


        setState(() {
          infors = data["info"];
          datalist = data["jobs"];
           summary = json.decode(infors["summary"].toString());


          labels = infors["label"].toString().split("|");

          if(infors["pub_img"] == ""){
            userImg = infors["mook_img"];
          }else{
            userImg = infors["pub_img"];
          }
          if(infors["pub_person"] != ""){
            user = infors["pub_person"];
          }
          _getLabel();
          _getContent();
        });

      }
    });
  }

  Widget _getContent(){
   summary.forEach((key, value) {
      if(key != "公司信息"){
        contentWidget.add( Text(key.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))));
        contentWidget.add(SizedBox(
          height: 8,
        ));
        contentWidget.add(Html(data: value.toString().replaceAll("微信分享", "")));
      }

   });
  }
  Widget _getLabel(){
    if(labels != null && labels.length >0){


      for (var i = 0; i < labels.length; i++) {
        var str = labels[i];
        itemWidgetList.add(TextTagWidget("$str",
        backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
          padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
          borderColor: Color(0xFFF0F0F0),
          textStyle: TextStyle(
            color: Colors.black38,
          fontSize: 12
          ),
        ));
      }

    }
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        body: Column(
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
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 18, bottom: 18),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(infors == null? "":infors["title"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(37, 38, 39, 1))),
                                  ),
                                  SizedBox(width: 8),
                                  Text(infors == null? "":infors["salary"],
                                      style: const TextStyle(
                                          wordSpacing: 1,
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colours.app_main)),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                          Row(

                              ///子标签
                              children: itemWidgetList),

                              Container(
                                color: Color.fromRGBO(242, 242, 242, 1),
                                height: 1,
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                    child: Image.network(userImg,
                                        width: 50, height: 50, fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(user,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        wordSpacing: 1,
                                                        letterSpacing: 1,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color:
                                                        Color.fromRGBO(37, 38, 39, 1))),
                                              ),
                                              SizedBox(width: 8),
                                              Text('今日活跃',
                                                  style: const TextStyle(
                                                      wordSpacing: 1,
                                                      letterSpacing: 1,
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          181, 182, 183, 1))),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text('腾讯•招聘者',
                                              style: TextStyle(
                                                  wordSpacing: 1,
                                                  letterSpacing: 1,
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(46, 47, 48, 1))),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ,
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: contentWidget,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 1,
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 18, bottom: 18),
                          child: Column(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      child: Image.asset(
                                          'images/ic_ask_resume_action.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(infors == null?"":infors["company"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    wordSpacing: 1,
                                                    letterSpacing: 1,
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(37, 38, 39, 1))),
                                            SizedBox(height: 5),
                                            Text('已上市•10000人以上•互联网',
                                                style: TextStyle(
                                                    wordSpacing: 1,
                                                    letterSpacing: 1,
                                                    fontSize: 12,
                                                    color: Colors.black54)),
                                          ],
                                        )),
                                    SizedBox(width: 15),
                                    Image.asset('images/ic_arrow_gray.png',
                                        width: 10, height: 10, fit: BoxFit.cover)
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompanyDetail()));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            Container(
                              height: 80,
                              child:  Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                    child: Image.asset('images/map_icon.jpg',
                                        height: 100, fit: BoxFit.cover),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                     height: 44,
                                     margin: EdgeInsets.only(left: 30,right: 30),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset('images/loc_address.png',
                                            width: 16,
                                            height: 16, fit: BoxFit.cover),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "地址"
                                        )
                                      ],

                                    ),
                                  )


                                ],

                              ),
                            )


                            ],
                          )
                      ),
                      ),
                      Text('职位详情',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.builder(itemBuilder: (context, index) {
                        if (datalist.length >0 && index < datalist.length) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: JobRowItem(
                                  job: datalist[index],
                                  index: index,
                                  lastItem: index == datalist.length - 1),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetail(),
                                    ));
                              });
                        }
                        return null;
                      },
                        itemCount: datalist.length,
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()
                      )
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: MaterialButton(
                    color: Color.fromRGBO(70, 192, 182, 1),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatRoom()));
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
        ));
  }
}
