import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/cuswidget/cuswidget_combar.dart';
import 'package:recruit_app/cuswidget/cuswidget_switsc.dart';


class RightSets extends StatefulWidget {
  @override
  _RightSetsState createState() => _RightSetsState();
}

class _RightSetsState extends State<RightSets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CusWidgetComBar(
        leading: 'images/pp_img_arrow_left_black.png',
        leftListener: () {
          Navigator.pop(context);
        },
        center: Text(
          '权限设置',
          style: TextStyle(
              color: Color.fromRGBO(68, 77, 151, 1),
              fontSize: ScreenUtil().setSp(36),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          CusWidgetCSwitch(
            value: true,
            onChanged: (value) {},
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(48),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(159, 199, 235, 1),
                width: ScreenUtil().setWidth(1),
              ),
            ),
            content: '允许软件访问位置信息',
            activeColor: Color.fromRGBO(105, 191, 211, 1),
          ),
          CusWidgetCSwitch(
            value: true,
            onChanged: (value) {},
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(48),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(159, 199, 235, 1),
                width: ScreenUtil().setWidth(1),
              ),
            ),
            content: '允许软件访问日历信息',
            activeColor: Color.fromRGBO(105, 191, 211, 1),
          ),
          CusWidgetCSwitch(
            value: false,
            onChanged: (value) {},
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(48),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(159, 199, 235, 1),
                width: ScreenUtil().setWidth(1),
              ),
            ),
            content: '允许软件访问相册信息',
            activeColor: Color.fromRGBO(105, 191, 211, 1),
          ),
          CusWidgetCSwitch(
            value: false,
            onChanged: (value) {},
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(48),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(159, 199, 235, 1),
                width: ScreenUtil().setWidth(1),
              ),
            ),
            content: '允许软件使用相机功能',
            activeColor: Color.fromRGBO(105, 191, 211, 1),
          ),
          CusWidgetCSwitch(
            value: false,
            onChanged: (value) {},
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(48),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(159, 199, 235, 1),
                width: ScreenUtil().setWidth(1),
              ),
            ),
            content: '允许软件使用麦克风功能',
            activeColor: Color.fromRGBO(105, 191, 211, 1),
          ),
          CusWidgetCSwitch(
            value: false,
            onChanged: (value) {},
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(48),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(159, 199, 235, 1),
                width: ScreenUtil().setWidth(1),
              ),
            ),
            content: '允许软件访问通讯录信息',
            activeColor: Color.fromRGBO(105, 191, 211, 1),
          ),
        ],
      ),
    );
  }
}
