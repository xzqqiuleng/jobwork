import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../colours.dart';

class FeedDetai extends StatelessWidget {
  Map data;
  FeedDetai(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

          elevation: 0,
          centerTitle: true,
          title: Text("详情",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  wordSpacing: 1,
                  letterSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 38, 39, 1))),
          leading: IconButton(
              icon: Image.asset(
                'images/ic_back_arrow.png',
                width: 16,
                height: 16,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,

        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            child: Container(
              margin: EdgeInsets.all( ScreenUtil().setWidth(30)),
              decoration: new BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: new BorderRadius.circular(
                  ScreenUtil().setWidth(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setWidth(20),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                      Expanded(
                        child: Text(
                          data["title"] == null|| data["title"] == "" ? "公司审核失败": data["title"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: ScreenUtil().setSp(32),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(20),
                  ),
                  Container(
                    color: Colors.grey,
                    height: ScreenUtil().setWidth(0.2),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(20),
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                    child: Text(
                      data["content"] == null|| data["content"] == ""?"公司信息填写不合规，请重新填写":data["content"] ,
                      style: TextStyle(
                        height: 1.5,
                        color: Color.fromRGBO(95, 94, 94, 1),
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ),
                  data["img"] != null ? Image.network( data["img"] ):Text(""),
                  SizedBox(
                    height: ScreenUtil().setWidth(20),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(30), ScreenUtil().setWidth(20)),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(6)),
                        color: Colours.app_main.withOpacity(0.1)
                    ),
                    child: Text(
                      data["feed_content"],
                      style: TextStyle(
                        height: 1.5,
                        color: Colours.app_main,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
            elevation: 0,

          ),
          SizedBox(
            height: ScreenUtil().setWidth(15),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: Text(
              data["feed_time"],
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black87,

              ),
            ),
          )

        ],
      )
    );
  }
}
