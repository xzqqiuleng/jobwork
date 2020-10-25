
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';

import '../util_event.dart';
import 'jobpages/jobcon/slecet_city.dart';


class PageSelcity extends StatefulWidget {
  @override
  _PageSelcityState createState() => _PageSelcityState();
}

class _PageSelcityState extends State<PageSelcity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('选择城市',
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
      body:  SelectCCitys(themeColor: ColorsUtils.app_main,
        locationIcon: "images/pp_select_loc.png",
        onValueChanged: (city) {
            Navigator.of(context).pop(city);
            eventBus.fire(CitySelEvent(city));
            print(city);
        },
      ),
    );
  }
}
