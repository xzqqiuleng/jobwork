import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';


import 'data_anim.dart';

enum TabbarPopType {
  popSelectNone,
  popSelectCity,
  popSelectType,
  popSort,
}

class TabbarJobs extends StatefulWidget {
  final String cityName;
  final String sortName;

  final ValueChanged<TabbarPopType> popTypeChanged;
  Function(Function) tabbarReset;

  TabbarJobs({Key key,this.cityName,this.sortName,this.tabbarReset,this.popTypeChanged}):super(key:key);
  @override
  _TabbarJobsState createState() => _TabbarJobsState();
}

class _TabbarJobsState extends State<TabbarJobs> {
  bool isTapCity = false;
  bool isTapSelect = false;
  bool isTapSort = false;
  TabbarPopType popType;

  @override
  Widget build(BuildContext context) {
    if (widget.tabbarReset != null) {
      widget.tabbarReset(() {
  
        setState(() {
          isTapCity = false;
          isTapSelect = false;
          isTapSort = false;
        });
      });
    }
    return new Container(
      height:  44,
      width: ScreenUtils.width,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          UtilGaps.bline1,
          new Container(
            height: 40,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        setState(() {


                          if (!isTapSelect && !isTapSort && isTapCity) {
                            widget.popTypeChanged(TabbarPopType.popSelectNone);
                          } else {
                            popType = TabbarPopType.popSelectCity;
                            widget.popTypeChanged(popType);
                          }

                          

                          isTapCity = !isTapCity;
                          if (isTapCity) {
                            isTapSelect =false;
                            isTapSort =false;
                          }
                        });
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(widget.cityName ?? "广州",style: new TextStyle(fontSize: 15.0,color: popType ==TabbarPopType.popSelectCity ? ColorsUtils.app_main:Colors.black),softWrap: false,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: DataAnim(
                              container: new Container(
                                width: 10,
                                height: 5,
                                child: new Image.asset('images/pp_company_icon_arrow2_normal_7x4_@3x.png',color: popType ==TabbarPopType.popSelectCity ? ColorsUtils.app_main:Colors.grey,),
                              ),
                              isForward: isTapCity,
                              isReverse: !isTapCity,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        setState(() {


                          if (!isTapCity && !isTapSort && isTapSelect) {
                            widget.popTypeChanged(TabbarPopType.popSelectNone);
                          } else {
                            popType = TabbarPopType.popSelectType;
                            widget.popTypeChanged(popType);
                          }

                          isTapSelect =!isTapSelect;
                           if (isTapSelect) {
                            isTapCity =false;
                            isTapSort =false;
                          }
                        });
    
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text("筛选",style: new TextStyle(fontSize: 15.0,color: popType ==TabbarPopType.popSelectType ? ColorsUtils.app_main:Colors.black),),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: DataAnim(
                              container: new Container(
                                width: 10,
                                height: 5,
                                child: new Image.asset('images/pp_company_icon_arrow2_normal_7x4_@3x.png',color: popType ==TabbarPopType.popSelectType ?  ColorsUtils.app_main:Colors.grey,),
                              ),
                              isForward: isTapSelect,
                              isReverse: !isTapSelect,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        setState(() {


                          if (!isTapCity && !isTapSelect && isTapSort) {
                            widget.popTypeChanged(TabbarPopType.popSelectNone);
                          } else {
                            popType = TabbarPopType.popSort;
                            widget.popTypeChanged(popType);
                          }

                          isTapSort =! isTapSort;
                           if (isTapSort) {
                            isTapSelect =false;
                            isTapCity =false;
                          }
                        });

                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(widget.sortName ?? "排序",style: new TextStyle(fontSize: 15.0,color: popType ==TabbarPopType.popSort ?  ColorsUtils.app_main:Colors.black),),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: DataAnim(
                              container: new Container(
                                width: 10,
                                height: 5,
                                child: new Image.asset('images/pp_company_icon_arrow2_normal_7x4_@3x.png',color: popType ==TabbarPopType.popSort ? ColorsUtils.app_main:Colors.grey,),
                              ),
                              isForward: isTapSort,
                              isReverse: !isTapSort,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            height: 0.1,
            color: new Color.fromARGB(255, 242, 242, 245),
          ),
          UtilGaps.bline1,
        ],
      ),
    );
  }
}