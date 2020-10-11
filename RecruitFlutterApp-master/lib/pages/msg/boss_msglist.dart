import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/event_bus.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/jobs/chat_room.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/msg/msg_job.dart';
import 'package:recruit_app/pages/msg/msg_resume.dart';
import 'package:recruit_app/pages/msg/notice_list.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'package:recruit_app/widgets/slide_button.dart';

import '../JobPage.dart';
import 'msg_chat_item.dart';



class BossMessageList extends StatefulWidget {



  @override
  _BossMessageListState createState() => _BossMessageListState();
}

class _BossMessageListState extends State<BossMessageList> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabMenus = <Tab> [
    new Tab(text: '互动'),
    new Tab(text: '通知'),
  ];


   int _currentPosition = 0;

   void _onTabbarItemPressed(index) {
//     final ValueChanged<int> tabbarItemClick;
   }

   Widget _buildTabViewContent() {
    return new TabBarView(children:  [
      CompanyBodyList(),
      XTList(),
     ],
            controller: _tabController,
          );
  }

  Widget _buildContentTabbar() {
   return Scaffold(
       body:Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: <Widget>[
       Container(
         color: Colors.white,
         height: 20,
       ),
       Container(
         color: Colors.white,
         padding: EdgeInsets.symmetric(
           horizontal: ScreenUtil().setWidth(24),
           vertical: ScreenUtil().setWidth(24),
         ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Expanded(
              child: new Container(
                 child:new TabBar(
                   tabs: _tabMenus,
                   onTap: _onTabbarItemPressed,
                   controller: _tabController,
                   isScrollable: true,
                   indicatorSize: TabBarIndicatorSize.label,
                   indicatorColor: Colours.app_main,
                   indicatorWeight: 4.0,
                   indicatorPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                   labelColor: Colors.black87,
                   labelPadding: new EdgeInsets.only(left: 16.0,right: 16.0),
                   labelStyle: new TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,fontFamily: ""),
                   unselectedLabelColor: Colors.black54,
                   unselectedLabelStyle: new TextStyle(fontSize: 16.0),
                 ),
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 10),
               ),
             ),


           ],
         ),
       ),

       new Container(
         height: 0.8,
         color: new Color.fromARGB(255, 242, 242, 245),
       )
     ],
   ) )
   ;
 }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    _tabController = new TabController(vsync: this,length: _tabMenus.length);
    //判断TabBar是否切换
    _tabController.addListener(() {
      setState(() {
          _currentPosition = _tabController.index;
      }); 
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
          children: <Widget>[
              new Container(
                  color: Colors.white,
                  width: Screen.width,
                  height: 96,
                  child: _buildContentTabbar()
              ),
              new Container(
                color: Colors.white,
                height:Screen.height - 96 - kBottomNavigationBarHeight-10,
                child: DefaultTabController(
                  length: _tabMenus.length,
                  child: _buildTabViewContent(),
                )
              )
          ],
        );
  }
}
class CompanyBodyList extends StatefulWidget{

  CompanyBodyList();
  @override
  _CompanyBodyListState createState() {
    // TODO: implement createState
    return _CompanyBodyListState();
  }

}

