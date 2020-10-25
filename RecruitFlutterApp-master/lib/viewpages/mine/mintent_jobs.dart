import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewmodel/vm_intentjob.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/loginreg/myuser.dart';

import '../shareprefer_utils.dart';
import '../storage_manager.dart';


class MineJobsIntent extends StatefulWidget {
  @override
  _MineJobsIntentState createState() {
    // TODO: implement createState
    return _MineJobsIntentState();
  }
}

class _MineJobsIntentState extends State<MineJobsIntent> {
  List<IntentBean> _intentList = VmIntentJob.loadJobIntent();

  @override
  Widget build(BuildContext context) {


   if(SharepreferUtils.getUser().resumeStatus!=null) {
     _xl = SharepreferUtils.getUser().resumeStatus;
   }

    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Image.asset(
                'images/pp_ic_back_arrow.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          centerTitle: true,
          title: Text('求职状态',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  wordSpacing: 1,
                  letterSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 38, 39, 1))),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
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
                          Expanded(
                            child: Text('求职状态将要改变？',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    wordSpacing: 2,
                                    letterSpacing: 2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(37, 38, 39, 1))),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('正确的更新求职状态，才能获得更多的面试机会！',
                          style: const TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontSize: 14,
                            color: Color.fromRGBO(164, 165, 166, 1),
                          )),
                      SizedBox(
                        height: 8,
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '求职状态',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(37, 38, 39, 1),
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                _xl,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Color.fromRGBO(164, 165, 166, 1),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'images/pp_ic_arrow_gray.png',
                                width: 10,
                                height: 10,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _showSexPop(context);

                        },
                      ),
                      Container(
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: MaterialButton(
                    color: ColorsUtils.app_main,
                    onPressed: () {
                Map userMap = Map();
          userMap["resume_status"] =_xl;
          userMap["user_id"] =SharepreferUtils.getUser().userId;
          PinPinReponse().updateUser(userMap).then((value){

            MyUser user = SharepreferUtils.getUser();
            user.resumeStatus =_xl;
            StorageManager.localStorage.setItem(SharepreferUtils.kUser, user);
           showToast("职位状态已更新");
          });

                    },
                    textColor: Colors.white,
                    child: Text("更新状态"),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  )),
            ),
          ],
        ));
  }


  List _salaryList=["离职-找工作","在职—找工作","在职-考虑机会","暂不考虑"];
  String _xl="离职-找工作";
  String _mxl = "离职-找工作";
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


                      _mxl = _salaryList[index];




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
                    if(mounted){
                      setState(() {
                        if(_mxl != null){
                          _xl =     _mxl;
                        }



                      });
                    }
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
}
