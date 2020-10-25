import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruit_app/viewpages/utils/util_scren.dart';
import 'btn_collect.dart';
import 'cust_check.dart';
import 'model_compy.dart';


class SelectJons extends StatefulWidget {
  final double height;
  final Color themeColor;
  final ValueChanged<Map> onSureButtonClick;

  SelectJons({Key key,this.height,this.themeColor,this.onSureButtonClick}) :super(key:key);
  @override
  _SelectJonsState createState() => _SelectJonsState();
}

class _SelectJonsState extends State<SelectJons> {
 ModelCompay typesModel = ModelCompay();
 Map<String,String>map = new Map();
 Future<void> fetchData() async {
    try {

      var responseStr = await rootBundle.loadString('mock/company_types.json');
      var response = json.decode(responseStr);
      var responseJson = response["data"];

      typesModel = ModelCompay.fromJson(responseJson);

      setState(() {
      });

    } catch (e) {
      print('读取错误：' + e.toString());
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Widget _buildSelectItem(List<String> items,int type) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      childAspectRatio: 6/2,
      children: items.map((name) {
        return BtnCollect(
          title: name,
          themeColor: widget.themeColor,
          onValueChanged: (isSelect) {
            map[type.toString()] = name;
          },
        );
      }).toList(),
    );
  }

  Widget _buildContent(double contentHeight) {
    final double width = (ScreenUtils.width - 15.0 * 4) / 3;
    final double height = width / 3 + 15.0;
    final financingHeight = (typesModel.financing.length % 3 == 0) ? height * (typesModel.financing.length / 3).toInt() : height * (typesModel.financing.length / 3 + 1).toInt();
    final scaleHeight =  (typesModel.scale.length % 3 == 0) ? height * (typesModel.scale.length / 3) : height * (typesModel.scale.length / 3 + 1);
    final industryHeight = (typesModel.industry.length % 3 == 0) ? height * (typesModel.industry.length / 3).toInt() : height * (typesModel.industry.length / 3 + 1).toInt();
  
    return new Container(
      height: contentHeight,
      child: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("学历筛选",style: new TextStyle(fontSize: 16.0,color: Colors.black)),
                new Container(
                  margin: EdgeInsets.only(top: 15.0),
                  height: financingHeight,
                  child:_buildSelectItem(typesModel.financing,0),
                )
              ],
            )
          ),
          new Container(
            margin: EdgeInsets.only(left: 15.0,right: 15.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("经验筛选",style: new TextStyle(fontSize: 16.0,color: Colors.black)),
                new Container(
                  margin: EdgeInsets.only(top: 15.0),
                  height: scaleHeight,
                  child:_buildSelectItem(typesModel.scale,1),
                )
              ],
            )
          ),
          new Container(
            margin: EdgeInsets.only(left: 15.0,right: 15.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("工资待遇",style: new TextStyle(fontSize: 16.0,color: Colors.black)),
                new Container(
                  margin: EdgeInsets.only(top: 15.0),
                  height: industryHeight,
                  child:_buildSelectItem(typesModel.industry,2),
                )
              ],
            )
          ),
          new Container(
            margin: EdgeInsets.only(left: 15.0,right: 15.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 5.0),
                  height: height * 1.5,
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: typesModel.other.map( (text) {
                      return new Container(
                        margin: EdgeInsets.only(left: 10.0,top: 15.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CustCheck(normalIcon: "images/pp_icon_check_normal_17x17_@3x.png",
                              checkIcon: "images/pp_icon_check_press_17x17_@3x.png",
                              size: 18,
                              onValueChanged: (isCheck) {

                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(text),
                            )
                          ],
                        ),
                      );
                    }
                    ).toList(),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomBarHeight = ScreenUtils.navigationBarHeight;
    final bottomBarOffsetTop = widget.height - kToolbarHeight - bottomBarHeight;
    return Container( 
      width: ScreenUtils.width,
      height: widget.height,
      color: Colors.white,
      child: new Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: _buildContent(widget.height - bottomBarHeight),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: bottomBarOffsetTop ,
            child: new Container(
              height: bottomBarHeight,
              width: ScreenUtils.width,
              color: Colors.white,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: kToolbarHeight,
                    width: ScreenUtils.width,
                    child: FlatButton(
                      color: widget.themeColor,
                      onPressed: () {
                        if (widget.onSureButtonClick != null) {

                          widget.onSureButtonClick(map);
                        }
                      },
                      textColor: Colors.white,
                      child: new Text("确定",style: TextStyle(fontSize: 18.0),),
                    ),
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}