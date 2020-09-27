
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/companys/company_detail.dart';
import 'package:recruit_app/pages/companys/company_welfare_item.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/jobs/chat_room.dart';
import 'package:recruit_app/pages/jubao.dart';
import 'package:recruit_app/pages/map_nav.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/dash_line.dart';


class JobDetail extends StatefulWidget {
  int id;
  JobDetail(this.id);
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
  String replayId="";
  Map summary;
  Map com_label;
  String address = "暂无地址";
  String compay_desc = "暂无公司信息";

  String company="未注册";
  int is_collect = 0;
  String lat="";
  String lng="";
 List<String> tip = new List();
  _saveByType(int type,int classStr){
    Map params = Map();
    params["user_mail"] = ShareHelper.getUser().userMail;
    params["job_id"] = widget.id;
    params["class"] = classStr;
    params["type"] = type;
    new MiviceRepository().saveJobByType(params).then((value) {

    });
  }

  _loadData(){

 if(widget.id == null){
   widget.id = 113546932;
 }
    new MiviceRepository().getJobDetail(widget.id,ShareHelper.getUser().userMail).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        var   data = reponse["result"];

        setState(() {

          infors = data["info"];  //"com_id" -> 10057  "job_id" -> 120587312
          print(infors);
          is_collect = infors["is_collect"];
          company = infors["company"];
          replayId = infors["reply_id"];  //"com_id" -> 10057  "job_id" -> 120587312
        String  tipJson = infors["tips"];  //"com_id" -> 10057  "job_id" -> 120587312


          if(tipJson != null && tipJson != ""){
          List<dynamic>  tipss = json.decode(tipJson);
      for(var item in tipss){
        tip.add(item);
      }
          }else{
            tip=["五险一金","餐饮补贴","年终奖金","节日福利"];
          }

          print(infors);
          datalist = data["jobs"];
           summary = json.decode(infors["summary"].toString());

           if(infors["com_label"] !=null && infors["com_label"] != ""){
             com_label = json.decode(infors["com_label"].toString());
           }

          if(infors["lat"] !=null && infors["lat"] != ""){
           lat = infors["lat"];
           lng = infors["lng"];
           print(lat);
          }

      print(infors["company_img"]);

          labels = infors["label"].toString().split("|");
          address  = labels[0];
          if(infors["address"] == null ||infors["address"] == ""){
            address  = labels[0];
          }else{
            address  =  infors["address"];
          }
          labels.removeAt(0);
          if(infors["pub_img"] == ""){
            if( infors["mook_img"] != null){
              userImg = infors["mook_img"];
            }

          }else{
            if( infors["pub_img"] != null){
              userImg = infors["pub_img"];
            }

          }
          if(infors["pub_person"]!=null&&infors["pub_person"] != ""){
            user = infors["pub_person"];
          }
          _getLabel();
          _getContent();
        });

      }
    });
  }
  Widget _getTip(){
  List<Widget> tipWidget=[];
  List<Widget> columWidget=[];
  columWidget.add(SizedBox(height: 10));
     if(infors != null &&infors["tip"] != "" &&infors["tip"] != "无"){
       List<String>tips = infors["tip"].toString().split(" ");
       columWidget.add(Text("福利待遇",
           maxLines: 1,
           overflow: TextOverflow.ellipsis,
           style: const TextStyle(
               wordSpacing: 1,
               letterSpacing: 1,
               fontSize: 16,
               fontWeight: FontWeight.bold,
               color: Color.fromRGBO(37, 38, 39, 1))));
       columWidget.add(SizedBox(height: 12));
       for (var item in tips){
         if(item == " "||item ==""){
           continue;
         }
         tipWidget.add( TextTagWidget("$item",
           backgroundColor: Colors.white,
           margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
           padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
           borderRadius: 2,
           borderColor: Color(0xFFF0F0F0),
           textStyle: TextStyle(
               color: Colors.black87,
               fontSize: 14
           ),
         ));
       }

       columWidget.add(Wrap(children: tipWidget));
       columWidget.add(SizedBox(height: 18));

     }else{
       columWidget.add(Container(height: 0,));
     }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: columWidget,
  );
  }
  Widget _getContent(){
 if(summary == null||summary.isEmpty){
   return Text("");
 }
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
        contentWidget.add(Html(data: value.toString().replaceAll("微信分享", "").replaceAll("地图", "")));
      }

   });

   if(com_label != null && com_label.length>0){
     compay_desc = "";
     com_label.forEach((key, value) {
//       if(key.toString().contains("地")){
//         address = com_label[key].toString();
//       }
       compay_desc = compay_desc+ com_label[key]+"·";
     });
   }

  }
  Widget _getLabel(){
    if(labels != null && labels.length >0){


      for (var i = 0; i < labels.length; i++) {
        var str = labels[i];
        itemWidgetList.add(TextTagWidget("$str",
        backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
          borderColor: Color(0xFFF0F0F0),
          borderRadius: 2,
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




    _saveByType(1,1);
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
            //            IconButton(
//                icon: Image.asset(
//                  'images/ic_action_share_black.png',
//                  width: 24,
//                  height: 24,
//                ),
//                onPressed: () {}),
            IconButton(
                icon: Image.asset(
                  is_collect == 1 ?'images/save_yes.png':'images/save_no.png',
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
                  'images/ic_action_report_black.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JubaoPages(1,widget.id.toString())));
                })
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
                                    child: Text(infors == null||infors["title"]==null? "":infors["title"],

                                        style: const TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(37, 38, 39, 1))),
                                  ),
                                  SizedBox(width: 8),
                                  Text(infors == null ||infors["salary"]==null? "":infors["salary"],
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

                              Align(
                                alignment: Alignment.centerLeft,
                                child:   Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    alignment: WrapAlignment.start,
                                    ///子标签
                                    children: itemWidgetList),

                              ),

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
                                              Text('',
                                                  style: const TextStyle(
                                                      wordSpacing: 1,
                                                      letterSpacing: 1,
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          181, 182, 183, 1))),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text('',
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
                      Container(
                        height: 40,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tip.length,
                            itemBuilder: (context, index) {
                              if (index < tip.length) {
                                return CompanyWelfareItem(
                                  welfareData: tip[index],
                                  index: index,
                                  isLastItem: index == tip.length - 1,
                                );
                              }
                              return null;
                            }),
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                      ),
                      _getTip(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: contentWidget,
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
                                      child: Image.network(
                                          (infors == null|| !infors["company_img"].toString().contains("http"))?Constant.deault_compay:infors["company_img"],
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
                                            Text(infors == null || infors["company"] == null?"":infors["company"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    wordSpacing: 1,
                                                    letterSpacing: 1,
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(37, 38, 39, 1))),
                                            SizedBox(height: 5),

                                            Text(compay_desc,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
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
                                  print(infors);
                                  print(infors["com_id"]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompanyDetail(int.parse(infors["com_id"].toString().trim()))));
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapNavWeb(address,lat,lng)));
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 80,
                                child:  Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      child:  ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(2)),
                                        child: Image.asset('images/map_icon.jpg',
                                            height: 100, fit: BoxFit.cover),
                                      ),
                                    ),

                                    Container(
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      height: 44,
                                      margin: EdgeInsets.only(left: 12,right: 12),
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
                                            address.length>13?address.substring(0,13):address,
                                          )
                                        ],

                                      ),
                                    )


                                  ],

                                ),
                              ),
                            )



                            ],
                          )
                      ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('相关职位',
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
                              child: JobDetailRowItem(
                                  job: datalist[index],
                                  index: index,
                                  lastItem: index == datalist.length - 1),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetail(datalist[index]["job_id"]),
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
                    color: Colours.app_main,
                    onPressed: () {
                      _saveByType(1,2);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatRoom(head_icon: userImg,title: user=="HR发布"?company:user,reply_id: replayId,type: 1,user_id: ShareHelper.getUser().userId,)));
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
class JobDetailRowItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;
  final bool isJi;
  final bool isBz;

  const JobDetailRowItem({Key key, this.job, this.index, this.lastItem,this.isJi,this.isBz})
      : super(key: key);


  Widget getImg(String imgUrl){
    if(imgUrl.contains("http")){
      return  ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(28)),
        child: Image.network(
          imgUrl,
          width: ScreenUtil().setWidth(56),
          height: ScreenUtil().setWidth(56),
          fit: BoxFit.cover,
        ),
      );
    }else{
      return Container(
        alignment: Alignment.center,
        height: 28,
        width: 28,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color:Colours.slRandomColor()
        ),
        child: Text(
          imgUrl,
          style: TextStyle(
              fontSize: 10,
              color: Colors.white
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobItem = Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),
        color: Colors.white,
        elevation: 0.5,
        margin: EdgeInsets.only(

            top: ScreenUtil().setWidth(22),
            bottom: 0),
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(28),
              right: ScreenUtil().setWidth(28),
              top: ScreenUtil().setWidth(20),
              bottom: ScreenUtil().setWidth(20)),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            job["title"].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(20, 20, 20, 1),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(job["salary"].toString(),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.bold,
                          color: Colours.app_main)),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(20),
              ),
              Text(
                job["label"].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(23),
                  color: Color.fromRGBO(151, 151, 151, 1),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(28),
              ),
              DashLine(
                color: Colors.black12,
                height: 0.4,
                dashWidth:2,
              ),
              Offstage(
                  offstage: (isJi == null || isJi == false) ? true :false,
                  child : Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                    decoration: BoxDecoration(
                      color: Colours.app_main.withOpacity(0.2),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset("images/ji.png",height: 16,width: 16,),
                        SizedBox(width: 6,),
                        Text(
                          "2020-07-12前停止招聘",
                          style: TextStyle(
                              color: Colours.app_main,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),

                  )
              ),
              Offstage(
                  offstage: (isBz == null || isBz == false) ? true :false,
                  child : Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                    decoration: BoxDecoration(
                      color: Colours.blue_main.withOpacity(0.2),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset("images/bz.png",height: 16,width: 16,),
                        SizedBox(width: 6,),
                        Text(
                          "官方保障，24小时跟踪！",
                          style: TextStyle(
                              color: Colours.blue_main,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),

                  )
              ),

              SizedBox(
                height: ScreenUtil().setWidth(28),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  getImg(job["company_img"].toString()),
                  SizedBox(
                    width: ScreenUtil().setWidth(12),
                  ),
                  Flexible(
                    child: Text(
                      job["pub_person"].toString()==""?"HR发布":job["pub_person"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        color: Color.fromRGBO(57, 57, 57, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      job["pub_date"].toString(),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Color.fromRGBO(176, 181, 180, 1),
                      ),
                    ),
                  )

                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(18),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[


                  Image.asset(
                    'images/qyrz.png',
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setWidth(24),
                    fit: BoxFit.cover,
                  ),

                  SizedBox(
                    width: ScreenUtil().setWidth(4),
                  ),
                  Flexible(
                    child: Text(
                      job["company"].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Color.fromRGBO(57, 57, 57, 1),
                      ),
                    ),
                  ),



                ],
              ),

            ],
          ),
        )
    );

    if (lastItem) {
      return jobItem;
    }
    return Column(
      children: <Widget>[
        jobItem,
      ],
    );
  }
}