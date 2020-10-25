import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colors_utils.dart';


class ItemsNotify extends StatelessWidget {
  const ItemsNotify({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setWidth(48),
        ),
        Material(
          child: Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: new BorderRadius.circular(
                ScreenUtil().setWidth(20),
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
                      width: ScreenUtil().setWidth(54),
                    ),
                    Expanded(
                      child: Text(
                        '系统通知',
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
                      width: ScreenUtil().setWidth(15),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
//                      onTap: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotifyDetail()));
//                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '查看详情',
                            style: TextStyle(
                              color: ColorsUtils.app_main,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(12),
                          ),
                          Image.asset(
                            'images/pp_img_arrow_right_blue.png',
                            width: ScreenUtil().setWidth(10),
                            height: ScreenUtil().setWidth(20),
                            color: ColorsUtils.app_main,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(54),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(20),
                ),
                Container(
                  color: Colors.grey,
                  height: ScreenUtil().setWidth(1),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(54),
                    right: ScreenUtil().setWidth(54),
                    top: ScreenUtil().setWidth(48),
                    bottom: ScreenUtil().setWidth(50),
                  ),
                  child: Text(
                    '欢迎注册本APP，海量求职信息每日更新，并且官方将根据你的简历，进行私人定制，为你推荐最符合你的职位。',
                    style: TextStyle(
                      height: 1.5,
                      color: Color.fromRGBO(95, 94, 94, 1),
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 3,
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(20),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setWidth(15),
        ),
        Text(
          '2020年7月27号 11:30',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(22),
            color: Color.fromRGBO(176, 181, 180, 1),
          ),
        ),
      ],
    );
  }
}
