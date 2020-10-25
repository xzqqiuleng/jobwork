import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/cuswidget/cusdialog_kf.dart';
import 'package:recruit_app/viewpages/provider/bean_update.dart';
import 'package:recruit_app/viewpages/provider/provider_custwidget.dart';
import 'package:recruit_app/viewpages/provider/provider_update.dart';
import 'package:recruit_app/viewpages/provider/provider_updatemodel.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';
import 'package:recruit_app/viewpages/utils/util_plats.dart';
import 'package:url_launcher/url_launcher.dart';

import '../url_constant.dart';


class PageAbout extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("关于我们",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black), //自定义图标
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            );
          },
          ),
          centerTitle: true,
          elevation: 0,
      ),
      body: AboutUsWidget()

    );
  }
  
}

class  AboutUsWidget extends StatefulWidget{
  @override
  _AboutUsWidgetState createState() {
    // TODO: implement createState
  return _AboutUsWidgetState();
  }

}
class  _AboutUsWidgetState extends State<AboutUsWidget>{
  var appVersion ;
  bool visible = false;
  final TapGestureRecognizer recognizer = TapGestureRecognizer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recognizer.onTap = () {
      launch("tel:${UrlConstant.kf_phone}");
    };
    getVersion();
  }
  void getVersion() async{
    appVersion = await UtilsPlatform.getAppVersion();
    print("appversion${appVersion}");
    setState(() {


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return ProviderCustWidget<ProviderUpdateModel>(
     model: ProviderUpdateModel(),
     onModelReady: (ProviderUpdateModel model){
         model.checkUpdate().then((value) {
           if(value == null){
             return;
           }
             setState(() {
               visible = value.buildHaveNewVersion == null?false :value.buildHaveNewVersion;
             });

         });
     },
     builder: (_, model, __) {
        return Column(
          children: <Widget>[
            UtilGaps.vGap24,
            ClipRRect( //剪裁为圆角矩形
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: AssetImage("images/icon_hc.png"),
                height: 98,
                width: 98,
              ),
            ),
            UtilGaps.vGap12,
            Text("18聘聘",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsUtils.black_212920
              ),
            ),
            UtilGaps.vGap12,
            Text("版本 $appVersion",
              style: TextStyle(
                  fontSize: 13,
                  color: ColorsUtils.gray_8A8F8A
              ),
            ),
            UtilGaps.vGap50,
            GestureDetector(
              onTap: model.isBusy
                  ? null
                  : () async {
                BeanUpdate appUpdateInfo = await model.checkUpdate();
                if (appUpdateInfo?.buildHaveNewVersion ?? false) {
                  bool result =
                  await showUpdateAlertDialog(context, appUpdateInfo);
                  if (result == true) downloadApp(context, appUpdateInfo);
                } else {
                  showToast("已是最新版本");
                }
              },
              behavior: HitTestBehavior.opaque,

              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                height: 54,
                child: Stack(
                  alignment:Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      child: Text("检查新版本",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: ColorsUtils.black_212920
                        ),
                      ),
                    ),
                    Positioned(
                        right: 30,
                        child:  Offstage(
                          offstage: !visible,
                          child: Text("NEW ！",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: ColorsUtils.red_ffd5351c
                            ),
                          ),
                        )
                    ),
                    Positioned(
                      right: 0,
                      child: Icon(Icons.navigate_next, color: ColorsUtils.black_400000),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: UtilGaps.line1,
                    ),

                  ],

                ),

              ),
            ),

            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:_showCall,
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 54,
                  child: Stack(
                    alignment:Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: Text("联系客服",
                          style: TextStyle(

                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: ColorsUtils.black_212920
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Icon(Icons.navigate_next, color: ColorsUtils.black_400000),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: UtilGaps.line1,
                      ),

                    ],

                  ),

                )
            )

          ],
        );
     });

  }

  void _showCall(){
    showDialog(
      context: context,
      builder: (context) {
        return CustDialogKF();
      },
    );
  }

}

