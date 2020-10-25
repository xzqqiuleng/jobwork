
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/select_works.dart';


class PageWorsk extends StatefulWidget {
  @override
  _PageWorskState createState() => _PageWorskState();
}

class _PageWorskState extends State<PageWorsk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('选择职位类别',
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
              'images/pp_ic_back_arrow.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body:  SelectWorks(themeColor: ColorsUtils.app_main,
        locationIcon: "images/pp_select_loc.png",
        onValueChanged: (city) {
          setState(() {

          });
        },
      ),
    );
  }
}
