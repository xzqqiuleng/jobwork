import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/util_event.dart';
import 'package:recruit_app/viewmodel/midtab_bean.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/jobpages/page_chatline.dart';
import 'package:recruit_app/viewpages/shareprefer_utils.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';
import 'chatitem_message.dart';
import 'listdata_notice.dart';
import 'message_job.dart';



class MessageListsNews extends StatefulWidget {



  @override
  _MessageListsNewsState createState() => _MessageListsNewsState();
}

class _MessageListsNewsState extends State<MessageListsNews> with SingleTickerProviderStateMixin {
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
                   indicatorColor: ColorsUtils.app_main,
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
                  width: ScreenUtils.width,
                  height: 96,
                  child: _buildContentTabbar()
              ),
              new Container(
                color: Colors.white,
                height:ScreenUtils.height - 96 - kBottomNavigationBarHeight-10,
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
  List<MidTabBean> topicTabMenus=List();
  int type = 0;
  StreamSubscription  _eventChangeSub;
  void _eventSub() {
    _eventChangeSub = eventBus.on<RefListEvent>().listen((event) {
      _OnRefresh();
    });
  }
  _OnRefresh(){
     //id，分为boss，用户
    new PinPinReponse().getMessageList(SharepreferUtils.getUser().userId,1).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        print(reponse);
        data.clear();

        setState(() {
         List sdata = reponse["result"];
         data.addAll(sdata);
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
    MidTabBean tabModel1 = MidTabBean(picture: "images/pp_m_icon1.png",link: "感兴趣");
    MidTabBean tabModel2 = MidTabBean(picture: "images/pp_m_icon2.png",link: "看过我的");
    MidTabBean tabModel3 = MidTabBean(picture: "images/pp_m_icon3.png",link: "智能推荐");
    MidTabBean tabModel4 = MidTabBean(picture: "images/pp_m_icon4.png",link: "职位上新");
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
            child: ListView.builder(itemBuilder: (BuildContext context,int index) {
                         return GestureDetector(
              onTap: (){
                String userId = data[index]["user_id"].toString();
                String reply_id ;
               if(userId == SharepreferUtils.getUser().userId){
                 reply_id = data[index]["reply_id"].toString();
               }else{
                 reply_id = userId;
               }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PageChatLine(user_id:SharepreferUtils.getUser().userId ,reply_id: reply_id,head_icon:data[index]["comInfo"]["company_img"],title: data[index]["comInfo"]["company_name"],type: 1,)));
              },
              behavior: HitTestBehavior.opaque,
              child:ChatItemMessage(mapData: data[index],) ,
            ) ;


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

Widget _buildMiddelBar( List<MidTabBean> topicTabMenus,BuildContext context) {
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
                        builder: (context) => MessageJob(0),
                      ));
                  break;
                case "看过我的":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageJob(1),
                      ));
                  break;
                case "智能推荐":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageJob(2),
                      ));
                  break;
                case "职位上新":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageJob(3),
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