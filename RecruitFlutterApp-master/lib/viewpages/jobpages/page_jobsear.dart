import 'package:flutter/material.dart';
import 'package:recruit_app/viewpages/homepages/item_searchbar.dart';

import 'jobcon/libsb_jobs.dart';



class PageJobSear extends StatefulWidget {
 String searchTxt;
  PageJobSear(this.searchTxt,{Key key}):super(key:key);

  @override
  _PageJobSearState createState() => _PageJobSearState();
}

class _PageJobSearState extends State<PageJobSear> {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //修改颜色
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: ItemSearchBar('images/pp_icon_home_search_20x20_@3x.png',height: 32,
            backgroudColor:  Color(0xfff0f0f0),txt: widget.searchTxt,
          ),
        ),
        body:  new LibSbjobs(searchTxt:widget.searchTxt)
      );
  }
}