import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/bosspages/page_postwork.dart';


class PageJobManageDet extends StatefulWidget {
  Map data;
  PageJobManageDet(this.data);

  @override
  _PageJobManageDetState createState() {
    // TODO: implement createState
    return _PageJobManageDetState();
  }
}

class _PageJobManageDetState extends State<PageJobManageDet> {
  String detail="";
  String mlabel="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data["summary"] != null && widget.data["summary"] != "" ){
      Map map  = json.decode(widget.data["summary"]);
      detail = map["工作详情"];
    }
    List<String> labels = widget.data["label"].toString().split("|");
    labels.removeAt(0) ;

    for(var item in labels){
      if(mlabel == ""){
        mlabel = item;
      }else{
        mlabel = mlabel +"|"+item;
      }
    }

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
                'images/pp_ic_back_arrow.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: Text('职位详情',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  wordSpacing: 1,
                  letterSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 38, 39, 1))),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          actions: <Widget>[

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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(widget.data["title"],
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
                          Text(widget.data["salary"],
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(70, 192, 182, 1))),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.data["address"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color: Color.fromRGBO(46, 47, 48, 1))),
                          SizedBox(width: 8),
                          Text(widget.data["pub_person"],
                              style: TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color: Color.fromRGBO(46, 47, 48, 1))),
                          SizedBox(width: 8),
                          Text(widget.data["pub_date"],
                              style: TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color: Color.fromRGBO(46, 47, 48, 1))),
                        ],
                      ),
                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 1,
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                      ),
                      Text('职位描述',
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
                      Text(
                          mlabel,
                          style: const TextStyle(
                              wordSpacing: 2,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Color.fromRGBO(108, 109, 110, 1))),
                      SizedBox(
                        height: 10,
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
                      Text(
                          detail,
                          style: const TextStyle(
                              wordSpacing: 2,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Color.fromRGBO(108, 109, 110, 1))),
                      SizedBox(
                        height: 10,
                      ),


                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          color: ColorsUtils.app_main,
                          onPressed: () {

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PagePostWork(data:widget.data)));

                          },
                          textColor: Color.fromRGBO(85, 85, 85, 1),
                          child: Text("编辑",style: TextStyle(
                            color: Colors.white
                          ),),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),

                    ],
                  )),
            ),
          ],
        ));
  }
}
