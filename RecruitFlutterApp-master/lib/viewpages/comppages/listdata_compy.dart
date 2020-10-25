import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/viewmodel/datalist_company.dart';
import 'package:recruit_app/viewpages/comppages/page_compdetail.dart';
import 'package:recruit_app/viewpages/jobpages/search_compyjobs.dart';


import 'itemrow_compy.dart';

class ListDataCompy extends StatefulWidget {
  @override
  _ListDataCompyState createState() {
    // TODO: implement createState
    return _ListDataCompyState();
  }
}

class _ListDataCompyState extends State<ListDataCompy> {
  List<CompyBean> _companyList = DataListCompany.loadCompany();
  int _selectFilterType = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(48),
                vertical: ScreenUtil().setWidth(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '公司',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(40),
                        color: Color.fromRGBO(20, 20, 20, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchCompanyJobs(searchType: SearchType.company,),),);
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(204),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'images/pp_img_search_blue.png',
                            width: ScreenUtil().setWidth(26),
                            height: ScreenUtil().setWidth(26),
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "｜搜索",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Color.fromRGBO(159, 199, 235, 1),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setWidth(10),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(159, 199, 235, 1),
                            width: ScreenUtil().setWidth(2),
                          ),
                          borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(1000))),
                    ),),

                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setWidth(1),
                  color: Color.fromRGBO(245, 245, 245, 1),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(48),
                  ),
                  height: ScreenUtil().setWidth(92),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            "推荐",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              fontWeight: _selectFilterType == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectFilterType == 0
                                  ? Color.fromRGBO(68, 77, 151, 1)
                                  : Color.fromRGBO(57, 57, 57, 1),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectFilterType = 0;
                            });
                          },
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(32),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            "附近",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              fontWeight: _selectFilterType == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectFilterType == 1
                                  ? Color.fromRGBO(68, 77, 151, 1)
                                  : Color.fromRGBO(57, 57, 57, 1),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectFilterType = 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(48),
                    right: ScreenUtil().setWidth(48),
                  ),
                  height: ScreenUtil().setWidth(1),
                  color: Color.fromRGBO(159, 199, 235, 1),
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverList(

                      delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < _companyList.length) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: ItemRowCopy(
//                            company: _companyList[index],
                            index: index,
                            lastItem: index == _companyList.length - 1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageCompDetail(0),
                              ));
                        },
                      );
                    }
                    return null;
                  }, childCount: _companyList.length)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
