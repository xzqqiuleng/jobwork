import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/model_top_banner.dart';
import 'package:recruit_app/viewmodel/midtab_bean.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';
import '../page_selcity.dart';
import '../storage_manager.dart';
import 'item_hhead.dart';
import 'item_hjobslist.dart';
import 'item_searchbar.dart';



class PageAllHome extends StatefulWidget {
  final double _homeTopBannerHeight = 220;
  final double _homeTopicHeight = 320;
  @override
  State<StatefulWidget> createState() {

    return _PageAllHomeState();
  }
}

class _PageAllHomeState extends State<PageAllHome> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  List<ModelTopBanner> topBannerDatas = [];
  List<MidTabBean> topicTabMenus = [];


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
            builder: (context) => PageSelcity()));
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
      this._offset = (widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5;
    });
    this._autoScroll =true;
  }

  void _statuTabbarItemPressed(int) {
    _isTabbarItemClick = true;

    scrollController.animateTo((widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    setState(() {
      this._mainScrollable = false;
      this._contentScrollable =true;
      this._offset = (widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5;
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

      if (offset > (widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5) {
          setState(() {
            this._mainScrollable = false;
            this._contentScrollable =true;
            this._offset = (widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5;
          });
          scrollController.animateTo((widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
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
              ModelTopBanner bannerModel1 = ModelTopBanner(imageUrl: item["img_url"],link: item["link_url"],go_type: item["go_type"]);
              this.topBannerDatas.add(bannerModel1);
            }
          }else{
            ModelTopBanner bannerModel1 = ModelTopBanner(imageUrl: "images/tban1.jpg");
            ModelTopBanner bannerModel2 = ModelTopBanner(imageUrl: "images/tban2.jpg");
            this.topBannerDatas.add(bannerModel1);
            this.topBannerDatas.add(bannerModel2);
          }
        }else{
          ModelTopBanner bannerModel1 = ModelTopBanner(imageUrl: "images/tban1.jpg");
          ModelTopBanner bannerModel2 = ModelTopBanner(imageUrl: "images/tban2.jpg");
          this.topBannerDatas.add(bannerModel1);
          this.topBannerDatas.add(bannerModel2);
        }




        MidTabBean tabModel1 = MidTabBean(picture: "images/mtab1.png",link: "职位库");
        MidTabBean tabModel2 = MidTabBean(picture: "images/mtab2.png",link: "找工作");
        MidTabBean tabModel3 = MidTabBean(picture: "images/mtab3.png",link: "急聘");
        MidTabBean tabModel4 = MidTabBean(picture: "images/mtab4.png",link: "官方保障");
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
    return ItemHPlan(bannerDatas: topBannerDatas,topicTabMenus: topicTabMenus, height: widget._homeTopicHeight,bannerHeight: widget._homeTopBannerHeight);
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
                  child: ItemHJobList(
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
            height: ScreenUtils.navigationBarHeight,
            child: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white.withOpacity(_navAplpha),
              elevation: _navAplpha == 1 ? 0.2: 0.0,
              leading: _mainScrollable ? null: new IconButton(
                icon: Image.asset('images/pp_top.png',
                  width: 40,
                  height: 40,
                ),
                onPressed: _leftTabItemPressed,
              ),
              titleSpacing: _mainScrollable ? 7.0 : 0.0,
              centerTitle: true,
              title: _isNavgationBarHidden ? null: ItemSearchBar('images/pp_icon_home_search_20x20_@3x.png',height: 32,
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


                      Image.asset('images/pp_top_local.png',
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
    if (offset < (widget._homeTopicHeight - ScreenUtils.navigationBarHeight) * 0.25) {
      if (offset > 0) {
        scrollController.animateTo(0.0,duration: new Duration(milliseconds: 300),curve: Curves.linear);
      }
    } else {
      setState(() {
        this._mainScrollable = false;
        this._contentScrollable =true;
      });
      scrollController.animateTo((widget._homeTopicHeight - ScreenUtils.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
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