import 'package:flutter/material.dart';
import 'package:recruit_app/viewpages/homepages/item_searchbar.dart';

import 'barsele_emp.dart';



class PageEmpySear extends StatefulWidget {
 String searchTxt;
  PageEmpySear(this.searchTxt,{Key key}):super(key:key);

  @override
  _PageEmpySearState createState() => _PageEmpySearState();
}

class _PageEmpySearState extends State<PageEmpySear> {



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
        body:  new BarseleEmp(searchTxt:widget.searchTxt)
      );
  }
}