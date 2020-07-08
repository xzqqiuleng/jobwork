import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/utils/screen.dart';


class HomeJobList extends StatefulWidget {
  final bool contentScrollable;
  final ValueChanged<int> tabbarItemClick;
  final bool isScrool;



  HomeJobList({Key key,this.contentScrollable,this.tabbarItemClick,this.isScrool}) : super(key:key);

  @override
  _HomeJobListState createState() => _HomeJobListState();
}

class _HomeJobListState extends State<HomeJobList> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabMenus = <Tab> [
    new Tab(text: '推荐'),
    new Tab(text: '最新'),
    new Tab(text: '热招'),
  ];
  List _recommandJobs = [];
  List _newsJobs = [];
  List _newshotJobs = [];

   int _currentPosition = 0;

   void _onTabbarItemPressed(index) {
     widget.tabbarItemClick(index);
   }

   Widget _buildTabViewContent() {
    return new TabBarView(children:  [
        JobBodyList(widget.isScrool,0),
     JobBodyList(widget.isScrool,1),
     JobBodyList(widget.isScrool,2),
     ],
            controller: _tabController,
          );
  }

  Widget _buildContentTabbar() {
   return new Column(
     mainAxisAlignment: MainAxisAlignment.end,
     children: <Widget>[
       new Container(

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
       new Container(
         height: 0.8,
         color: new Color.fromARGB(255, 242, 242, 245),
       )
     ],
   );
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
                  height: kBottomNavigationBarHeight,
                  child: _buildContentTabbar()
              ),
              new Container(
                color: Colors.white,
                height:Screen.height - Screen.navigationBarHeight - kBottomNavigationBarHeight*2,
                child: DefaultTabController(
                  length: _tabMenus.length,
                  child: _buildTabViewContent(),
                )
              )
          ],
        );
  }
}