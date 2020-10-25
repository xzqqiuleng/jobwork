import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cuswidget_dasline.dart';
import 'package:recruit_app/viewpages/utils/util_inithtml.dart';

import '../url_constant.dart';


class ItemRowCopy extends StatelessWidget {
  final Map<String,dynamic> company;
  final int index;
  final bool lastItem;

  const ItemRowCopy({Key key, this.company, this.index, this.lastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
String titlss="暂无职位招聘";

   try{

     titlss= company["jobs"][0]["title"];

   }catch(e){

   }

    final companyItem = Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(30),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(10))),
                  child: Image.network( company["company_img"] == ""?UrlConstant.deault_compay:company["company_img"] ,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setWidth(100),
                      fit: BoxFit.cover),
                ),
                SizedBox(width: ScreenUtil().setWidth(22)),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                company["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(32),
                                  color: Color.fromRGBO(20, 20, 20, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(16),
                            ),

                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(10)),
                        Text(
                          company["address"],
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setWidth(20)),
                        Row(
                          children: <Widget>[
                            Image.asset('images/pp_company_icon1.png',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setWidth(24),
                                fit: BoxFit.cover),
                            SizedBox(width: ScreenUtil().setWidth(6)),
                            Text(
                              '企业认证',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                color: Color.fromRGBO(151, 151, 151,6),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(26)),
                            Image.asset('images/pp_company_icon2.png',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setWidth(24),
                                fit: BoxFit.cover),
                            SizedBox(width: ScreenUtil().setWidth(6)),
                            Text(
                              '绿色保障',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                color: Color.fromRGBO(151, 151, 151, 1),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(26)),
                            Image.asset('images/pp_company_icon3.png',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setWidth(24),
                                fit: BoxFit.cover),
                            SizedBox(width: ScreenUtil().setWidth(6)),
                            Text(
                              '极速反馈',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                color: Color.fromRGBO(151, 151, 151, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(38)),
                      ],
                    ))
              ],
            ),
            Text(
             UtiInitlHtml.initHtml(company["company_info"].toString()),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                color: Colors.black87,
              ),
            ),
            SizedBox(height:ScreenUtil().setWidth(20) ),
            CusWidgetDashLine(
              color: Colors.black12,
              height: 0.4,
              dashWidth:2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(32),top: ScreenUtil().setWidth(20),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '热招中: ',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromRGBO(151, 151, 151, 1),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            titlss,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Colors.black54,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(22),
                  ),
                  Text(
                    company["nums"].toString(),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: ColorsUtils.app_main,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '个岗位',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Color.fromRGBO(151, 151, 151, 1),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(22),
                  ),
                  Image.asset('images/pp_img_arrow_right_blue.png',
                      width: ScreenUtil().setWidth(10),
                      height: ScreenUtil().setWidth(20),
                      fit: BoxFit.cover)
                ],
              ),
            ),
          ],
        ),
      )
     ;

//    if (lastItem) {
//      return card;
//    }
//    if (lastItem) {
//      return companyItem;
//    }
    return Column(
      children: <Widget>[
        companyItem,
        Container(
          height: 6,
          color: Color(0xfff4f4f4),

        ),
      ],
    );
  }
}
