import 'package:flutter/material.dart';
import 'package:recruit_app/widgets/choidcclip.dart';

class Fuli extends StatefulWidget {
  @override
  _FuliState createState() => _FuliState();
}

class _FuliState extends State<Fuli> {
  List<String>  all = ["五险一金","餐饮补贴","年终奖金","绩效奖金","专业培训","定期体检","节日福利","定期团建","公司福利"];
  List<String> select=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("福利待遇",
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
              Navigator.of(context).pop();
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/complete.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop(select);
              }),
        ],
      ),
      body:Container(
        height: 240,
        alignment: Alignment.center,
        child: MultipleChoiceeChipWidget(strings:all,selectList:select,onChanged:(selectListval){
          print(selectListval.length);
          setState(() {
            select=selectListval;
          });
        }
      )  ),
    );
  }
}
