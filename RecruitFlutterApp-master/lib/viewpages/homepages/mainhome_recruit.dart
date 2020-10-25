import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/util_event.dart';
import 'package:recruit_app/viewmodel/model_idenss.dart';
import 'package:recruit_app/viewpages/bosspages/infor_boss.dart';
import 'package:recruit_app/viewpages/bosspages/page_postwork.dart';
import 'package:recruit_app/viewpages/comppages/comp_joblistp.dart';
import 'package:recruit_app/viewpages/empye/listdata_emp.dart';
import 'package:recruit_app/viewpages/homepages/page_allhome.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/message/meseagelist_new.dart';
import 'package:recruit_app/viewpages/message/msgpage_boss.dart';
import 'package:recruit_app/viewpages/mine/minepage.dart';
import 'package:recruit_app/viewpages/provider/provider_update.dart';
import 'package:web_socket_channel/io.dart';

import '../page_norweb.dart';
import '../page_permweb.dart';
import '../shareprefer_utils.dart';
import '../storage_manager.dart';

class MainHomeRecruit extends StatefulWidget {
  @override
  _RecruitHomeState createState() {
    // TODO: implement createState
    return _RecruitHomeState();
  }
}

class _RecruitHomeState extends State<MainHomeRecruit> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _bossWidget = <Widget>[
    ListDataEmp(),
    MsgPageBoss(),
    InforBoss(),
  ];




  static List<Widget> _widgetOptions = <Widget>[
    PageAllHome(),
    CompJobListp(),
    MessageListsNews(),
    MinePage(),
  ];

  List<BottomNavigationBarItem> getBossBottoms(){
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b5.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b5on.png',
            color: ColorsUtils.app_main,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: Text('人才'),
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Badge(
              showBadge: isSHowRead,
              badgeContent: Text(unread,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),),
              child: Image.asset(
                'images/pp_b3.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            )
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Badge(
            showBadge: isSHowRead,
            badgeContent: Text(unread,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
            child: Image.asset(
              'images/pp_b3on.png',
              color: ColorsUtils.app_main,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text('消息'),
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b4.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b4on.png',
            color: ColorsUtils.app_main,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: Text('我的'),
      ),
    ];

  }
  List<BottomNavigationBarItem> getBottoms(){

    return   <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b1.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b1on.png',
            color: ColorsUtils.app_main,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: Text('职位'),
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b2.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b2on.png',
            color: ColorsUtils.app_main,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: Text('公司'),
      ),
      BottomNavigationBarItem(
        icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Badge(
              showBadge: isSHowRead,
              badgeContent: Text(unread,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),),
              child: Image.asset(
                'images/pp_b3.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            )
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Badge(
            showBadge: isSHowRead,
            badgeContent: Text(unread,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
            child: Image.asset(
              'images/pp_b3on.png',
              color: ColorsUtils.app_main,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text('消息'),
      ),

      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b4.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/pp_b4on.png',
            color: ColorsUtils.app_main,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: Text('我的'),
      ),
    ];
  }




//  void _onItemTapped(int index) {
//    setState(() {
//      _selectedIndex = index;
//    });
//  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  channel.sink.close();
  }
  IOWebSocketChannel channel;
  bool isSHowRead = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userId;
    if(SharepreferUtils.isBossLogin()){
      userId = SharepreferUtils.getBosss().userId;
    }else{
      userId = SharepreferUtils.getUser().userId;
    }
    channel = IOWebSocketChannel.connect("${PinPinReponse.unreadsocketUrl}$userId");

    channel.stream.listen((message) {
      setState(() {
         unread = message;
         if(unread == "0"){
           isSHowRead = false;
         }else{
           isSHowRead = true;
         }
         eventBus.fire(RefListEvent(true));
      });

    });
    checkAppUpdate(context);
  }
  String unread="0";

  @override
  Widget build(BuildContext context) {
    Map map;
    if(StorageManager.sharedPreferences.getString("open_status")  == "1"){
      if(StorageManager.sharedPreferences.getString("two").isNotEmpty){
        map = json.decode(StorageManager.sharedPreferences.getString("two"))[0];
      }
    }


    return   Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Consumer<ModelIdenss>(builder: (context, model, child) {
              return model.identity == Identity.boss
                  ? _bossWidget.elementAt(model.selectedIndex)
                  : _widgetOptions.elementAt(model.selectedIndex);
            }),
          ),
          Positioned(
            bottom: 10,
            left: 16,
            child:GestureDetector(
              onTap: (){
                if(map == null){
                  return;
                }
                if(map["go_type"] == "app"){
                  downloadUrlApp(context,map["link_url"]);

                }else{

                  Navigator.push(context,MaterialPageRoute(builder: (context)=>PageNorweb(map["link_url"])));

                }
              },
              child:map == null? Container():Image.network(map["img_url"],width: 60,height: 60,fit: BoxFit.cover,)
            )
          )
        ],
      ),
      bottomNavigationBar: Consumer<ModelIdenss>(
        builder: (context, model, child) {
          return BottomNavigationBar(
            items:
            model.identity == Identity.boss ? getBossBottoms() : getBottoms(),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            currentIndex: model.selectedIndex,
            unselectedItemColor: Color.fromRGBO(67, 67, 67, 1),
            selectedItemColor: Color.fromRGBO(52, 52, 52, 1),
            selectedFontSize: 13,
            unselectedFontSize: 12,
            onTap: (index) {
              model.changeSelectTap(index);
            },
          );
        },

      ),
 floatingActionButton:  Consumer<ModelIdenss>(
     builder: (context, model, child) {
       return model.identity == Identity.boss ?new FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: (){
       if(SharepreferUtils.getBosss().realStatus == "1"){
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => PagePostWork(),
             ));
       }else{
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => PagePermWeb(),
             ));
       }
    },
    heroTag: null,
    foregroundColor: Colors.white,
    backgroundColor: ColorsUtils.app_main,
    elevation: 7.0,
    highlightElevation: 14.0,
    ):Text("");
    })

       );
  }
}