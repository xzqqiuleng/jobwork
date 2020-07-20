import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/employe/company_edit.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/widgets/photo_select.dart';

import '../btn_widget.dart';
import 'online_resume.dart';

class MineInfor extends StatefulWidget {
  int type;
  MineInfor(this.type);
  @override
  _MineInforState createState() => _MineInforState();
}

class _MineInforState extends State<MineInfor> {

  String name="";
  String sex="男";
  String birthDay="";
  String wx="";
  String email="";
  String headImaurl="https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3253926546,3995438373&fm=15&gp=0.jpg";
 String inforStatus= "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type == 0){
      inforStatus = ShareHelper.getBosss().infoStatus;
    }else{
      inforStatus = ShareHelper.getUser().infoStatus;
    }

    if(inforStatus == "1"){
           name = ShareHelper.getUser().userName;
           sex = ShareHelper.getUser().userSex;
           birthDay = ShareHelper.getUser().birth;
           wx = ShareHelper.getUser().wxId;
           email = ShareHelper.getUser().mail;
           headImaurl = ShareHelper.getUser().headImg;
    }
  }
  _saveInfor(){

    if(name.length <2 ||sex.length<1||birthDay.length<2||wx.length<2||email.length<2||headImaurl.length<2){
      showToast("信息填写不符合规范，请检查！");

    }else{
      Map map = Map();
      map["user_name"] = name;
      map["user_sex"] = sex;
      map["birth"] = birthDay;
      map["wx_id"] = wx;
      map["mail"] = email;
      map["head_img"] = headImaurl;
      if(widget.type == 0){
        map["user_id"] = ShareHelper.getBosss().userId;
      }else{
        map["user_id"] = ShareHelper.getUser().userId;
      }

      MiviceRepository().updateUser(map).then((value){
        var reponse = json.decode(value.toString());

        if(reponse["status"] == "success") {
          showToast("个人信息更新成功");
        }else{
          showToast(reponse["msg"]);
        }

        Map userMap = Map();
        userMap["info_status"] ="1";
        if(widget.type == 0){
          userMap["user_id"] = ShareHelper.getBosss().userId;
        }else{
          userMap["user_id"] = ShareHelper.getUser().userId;
        }

        MiviceRepository().updateUser(userMap).then((value){
          User user;
          if(widget.type == 0){
            user = ShareHelper.getBosss();
          }else{
            user = ShareHelper.getUser();
          }

          user.userName = name;
          user.userSex = sex;
          user.birth = birthDay;
          user.wxId = wx;
          user.mail = email;
          user.headImg = headImaurl;
          user.infoStatus = "1";
          StorageManager.localStorage.setItem(ShareHelper.kUser, user.toJson());


          if(inforStatus!= "1"){

            if(widget.type == 0){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyEdit(),
                  ));
            }else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnlineResume(),
                  ));
            }

          }

        });




      });

    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 18,
              height: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: Text('个人信息',
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
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 18, bottom: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        _showSelectPhoto();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                headImaurl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                          child: Text(
                            ""
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async{
                        var mName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeDesc(0),
                            ));

                        if(mName != null){
                          setState(() {
                            name = mName;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(name,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600
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
                            child:   Text(sex,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600
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
                            child:   Text(birthDay,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()async{
                        var mWx = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeDesc(1),
                            ));
                        if(mWx != null){
                          setState(() {

                            wx = mWx;
                          });
                        }

                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(wx,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async{
                        var s_ema =await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeDesc(2),
                            ));
                        if(s_ema != null){
                          setState(() {
                            email = s_ema;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child:   Text(email,
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
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: CustomBtnWidget(
                margin: 20,
                btnColor: Colours.app_main,
                text: inforStatus=="0"?"下一步":"更新信息",
                onPressed: (){
                  _saveInfor();
                },
              ),
            )
          ],
        )
      ),
    );
  }
  List _sexList=["男","女"];
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

                      sex = _sexList[index];


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

              birthDay =  formatDate(dataTime, [yyyy,"-",mm,"-",dd]);

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
  ImagePicker _picker;

  /*拍照*/
  _takePhoto() async {

    var image = await _picker.getImage(source: ImageSource.camera,maxHeight: 60,maxWidth: 60);
    _cancle();
    if(image == null){
      return;
    }
    _upLoadImage(image.path);

  }
  /*相册*/
  _openGallery() async {

    var image = await _picker.getImage(source: ImageSource.gallery,maxHeight: 60,maxWidth: 60);
    _cancle();
    if(image == null){
      return;
    }
    _upLoadImage(image.path);

  }
  _upLoadImage(String path){
    MiviceRepository.upLoadPicture(path).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success") {
        String   head_img = reponse["result"]["url"];
        setState(() {

          headImaurl = head_img;
        });
      }
    });
  }
  _cancle(){
    Navigator.of(context).pop();
  }
  void _showSelectPhoto(){

    if(_picker == null){
      _picker = new ImagePicker();
    }
    showModalBottomSheet(

      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return PhotoSelectWidget(_openGallery,_takePhoto,_cancle);
      },
    );
  }
}