class _CompanyBodyListState extends State<CompanyBodyList> with AutomaticKeepAliveClientMixin{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int sortId;
  List data =List();
  List<TopicTabModel> topicTabMenus=List();
  int type = 0;
  StreamSubscription  _eventChangeSub;
  void _eventSub() {
    _eventChangeSub = eventBus.on<RefreshEvent>().listen((event) {
      _OnRefresh();
    });
  }
  _OnRefresh(){
     //id，分为boss，用户
    new MiviceRepository().getMessageList(ShareHelper.getBosss().userId,0).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        print(reponse);
        data.clear();

        setState(() {
          data = reponse["result"];
        });

        _refreshController.refreshCompleted();
      }
    });
  }
  _loadMore(){
    _refreshController.loadComplete();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventSub();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventChangeSub.cancel();
  }
  @override
  Widget build(BuildContext context) {
    topicTabMenus.clear();
    TopicTabModel tabModel1 = TopicTabModel(picture: "images/m_icon1.png",link: "感兴趣");
    TopicTabModel tabModel2 = TopicTabModel(picture: "images/m_icon2.png",link: "看过我的");
    TopicTabModel tabModel3 = TopicTabModel(picture: "images/m_icon3.png",link: "智能推荐");
    TopicTabModel tabModel4 = TopicTabModel(picture: "images/m_icon4.png",link: "职位上新");
    this.topicTabMenus.add(tabModel1);
    this.topicTabMenus.add(tabModel2);
    this.topicTabMenus.add(tabModel3);
    this.topicTabMenus.add(tabModel4);

    // TODO: implement build
    return Flex(
      direction:Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 0,
child: _buildMiddelBar(topicTabMenus,context),
        ),
      Expanded(

        child: SmartRefresher(

            header: WaterDropHeader(),
            footer: ClassicFooter(),
            controller: _refreshController,
            onRefresh: _OnRefresh,
            onLoading: _loadMore,
            enablePullUp: true,
            child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          if (data.length >0 ) {
            return GestureDetector(
              onTap: (){
                String userId = data[index]["user_id"].toString();
                String reply_id ;
                if(userId == ShareHelper.getBosss().userId){
                  reply_id = data[index]["reply_id"].toString();
                }else{
                  reply_id = userId;
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatRoom(user_id:ShareHelper.getBosss().userId ,reply_id: reply_id,head_icon:data[index]["userInfo"]["head_img"],title: data[index]["userInfo"]["user_name"],type: 0,)));
              },
              behavior: HitTestBehavior.opaque,
              child:BossChatItem(mapData: data[index],) ,
            ) ;
          }else{
            return Text("");
          }

            },

              itemCount: data.length,
            )
        )
      )

      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

Widget _buildMiddelBar( List<TopicTabModel> topicTabMenus,BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: topicTabMenus.map((model){
        return Expanded(
          flex: 1,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:(){
              switch(model.link){
                case "感兴趣":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgResume(0),
                      ));
                  break;
                case "看过我的":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgResume(1),
                      ));
                  break;
                case "智能推荐":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgResume(2),
                      ));
                  break;
                case "职位上新":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgResume(3),
                      ));
                  break;
              }
            },
            child:new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  width: 46,
                  height: 46,
                  image: AssetImage(model.picture),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  model.link,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                  ),
                )
              ],

            ),
          )
        );
      }).toList(),
    ),
  );
}
class BossChatItem extends StatefulWidget {

  final  Map mapData;
  const BossChatItem({Key key,this.mapData}) : super(key: key);

  @override
  _BossChatItemState createState() => _BossChatItemState();
}

class _BossChatItemState extends State<BossChatItem> {
  String msg="";
  @override
  Widget build(BuildContext context) {
    if( widget.mapData["msg"].contains("state")&& widget.mapData["msg"].contains("msg")&& widget.mapData["msg"].contains("type")&& widget.mapData["msg"].contains("userId")){
      msg = "Boss，人才交换消息";
    }else{
       msg=widget.mapData["msg"];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(38),
              left: ScreenUtil().setWidth(48),
              right: ScreenUtil().setWidth(48),
              bottom: ScreenUtil().setWidth(38),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(44))),
                            child: Image.network(widget.mapData["userInfo"]["head_img"],
                                width: ScreenUtil().setWidth(88),
                                height: ScreenUtil().setWidth(88),
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 0,
                            child:Offstage(
                              offstage: widget.mapData["unread_num"].toString()=="0"?true:false ,
                              child:Container(
                                alignment: Alignment.center,
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.redAccent
                                ),
                                child: Text(
                                  widget.mapData["unread_num"].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            )
                          ),
                      ],
                     ),
                SizedBox(width: ScreenUtil().setWidth(32)),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      widget.mapData["userInfo"]["user_name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(36),
                                        color: Color.fromRGBO(20, 20, 20, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(16),
                                  ),
                                  Text(
                                    '离线',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(24),
                                      color: Color.fromRGBO(176, 181, 180, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(16),
                            ),
                            Text(
                              widget.mapData["pub_time"].toString().split(" ")[0],
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(12)),
                        SizedBox(height: ScreenUtil().setWidth(14)),
                        Text(
                          msg,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),

        Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            height: ScreenUtil().setWidth(4)),
      ],
    );
  }

  InkWell buildAction(
      GlobalKey<SlideButtonState> key, Color color, GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(116),
        color: color,
        child: Image.asset(
          'images/img_del_white.png',
          width: ScreenUtil().setWidth(30),
          height: ScreenUtil().setWidth(38),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
