import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';


import 'me_desc.dart';

class MeEdu extends StatefulWidget {
  Map edu;
  MeEdu({this.edu});
  @override
  _MeEduState createState() => _MeEduState();
}

class _MeEduState extends State<MeEdu> {
  String _schoolname="学校";
  String _schoolzy="专业";
  String _schooljl="在校经历";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


    if(widget.edu != null){

      _schoolname = widget.edu["school"];
      _schoolzy = widget.edu["zy"];
      datss = widget.edu["by_time"];
      _schooljl = widget.edu["jl"];
      _xl = widget.edu["xl"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("教育经历",
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
          IconButton(
              icon: Image.asset(
                'images/complete.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {}),
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
        '* 学校',
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
                  builder: (context) => MeDesc(7),
                ));
            setState(() {
           if(reslut != null){
              _schoolname = reslut;
           }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_schoolname,
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
        '* 专业',
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
                  builder: (context) => MeDesc(8),
                ));
            setState(() {
              if(reslut != null){
                _schoolzy  = reslut;
              }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_schoolzy,
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
        '* 学历',
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
                child:   Text(_xl,
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
        '* 毕业时间',
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
            _showDatePop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(datss,
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
        '* 在校经历',
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
                  builder: (context) => MeDesc(8),
                ));
            setState(() {
              if(reslut != null){
                 _schooljl= reslut;
              }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_schooljl,
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
          if(_schooljl.length >1 && _schoolname.length>1&&_schoolzy.length>1 &&datss.length>1&&_xl.length>1){
           Map eduMap = Map();
            eduMap["school"] = _schoolname;
            eduMap["zy"] = _schoolzy;
            eduMap["by_time"] = datss;
            eduMap["jl"] = _schooljl;
            eduMap["xl"] = _xl;
           Navigator.of(context).pop(eduMap);
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

  List _salaryList=["初中及以下","高中","中专","大专","本科","研究生","硕士","博士"];
  String _xl="";
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

                        _xl = _salaryList[index];


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
  DateTime _initDate = DateTime.now();
  String  datss = "";
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

                datss =     formatDate(dataTime, [yyyy,"-",mm,"-",dd]);

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
