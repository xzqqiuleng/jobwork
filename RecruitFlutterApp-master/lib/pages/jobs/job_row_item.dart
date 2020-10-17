import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_list.dart';
import 'package:recruit_app/pages/utils/gaps.dart';
import 'package:recruit_app/widgets/dash_line.dart';

import '../constant.dart';

class JobRowItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;
  final bool isJi;
  final bool isBz;

  const JobRowItem({Key key, this.job, this.index, this.lastItem,this.isJi,this.isBz})
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
      return ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(28)),
        child: Image.network(
          Constant.deault_compay,
          width: ScreenUtil().setWidth(56),
          height: ScreenUtil().setWidth(56),
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobItem =  Padding(
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
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
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
                fontSize: ScreenUtil().setSp(26),
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
                      fontSize: ScreenUtil().setSp(26),
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(16),
                ),
               Text("·"),
                SizedBox(
                  width: ScreenUtil().setWidth(16),
                ),
               Container(
                 alignment: Alignment.centerRight,
                  child: Text(
                    job["pub_date"].toString(),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(26),
                      color: Colors.black54,
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
                  width: ScreenUtil().setWidth(26),
                  height: ScreenUtil().setWidth(26),
                  fit: BoxFit.cover,
                ),

                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Flexible(
                  child: Text(
                    job["company"].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Color.fromRGBO(57, 57, 57, 1),
                    ),
                  ),
                ),



              ],
            ),
          ],
        ),
      );


//    if (lastItem) {
//      return jobItem;
//    }
    return Column(
      children: <Widget>[
        jobItem,
     Gaps.line4,
      ],
    );
  }
}
