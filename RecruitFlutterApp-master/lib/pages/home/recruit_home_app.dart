import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/event_bus.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/boss/boss.dart';
import 'package:recruit_app/pages/boss/work_post.dart';
import 'package:recruit_app/pages/companys/company_jobslist.dart';
import 'package:recruit_app/pages/companys/company_list.dart';
import 'package:recruit_app/pages/employe/employe_list.dart';
import 'package:recruit_app/pages/home/home_page.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/mine/me.dart';
import 'package:recruit_app/pages/msg/agreement_detail.dart';
import 'package:recruit_app/pages/msg/boss_msglist.dart';
import 'package:recruit_app/pages/msg/msg_list.dart';
import 'package:recruit_app/pages/msg/new_msglist.dart';
import 'package:recruit_app/pages/permision_web.dart';
import 'package:recruit_app/pages/provider/app_update.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/pages/web_page.dart';
import 'package:web_socket_channel/io.dart';

class RecruitHomeApp extends StatefulWidget {
  @override
  _RecruitHomeState createState() {
    // TODO: implement createState
    return _RecruitHomeState();
  }
}

class _RecruitHomeState extends State<RecruitHomeApp> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _bossWidget = <Widget>[
    EmployeeList(),
    BossMessageList(),
    BossMine(),
  ];




  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CompanyJobList(),
    NewMessageList(),
    Mine(),
  ];

  List<BottomNavigationBarItem> getBossBottoms(){
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/b5.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/b5on.png',
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
                'images/b3.png',
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
              'images/b3on.png',
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
            'images/b4.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/b4on.png',
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
            'images/b1.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/b1on.png',
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
            'images/b2.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/b2on.png',
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
                'images/b3.png',
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
              'images/b3on.png',
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
            'images/b4.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/b4on.png',
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
    if(ShareHelper.isBossLogin()){
      userId = ShareHelper.getBosss().userId;
    }else{
      userId = ShareHelper.getUser().userId;
    }
    channel = IOWebSocketChannel.connect("${MiviceRepository.unreadsocketUrl}${userId}");

    channel.stream.listen((message) {
      setState(() {
         unread = message;
         if(unread == "0"){
           isSHowRead = false;
         }else{
           isSHowRead = true;
         }
         eventBus.fire(RefreshEvent(true));
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
            child: Consumer<IdentityModel>(builder: (context, model, child) {
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

                  Navigator.push(context,MaterialPageRoute(builder: (context)=>WebPage(map["link_url"])));

                }
              },
              child:map == null? Container():Image.network(map["img_url"],width: 60,height: 60,fit: BoxFit.cover,)
            )
          )
        ],
      ),
      bottomNavigationBar: Consumer<IdentityModel>(
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
 floatingActionButton:  Consumer<IdentityModel>(
     builder: (context, model, child) {
       return model.identity == Identity.boss ?new FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: (){
       if(ShareHelper.getBosss().realStatus == "1"){
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => WorkPost(),
             ));
       }else{
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => PermissionWeb(),
             ));
       }
    },
    heroTag: null,
    foregroundColor: Colors.white,
    backgroundColor: Colours.app_main,
    elevation: 7.0,
    highlightElevation: 14.0,
    ):Text("");
    })

       );
  }
}