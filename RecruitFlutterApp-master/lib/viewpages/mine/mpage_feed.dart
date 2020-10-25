import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusdialog_photosele.dart';
import 'package:recruit_app/cuswidget/cusfield_logreg.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';

import '../cusbtn.dart';
import '../shareprefer_utils.dart';


class MPageFeed extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.bg_color,
        title: Text("意见反馈",
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

      body:FeedBackWidget(),

      resizeToAvoidBottomPadding: false,
    );
  }

}

class FeedBackWidget extends StatefulWidget{


  @override
  _FeedBackState createState() {
    // TODO: implement createState
    return _FeedBackState();
  }

}


class _FeedBackState extends State<FeedBackWidget>{
//  PickedFile _imageFile;


  ImagePicker _picker;
  List<String> fileStrs = List();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

          return   Column(

            children: <Widget>[

              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  UtilGaps.hGap20,
                  Text("*",
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorsUtils.red_ffd5351c
                    ),

                  ),
                  Text("遇到的问题",
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorsUtils.black_212920,
                        fontWeight: FontWeight.bold
                    ),

                  ),


                ],
              ) ,
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16,10),

                child:  CusFieldLogReg(
                  controller: _titleController,
                  label: "简单的概括",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  obscureText: false,

                )
              ),

              Stack(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xfff0f0f0),
                        ),
                        child: TextField(
                         controller: _contentController,
                          cursorColor: ColorsUtils.app_main,
                          maxLines: 4,
                          decoration: InputDecoration(

                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            //获得焦点下划线设为蓝色
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:  Colors.transparent),
                            ),
                            hintText: "请详细描述你遇到的问题，最好请上传问题截图。",
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: ColorsUtils.gray_8A8F8A
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12
                            ),

                          ),
                        ),
                      ),

                      Positioned(
                          bottom: 40,
                          left: 40,
                          child:  GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap:_showSelectPhoto,
                            child: Container(
                              height: 50,
                              width: 50,

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Image(
                                image: AssetImage("images/pp_feed_img.png"),
                                width: 19,
                                height: 16,
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 100,
                margin: EdgeInsets.fromLTRB(20, 0, 16, 0),
                child:  GridView.builder(
                    itemCount: fileStrs.length ,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget

                    ),
                    itemBuilder: (context,index){

                      return Padding(padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child:  Image.file(File(fileStrs[index]),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,),
                      );

                    }
                ) ,
              ),
              UtilGaps.vGap32,
              Cusbtn(
                onPressed: () =>_putFeed(),
                margin: 20,
                height: 48,
                radius: 30,
                text: "上传问题",
                btnColor: ColorsUtils.app_main,
              )
            ],
          );

  }

  _putFeed(){
    if(_titleController.text.isEmpty){
      showToast("请填写标题");
      return;
    }
    if(_contentController.text.isEmpty){
      showToast("请填写内容");
      return;
    }
    Map map = Map();
    map["title"] = _titleController.text;
    map["content"] = _contentController.text;
    map["user_id"] = SharepreferUtils.isLogin() ? SharepreferUtils.getUser().userId :SharepreferUtils.getBosss().userId;
    map["type"] =0;
    if(fileStrs != null && fileStrs.length >0){
      PinPinReponse.upLoadPicture(fileStrs[0]).then((value) {
        var reponse = json.decode(value.toString());
        if(reponse["status"] == "success") {
          String   feedUrl = reponse["result"]["url"];
          map["img"] = feedUrl;
          PinPinReponse().putFeed(map).then((value){
            showToast("反馈已发送");
            Navigator.of(context).pop();

          });
        }else{
          showToast("上传失败");
        }
      });
    }else{
      PinPinReponse().putFeed(map).then((value){
        showToast("反馈已发送");
        Navigator.of(context).pop();

      });
    }





  }

    /*拍照*/
  _takePhoto() async {

    var image = await _picker.getImage(source: ImageSource.camera);
    _cancle();
    if(image == null){
      return;
    }

    setState(() {
      fileStrs = List();
      fileStrs.add(image.path);
    });
  }
  /*相册*/
  _openGallery() async {

    var image = await _picker.getImage(source: ImageSource.gallery);
    _cancle();
    if(image == null){
      return;
    }

    setState(() {
      fileStrs = List();
      fileStrs.add(image.path);
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