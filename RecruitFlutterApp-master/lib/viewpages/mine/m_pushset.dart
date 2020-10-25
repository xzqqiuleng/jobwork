import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';

import 'mintem_push.dart';



class MPushSet extends StatefulWidget{

  @override
  _PushState createState() {
    // TODO: implement createState
    return _PushState();
  }
  
}
class _PushState extends State<MPushSet>{
  List<MineItemPush> _itmes=List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MineItemPush pushItem1 = MineItemPush(false);
    MineItemPush pushItem2 = MineItemPush(true);
    MineItemPush pushItem3 = MineItemPush(true);
    _itmes.add(pushItem1);
    _itmes.add(pushItem2);
    _itmes.add(pushItem3);
     _addDatas();
  }
  _addDatas(){

}
  @override
  Widget build(BuildContext context) {

    _itmes[0].txt = "声音与震动";
    _itmes[1].txt =  "短信通知";
    _itmes[2].txt =  "夜间免打扰";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.bg_color,
        title: Text("通知与提醒",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorsUtils.black_212920
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back, color: ColorsUtils.black_212920), //自定义图标
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          );
        },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return PushSetItemWidget(index,_itmes[index]);
      },
        itemCount: _itmes.length,
      ),

    );
  }

}
class PushSetItemWidget extends StatefulWidget{
  MineItemPush pushItem;
  int index;
  PushSetItemWidget(this.index,this.pushItem,{Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PusetItemState();
  }

}
class _PusetItemState extends State<PushSetItemWidget>{

  _pushTag(bool value){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          height: 54,
          child: Stack(
            alignment:Alignment.center,
            children: <Widget>[
              Positioned(
                left: 0,
                child: Text(widget.pushItem.txt,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: ColorsUtils.black_212920
                  ),
                ),
              ),
              Positioned(
                  right: 0,

                  child:  CupertinoSwitch(
                  activeColor: ColorsUtils.app_main,
                    value:widget.pushItem.value,
                    onChanged: (value) {
                      setState(() {
                        _pushTag(value);
                        widget.pushItem.value = value;
                      });
                    },
                  )
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: UtilGaps.line1,
              ),

            ],

          ),

        ) ;
  }

}
