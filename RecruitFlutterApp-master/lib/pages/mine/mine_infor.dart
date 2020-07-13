import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';

class MineInfor extends StatefulWidget {
  @override
  _MineInforState createState() => _MineInforState();
}

class _MineInforState extends State<MineInfor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: Text('个人中心',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 18, bottom: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'images/avatar_15.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '狐说',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(37, 38, 39, 1),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('5年经验•26岁•本科',
                              style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(164, 165, 166, 1),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: 8,),
                    Image.asset(
                      'images/arrow_right.png',
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 姓名',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(0),
                        ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 性别',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                   _showSexPop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 出生年月',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    _showDatePop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 微信号',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(0),
                        ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 邮箱',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(0),
                        ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  List _sexList=["男","女"];
  String _sex="男";
  void _showSexPop(BuildContext context){
    FixedExtentScrollController  scrollController = FixedExtentScrollController(initialItem:0);
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context){
          return _buildBottonPicker(
              CupertinoPicker(

                magnification: 1,
                itemExtent:58 ,
                backgroundColor: Colors.white,
                useMagnifier: true,
                scrollController: scrollController,
                onSelectedItemChanged: (int index){
                  if(mounted){
                    setState(() {

                      _sex = _sexList[index];


                    });
                  }
                },
                children: List<Widget>.generate(_sexList.length, (index){
                  return Center(
                    child: Text(_sexList[index]),
                  );
                }),
              )
          );
        });
  }
  DateTime _initDate = DateTime.now();
  String birthday="";

  void _showDatePop(BuildContext context){

    showCupertinoModalPopup<void>(context: context, builder: (BuildContext cotext){

      return _buildBottonPicker(CupertinoDatePicker(
        minimumYear: _initDate.year-100,
        maximumYear: _initDate.year,
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _initDate,
        onDateTimeChanged: (DateTime dataTime){
          if(mounted){
            setState(() {

              birthday =  formatDate(dataTime, [yyyy,"-",mm,"-",dd]);

            });
          }
        },
      ));
    });
  }
  Widget _buildBottonPicker(Widget picker){
    return Container(
      height: 190,
      padding: EdgeInsets.only(top: 6),
      color: Colors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
            color:Colors.black87,
            fontSize: 18
        ),
        child: GestureDetector(
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
