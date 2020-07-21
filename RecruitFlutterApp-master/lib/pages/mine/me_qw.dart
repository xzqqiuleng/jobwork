import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/city_page.dart';
import 'package:recruit_app/pages/work_page.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

import '../btn_widget.dart';
import 'me_desc.dart';

class MeQW extends StatefulWidget {
  Map qw;
  MeQW({this.qw});
  @override
  _MeQWState createState() => _MeQWState();
}

class _MeQWState extends State<MeQW> {
  TextEditingController _phoneController = TextEditingController();
  String _qxresult="";
  String _city="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.qw != null){
      _qxresult = widget.qw["work_type"];
      _city = widget.qw["city"];
      _salary = widget.qw["money"];
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("求职意向",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 16,
              height: 16,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
//          IconButton(
//              icon: Image.asset(
//                'images/complete.png',
//                width: 20,
//                height: 20,
//              ),
//              onPressed: () {}),
        ],
      ),
      body:  SafeArea(
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
      Text(
        '* 意向职位',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async{
        var    reslut = await  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkPage(),
                ));
            setState(() {
           if(reslut != null){
              _qxresult = reslut;
           }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_qxresult,
                    style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: 16,
                        color:Colors.black87,
                        )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),

      Text(
        '* 工作城市',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async{
            var    reslut = await  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CityPage(),
                ));
            setState(() {
              if(reslut != null){
                _city = reslut;
              }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_city,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color:Colors.black87,
                    )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),
      Text(
        '* 期望薪资',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
          _showSexPop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_salary,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color:Colors.black87,
                    )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),
      CustomBtnWidget(
        margin: 20,
        btnColor: Colours.app_main,
        text: "完成",
        onPressed: (){
          if(_qxresult.length >1 && _city.length>1&&_salary.length>1 ){
           Map qwMap = Map();
            qwMap["work_type"] = _qxresult;
            qwMap["money"] = _salary;
            qwMap["city"] = _city;
            Navigator.of(context).pop(qwMap);
          }else{
            showToast("请完整填写信息");
          }
        },
      )
    ],


    )
       )
      ),
    )
    );

  }

  List _salaryList=["2000以上","3000以上","4000以上","5000以上","6000以上","7000以上","8000以上","9000以上","1万以上","2万以上","3万以上","4万以上","5万以上"];
  String _salary="选择薪资";
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

                        _salary = _salaryList[index];


                    });
                  }
                },
                children: List<Widget>.generate(_salaryList.length, (index){
                  return Center(
                    child: Text(_salaryList[index]),
                  );
                }),
              )
          );
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
