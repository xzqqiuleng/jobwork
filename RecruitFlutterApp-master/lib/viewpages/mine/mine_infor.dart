import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusdialog_photosele.dart';
import 'package:recruit_app/viewpages/empye/editinfo_compy.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/loginreg/page_seletype_login.dart';
import 'package:recruit_app/viewpages/loginreg/myuser.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';
import '../cusbtn.dart';
import '../shareprefer_utils.dart';
import '../storage_manager.dart';
import 'mine_desc.dart';
import 'online_resumeinfor.dart';

class MineViewInfor extends StatefulWidget {
  int type;
  MineViewInfor(this.type);
  @override
  _MineViewInforState createState() => _MineViewInforState();
}

class _MineViewInforState extends State<MineViewInfor> {

  String name="";
  String sex="男";
  String birthDay="";
  String wx="";
  String email="";
  String headImaurl="https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3253926546,3995438373&fm=15&gp=0.jpg";
 String inforStatus= "";


  _back(){
    if(inforStatus != "1"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PageSeleTypeLogin(),
          ));
    }else{
      Navigator.of(context).pop();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type == 0){
      inforStatus = SharepreferUtils.getBosss().infoStatus;
    }else{
      inforStatus = SharepreferUtils.getUser().infoStatus;
    }

    if(inforStatus == "1"){
      if(widget.type == 0){
        name = SharepreferUtils.getBosss().userName;
        sex = SharepreferUtils.getBosss().userSex;
        birthDay = SharepreferUtils.getBosss().birth;
        wx = SharepreferUtils.getBosss().wxId;
        email = SharepreferUtils.getBosss().mail;
        headImaurl = SharepreferUtils.getBosss().headImg;
      }else{

        name = SharepreferUtils.getUser().userName;
        sex = SharepreferUtils.getUser().userSex;
        birthDay = SharepreferUtils.getUser().birth;
        wx = SharepreferUtils.getUser().wxId;
        email = SharepreferUtils.getUser().mail;
        headImaurl = SharepreferUtils.getUser().headImg;
      }
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
        map["user_id"] = SharepreferUtils.getBosss().userId;
      }else{
        map["user_id"] = SharepreferUtils.getUser().userId;
      }

      PinPinReponse().updateUser(map).then((value){
        var reponse = json.decode(value.toString());

        if(reponse["status"] == "success") {
          showToast("个人信息更新成功");
        }else{
          showToast(reponse["msg"]);
        }

        Map userMap = Map();
        userMap["info_status"] ="1";
        if(widget.type == 0){
          userMap["user_id"] = SharepreferUtils.getBosss().userId;
        }else{
          userMap["user_id"] = SharepreferUtils.getUser().userId;
        }

        PinPinReponse().updateUser(userMap).then((value){
          MyUser user;
          if(widget.type == 0){
            user = SharepreferUtils.getBosss();
          }else{
            user = SharepreferUtils.getUser();
          }

          user.userName = name;
          user.userSex = sex;
          user.birth = birthDay;
          user.wxId = wx;
          user.mail = email;
          user.headImg = headImaurl;
          user.infoStatus = "1";

          if(widget.type == 0){
            StorageManager.localStorage.setItem(SharepreferUtils.BOSSUser, user);
          }else{
            StorageManager.localStorage.setItem(SharepreferUtils.kUser, user);
          }



          if(inforStatus!= "1"){

            if(widget.type == 0){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditInfoCompy(),
                  ));
            }else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnlineResumeInfor(),
                  ));
            }

          }

        });




      });

    }



  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          _back();
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Image.asset(
                'images/pp_ic_back_arrow.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
              _back();
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
                        Text(
                          '* 编辑头像',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        UtilGaps.vGap10,
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
                                'images/pp_arrow_right.png',
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
                                  builder: (context) => MineDesc(0),
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
                                'images/pp_arrow_right.png',
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
                                'images/pp_arrow_right.png',
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
                                'images/pp_arrow_right.png',
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
                                  builder: (context) => MineDesc(1),
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
                                'images/pp_arrow_right.png',
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
                                  builder: (context) => MineDesc(2),
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
                                'images/pp_arrow_right.png',
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
                  child: Cusbtn(
                    margin: 20,
                    btnColor: ColorsUtils.app_main,
                    text: inforStatus=="0"?"下一步":"更新信息",
                    onPressed: (){
                      _saveInfor();
                    },
                  ),
                )
              ],
            )
        ),
      )
    ) ;
  }
  List _sexList=["男","女"];
  String _msex = "男";
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


                      _msex = _sexList[index];




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
  String mbirthDay;
  void _showDatePop(BuildContext context){

    showCupertinoModalPopup<void>(context: context, builder: (BuildContext cotext){

      return _buildBottonPicker(CupertinoDatePicker(
        minimumYear: _initDate.year-70,
        maximumYear: _initDate.year,
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _initDate,
        onDateTimeChanged: (DateTime dataTime){
          if(mounted){
            setState(() {


              mbirthDay=  formatDate(dataTime, [yyyy,"-",mm,"-",dd]);
            });
          }
        },
      ));
    });
  }
  Widget _buildBottonPicker(Widget picker) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 52,
          color: Color(0xfff6f6f6),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(

                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消",
                    style: TextStyle(
                        color: ColorsUtils.black_212920,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                    ),),
                ),
              ),
              Positioned(
                right: 20,
                child: GestureDetector(
                  onTap: () {
//                    Navigator.pop(context);
//                    showToast("举报已发送，我们会尽快审核信息");
                    Navigator.pop(context);
                    setState(() {
                      if(mounted){
                        setState(() {
                           if(_msex != null){
                             sex = _msex;
                           }
                        if(mbirthDay != null){
                          birthDay = mbirthDay;
                        }


                        });
                      }
                    });
                  },
                  child: Text("确定",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: ColorsUtils.app_main,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 190,
          padding: EdgeInsets.only(top: 6),
          color: Colors.white,
          child: DefaultTextStyle(
            style: const TextStyle(
                color: ColorsUtils.black_212920,
                fontSize: 18
            ),
            child: GestureDetector(
              child: SafeArea(
                top: false,
                child: picker,
              ),
            ),
          ),
        )
      ],

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
    PinPinReponse.upLoadPicture(path).then((value) {
      var reponse = json.decode(value.toString());
      print(reponse);
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
        return CustDialogPhotoSele(_openGallery,_takePhoto,_cancle);
      },
    );
  }
}
