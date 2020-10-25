import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/maputli.dart';


class CustDialogMap extends Dialog {
  double Lat;
  double lng;
 CustDialogMap(this.Lat,this.lng);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      right: ScreenUtil().setWidth(30),
                      top: ScreenUtil().setWidth(20),
                    ),
                    child: Text(
                      "可选择下列地图",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenUtil().setSp(26),
                      ),
                    ),
                  ),
                  Container(

                    height: ScreenUtil().setWidth(10),

                  ),
                  Column(
                    children: <Widget>[
                       GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                            ),
                            alignment: Alignment.center,
                            height: ScreenUtil().setWidth(90),
                            child: Text(
                              "百度地图",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorsUtils.app_main,
                                fontSize: ScreenUtil().setSp(34),
                              ),
                            ),
                          ),
                          onTap:() async{
                           MapUtil.gotoBaiduMap(lng,Lat);
                            Navigator.of(context).pop();
                          }),


                      Container(
                        width:double.infinity,
                        height: 0.4,
                        color: Color.fromRGBO(177, 177, 179, 1),
                      ),

                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                            ),
                            alignment: Alignment.center,
                            height: ScreenUtil().setWidth(90),
                            child: Text(
                              "高德地图",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorsUtils.app_main,
                                fontSize: ScreenUtil().setSp(34),
                              ),
                            ),
                          ),
                          onTap: () async{
                            MapUtil.gotoAMap(lng,Lat);
                            Navigator.of(context).pop();
                          }),

                      Container(
                        width:double.infinity,
                        height: 0.4,
                        color: Color.fromRGBO(177, 177, 179, 1),
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30),
                          ),
                          alignment: Alignment.center,
                          height: ScreenUtil().setWidth(90),
                          child: Text(
                            "腾讯地图",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsUtils.app_main,
                              fontSize: ScreenUtil().setSp(34),
                            ),
                          ),
                        ),
                        onTap: () async{
                          MapUtil.gotoTencentMap(lng,Lat);
                          Navigator.of(context).pop();
                        }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
