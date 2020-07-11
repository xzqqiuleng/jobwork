import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/home/search_bar.dart';

import '../city_page.dart';

class JobLocSelelct extends StatefulWidget{
  @override
  _JobLocSelectState createState() {
    // TODO: implement createState
  return _JobLocSelectState();
  }

}

class _JobLocSelectState extends State<JobLocSelelct>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       elevation: 0,
       centerTitle: true,
       title: Text('',
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
     body: Column(
       children: <Widget>[
         SizedBox(height: 30),
         Text("请填写你期望的工作岗位",
           style: TextStyle(
             color: Colors.black87,
             fontWeight: FontWeight.bold,
             fontSize: 24

           ),
         ),
         SizedBox(height: 10),
         Text("以便我们精准推荐",
           style: TextStyle(
               color: Colors.black38,
               fontSize: 16
           ),
         ),
         SizedBox(height: 60),
         Padding(
             padding: EdgeInsets.symmetric(horizontal: 40),
             child:GestureDetector(
               behavior: HitTestBehavior.opaque,
               onTap: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => CityPage()));
               },
               child: SearchBar('images/icon_home_search_20x20_@3x.png',height: 38,
                 backgroudColor: Colours.app_main.withOpacity(0.1),txt: "选择你期望的职位",
               ),
             )
         )
         ,
         SizedBox(height: 20),
         Padding(
             padding: EdgeInsets.symmetric(horizontal: 40),
             child:GestureDetector(
               behavior: HitTestBehavior.opaque,
               onTap: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => CityPage()));
               },
               child:SearchBar('images/icon_home_search_20x20_@3x.png',height: 38,
                 backgroudColor: Colours.app_main.withOpacity(0.1),txt: "武汉",
               ) ,
             )
         )
         ,
         SizedBox(height: 60),
         CustomBtnWidget(
           text: "开始查找",
           btnColor: Colours.app_main,
           onPressed: null
         )
       ],
     ),
   );
  }

}