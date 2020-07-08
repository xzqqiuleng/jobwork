import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/home/search_bar.dart';
import 'package:recruit_app/pages/utils/screen.dart';


import 'home_headplan.dart';
import 'home_joblist.dart';



class HomePage extends StatefulWidget {
  final double _homeTopBannerHeight = 220;
  final double _homeTopicHeight = 300;
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

  void _rightTabItemPressed() {

  }

  void _leftTabItemPressed() {

    if (_isTabbarItemClick) {
      _isTabbarItemClick = false;
    }

    scrollController.animateTo(0.0,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    setState(() {
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
          BannerModel bannerModel1 = BannerModel(imageUrl: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3778115985,3313781102&fm=26&gp=0.jpg",link: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3778115985,3313781102&fm=26&gp=0.jpg");
          BannerModel bannerModel2 = BannerModel(imageUrl: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3842951066,2465592920&fm=26&gp=0.jpg");
        this.topBannerDatas.add(bannerModel1);
        this.topBannerDatas.add(bannerModel2);


        TopicTabModel tabModel1 = TopicTabModel(picture: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1203774205,2402277934&fm=26&gp=0.jpg");
        TopicTabModel tabModel2 = TopicTabModel(picture: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1203774205,2402277934&fm=26&gp=0.jpg");
        TopicTabModel tabModel3 = TopicTabModel(picture: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1203774205,2402277934&fm=26&gp=0.jpg");
        this.topicTabMenus.add(tabModel1);
        this.topicTabMenus.add(tabModel2);
        this.topicTabMenus.add(tabModel3);

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
              backgroundColor: Colors.white.withOpacity(_navAplpha),
              elevation: _navAplpha == 1 ? 0.2: 0.0,
              leading: _mainScrollable ? null: new IconButton(
                icon: Image.asset('images/arrow_down.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: _leftTabItemPressed,
              ),
              titleSpacing: _mainScrollable ? 7.0 : 0.0,
              centerTitle: true,
              title: _isNavgationBarHidden ? null: SearchBar('images/icon_home_search_20x20_@3x.png',height: 32,
                backgroudColor: Color.lerp(Colors.white, Colors.black12, _navAplpha),
              ),
              actions: _isNavgationBarHidden ? null: <Widget>[
                new IconButton(
                    icon: Image.asset('images/home/icon_resume_edit_saoYsao_20x20_@3x.png',
                      width: 20,
                      height: 20,
                      color: Color.lerp(Colors.white, Colors.black45, _navAplpha),
                    ),
                    onPressed: _rightTabItemPressed,
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