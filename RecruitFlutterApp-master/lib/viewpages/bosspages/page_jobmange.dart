import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/bosspages/page_jobmangede.dart';
import 'package:recruit_app/viewpages/bosspages/page_postwork.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';


import '../page_permweb.dart';
import '../shareprefer_utils.dart';
import 'item_mangetjob.dart';

class PageJobManage extends StatefulWidget {
  @override
  _PageJobManageState createState() {
    // TODO: implement createState
    return _PageJobManageState();
  }
}

class _PageJobManageState extends State<PageJobManage> {
  List _jobList = List();
  
  
  @override
  void initState() {
    // TODO: implement initState
    PinPinReponse().getResumeList(SharepreferUtils.getBosss().userMail).then((value) {
      var reponse = json.decode(value.toString());
      print(reponse);
      if(reponse["status"] == "success"){
        _jobList = reponse["result"];
        setState(() {

        });
      }else{

      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              icon: Image.asset(
                'images/pp_ic_back_arrow.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          centerTitle: true,
          title: Text('职位管理',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  wordSpacing: 1,
                  letterSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 38, 39, 1))),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index < _jobList.length) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: ItemManagetJob(
                            jobManageData: _jobList[index],
                            index: index),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageJobManageDet(_jobList[index]),
                              ));
                        });
                  }
                  return null;
                },
                itemCount: _jobList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: MaterialButton(
                    color: ColorsUtils.app_main,
                    onPressed: () {
                      if(SharepreferUtils.getBosss().realStatus == "1"){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagePostWork(),
                            ));
                      }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagePermWeb(),
                            ));
                      }
                    },
                    textColor: Colors.white,
                    child: Text("发布新职位"),
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
