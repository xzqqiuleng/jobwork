import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/city_page.dart';
import 'package:recruit_app/pages/home/search_bar.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'home_headplan.dart';
import 'home_joblist.dart';



class HomePage extends StatefulWidget {
  final double _homeTopBannerHeight = 220;
  final double _homeTopicHeight = 320;
  @override
  State<StatefulWidget> createState() {

    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  List<BannerModel> topBannerDatas = [];
  List<TopicTabModel> topicTabMenus = [];


  double _navAplpha = 0.0;
  double _offset = 0.0;
  bool _mainScrollable = true;
  bool _contentScrollable = true;
  bool _autoScroll = false;
  bool _isTabbarItemClick = false;
  bool _isNavgationBarHidden = false;
  bool isScrool=false;
  String city = "全国";
  void _rightTabItemPressed()async {
    String mcity= await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CityPage()));
    if(mcity != null && !mcity.isEmpty){
      setState(() {
        city = mcity.toString().split("|")[1];
      });
    }
  }

  void _leftTabItemPressed() {

    if (_isTabbarItemClick) {
      _isTabbarItemClick = false;
    }

    scrollController.animateTo(0.0,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    setState(() {
      isScrool = false;
      this._mainScrollable = true;
      this._contentScrollable = false;
      this._offset = (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5;
    });
    this._autoScroll =true;
  }

  void _statuTabbarItemPressed(int) {
    _isTabbarItemClick = true;

    scrollController.animateTo((widget._homeTopicHeight - Screen.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    setState(() {
      this._mainScrollable = false;
      this._contentScrollable =true;
      this._offset = (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5;
    });
    this._autoScroll = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _mainScrollable =true;
    _contentScrollable =false;
    // 滚动视图添加监听
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (_navAplpha != 0) {
          setState(() {
            _navAplpha = 0;
          });
        }

        setState(() {
          _isNavgationBarHidden = true;
        });
      } else if (offset < widget._homeTopBannerHeight) {
        setState(() {
          _isNavgationBarHidden = false;
          _navAplpha = 1 - (widget._homeTopBannerHeight - offset) / widget._homeTopBannerHeight;
           if(_navAplpha >=0.5){
             _navAplpha = 1;
             isScrool = true;
           }
        });
      } else if (_navAplpha != 1) {
        setState(() {
          _isNavgationBarHidden = false;
          _navAplpha = 1;
        });
      }

      if (offset > (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5) {
          setState(() {
            this._mainScrollable = false;
            this._contentScrollable =true;
            this._offset = (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5;
          });
          scrollController.animateTo((widget._homeTopicHeight - Screen.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
        } else {

          if (this._autoScroll) {
            this._autoScroll = false;
          } else {
            if (!_isTabbarItemClick) {
              setState(() {
                this._offset = offset;
              });
            }
          }

        }

    });

    fetchData();
  }

  fetchData()  {

      setState(() {

        if(StorageManager.sharedPreferences.getString("open_status")  == "1"){
          if(StorageManager.sharedPreferences.getString("two").isNotEmpty){
            List banners = json.decode(StorageManager.sharedPreferences.getString("two"));
            for(var item in banners){
              BannerModel bannerModel1 = BannerModel(imageUrl: item["img_url"],link: item["link_url"],go_type: item["go_type"]);
              this.topBannerDatas.add(bannerModel1);
            }
          }else{
            BannerModel bannerModel1 = BannerModel(imageUrl: "images/banner1.jpg");
            BannerModel bannerModel2 = BannerModel(imageUrl: "images/banner2.jpg");
            this.topBannerDatas.add(bannerModel1);
            this.topBannerDatas.add(bannerModel2);
          }
        }else{
          BannerModel bannerModel1 = BannerModel(imageUrl: "images/banner1.jpg");
          BannerModel bannerModel2 = BannerModel(imageUrl: "images/banner2.jpg");
          this.topBannerDatas.add(bannerModel1);
          this.topBannerDatas.add(bannerModel2);
        }




        TopicTabModel tabModel1 = TopicTabModel(picture: "images/home_tab1.png",link: "职位库");
        TopicTabModel tabModel2 = TopicTabModel(picture: "images/home_tab2.png",link: "找工作");
        TopicTabModel tabModel3 = TopicTabModel(picture: "images/home_tab3.png",link: "急聘");
        TopicTabModel tabModel4 = TopicTabModel(picture: "images/home_tab4.png",link: "官方保障");
        this.topicTabMenus.add(tabModel1);
        this.topicTabMenus.add(tabModel2);
        this.topicTabMenus.add(tabModel3);
        this.topicTabMenus.add(tabModel4);

      });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  Widget _buildHeadPlanContent() {
    return HomeHeadPlan(bannerDatas: topBannerDatas,topicTabMenus: topicTabMenus, height: widget._homeTopicHeight,bannerHeight: widget._homeTopBannerHeight);
  }



  Widget _buildContent() {

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      primary: false,
      physics: _mainScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics() ,
      slivers: <Widget>[
        new SliverToBoxAdapter(
          child: new Listener(
          onPointerUp: _scrollCancel,
          child: new Stack(
            children: <Widget>[
              Positioned(
                top: this._offset < 0 ? -this._offset : 0.0,
                child: _buildHeadPlanContent(),
              ),
              Padding(
                padding: EdgeInsets.only(top: widget._homeTopicHeight - this._offset),
                  child: HomeJobList(
                    contentScrollable: _contentScrollable,
                    tabbarItemClick: _statuTabbarItemPressed,
                     isScrool:  isScrool,
                  ),
              )
            ],
          ) ,
        ),
        ),
      ],
    );


  }

  Widget _buildNavBar() {
    return new Container(
            height: Screen.navigationBarHeight,
            child: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white.withOpacity(_navAplpha),
              elevation: _navAplpha == 1 ? 0.2: 0.0,
              leading: _mainScrollable ? null: new IconButton(
                icon: Image.asset('images/top.png',
                  width: 40,
                  height: 40,
                ),
                onPressed: _leftTabItemPressed,
              ),
              titleSpacing: _mainScrollable ? 7.0 : 0.0,
              centerTitle: true,
              title: _isNavgationBarHidden ? null: SearchBar('images/icon_home_search_20x20_@3x.png',height: 32,
                backgroudColor: Color.lerp(Colors.white, Colors.black12, _navAplpha),txt: "职位快速搜索",
              ),
              actions: _isNavgationBarHidden ? null: <Widget>[
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: _rightTabItemPressed,
                  child: Row(
                    children: <Widget>[


                      Image.asset('images/top_local.png',
                          width: 16,
                          height: 16,
                          color: Color.lerp(Colors.white, Colors.black87, _navAplpha)),
                      SizedBox(
                        width:4,
                      ),
                      Center(
                          child:  Text(
                            city,
                            style: TextStyle(
                              color: Color.lerp(Colors.white, Colors.black87, _navAplpha),
                              fontSize: 16
                            ),
                          )
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ),

                SizedBox(
                  width: 16,
                ),

              ],
              bottomOpacity: 0,
            )
          );
  }

  void _scrollCancel(detail) {

      _scrollRelease();
  }

  void _scrollRelease() {
    var offset = scrollController.offset;
    // print('offset :' + offset.toString());
    if (offset < (widget._homeTopicHeight - Screen.navigationBarHeight) * 0.25) {
      if (offset > 0) {
        scrollController.animateTo(0.0,duration: new Duration(milliseconds: 300),curve: Curves.linear);
      }
    } else {
      setState(() {
        this._mainScrollable = false;
        this._contentScrollable =true;
      });
      scrollController.animateTo((widget._homeTopicHeight - Screen.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    }
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            top: 0.0,
            child: _buildContent(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: _buildNavBar()
          )

        ],
      ),
    );
  }
}

class Choice {
  const Choice({ this.title, this.icon, this.position});
  final String title;
  final int position;
  final IconData icon;
}