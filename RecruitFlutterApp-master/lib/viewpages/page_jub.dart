import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusdialog_photosele.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/shareprefer_utils.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';

import 'cusbtn.dart';


class PageJub extends StatelessWidget{
  int type;
  String id;
  PageJub(this.type,this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.bg_color,
        title: Text("举报反馈",
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

      body:JbFWidget(type,id),

      resizeToAvoidBottomPadding: false,
    );
  }

}

class JbFWidget extends StatefulWidget{
  int type;
  String id;
  JbFWidget(this.type,this.id);

  @override
  _JbFState createState() {
    // TODO: implement createState
    return _JbFState();
  }

}


class _JbFState extends State<JbFWidget>{
//  PickedFile _imageFile;


  ImagePicker _picker;
  List<String> fileStrs = List();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  List jbList1=["违法违纪，敏感言论","色情，辱骂，粗俗","职位虚假，信息不真实","违法，欺诈，诱导欺骗","收取求职者费用","变相发布广告和招商","其他违规违法行为"];
  List jbList2=["公司信息虚假","变相发布广告和招商信息","包含，欺诈，诱导欺骗等信息","其他违规违法行为"];
  List jbList3=["职位虚假，信息不真实","欺骗，诱导获取联系方式","聊天信息不真实，身份有风险","其他违规违法行为"];
  List jbList4=["简历信息虚假","信息错误，包含夸张修饰","包含，欺诈，诱导欺骗等信息","其他违规行为"];
  List jbList;
  String jbStr="请选择举报类型";
  void _showSexPop(BuildContext context){

    if(widget.type == 1){
      jbList = jbList1;
    }else if(widget.type == 2){
      jbList = jbList2;
    }else if(widget.type == 3){
      jbList = jbList3;
    }else{
      jbList = jbList4;
    }

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

                  jbStr = jbList[index];
                },
                children: List<Widget>.generate(jbList.length, (index){
                  return Center(
                    child: Text(jbList[index]),
                  );
                }),
              )
          );
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




  @override
  Widget build(BuildContext context) {
    // TODO: implement build

          return   Column(

            children: <Widget>[

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: ()async{
                _showSexPop(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    UtilGaps.hGap20,
                    Expanded(
                      child:   Text(jbStr,
                          style: TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Colors.black87)),
                    ),
                    SizedBox(width: 8,height: 40,),
                    Image.asset(
                      'images/pp_arrow_right.png',
                      width: 18,
                      height: 18,
                      color: Colors.black54,
                      fit: BoxFit.cover,
                    ),
                    UtilGaps.hGap20,
                  ],
                ),
              ),
             Container(
               margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
               color: ColorsUtils.gray_8A8F8A,
               height: 0.2,
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
                            hintText: "请详细描述你的举报内容，最好请上传相关截图。",
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
  _upLoadImage(Map map){
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
  _putFeed(){
    if(jbStr == "请选择举报类型"){
      showToast("请选择举报类型");
      return;
    }
    if(_contentController.text.isEmpty){
      showToast("请填写内容");
      return;
    }
    Map map = Map();
    map["title"] = jbStr;
    map["content"] = _contentController.text;
    map["user_id"] = SharepreferUtils.isLogin() ? SharepreferUtils.getUser().userId :SharepreferUtils.getBosss().userId;
    map["type"] = widget.type;
    map["q_id"] =widget.id;
    _upLoadImage(map);




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