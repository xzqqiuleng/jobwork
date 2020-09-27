import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/utils/gaps.dart';

class ZSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('福利招商',
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
              width: 20,
              height: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/zs.png"),
            Gaps.vGap32,
            Text("1.工厂直招合作",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            Gaps.vGap10,
            Text("2.人才中介合作",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            Gaps.vGap10,
            Text("3.学生代理合作",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colours.app_main
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("如果有招商意向，请通过下面邮箱联系我们",style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,

                  ),),
                  Text("yyaso0236@18hrzp.net",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
