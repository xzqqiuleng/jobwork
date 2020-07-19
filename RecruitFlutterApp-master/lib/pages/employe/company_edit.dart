import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class CompanyEdit extends StatefulWidget {
  @override
  _CompanyEditState createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {
  final _companyController = TextEditingController();

  String name="找金网";
  String city="武汉";
  String addess="武汉大桥";
  String c_img="https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg";
  String license_url="https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg";
  String code="11111111111";

  _pubCompany(){
    
    Map infor = Map();
    infor["公司描述"] = "这是一个大公司";
    String inforJson = json.encode(infor);
    List<String> imags = List();
    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
    String imagsJson = json.encode(imags);
    Map data = Map();
    data["name"] = name;
    data["certificate"] = code;
    data["address"] = addess;
    data["license_url"] = license_url;
    data["user_mail"] =ShareHelper.getUser().userMail;
    data["company_info"] =inforJson;
    data["company_img"] ="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1343507296,4164930643&fm=26&gp=0.jpg";
    data["label"] ="{}";   //jsonmp，网上爬的
    data["img_list"] =imagsJson;
    data["id"] =16383;
    MiviceRepository().pubCompany(data).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        showToast("公司已更新");
      }else{
        showToast(reponse["msg"]);
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
    appBar:AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("公司信息",
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
      body:SafeArea(
        top: false,

        child: Stack(
          children: [
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 18, bottom: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  image: NetworkImage("http://www.zaojiong.com/data/logo/20170418/14906489056.PNG")
                              )
                          ),
                        ),
                        SizedBox(width: 16),
                        Text("请完成公司实名认证！",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),

                    SizedBox(height: 30),
                    Text(
                      '* 公司名称',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    LogRegTextField(

                      label: "请填写营业执照上的公司名称",
                      controller:  _companyController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      obscureText: false,

                    ),
                    SizedBox(height: 20),
                    Text(
                      '* 城市',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child:   GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child:   Text("选择",
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
                    SizedBox(height: 10),
                    Text(
                      '* 公司地址',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child:   GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child:   Text("请填写详细地址",
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
                    LogRegTextField(

                      label: "统一信用代码",
                      controller:  _companyController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      obscureText: false,

                    ),
                  ],

                )

            ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: CustomBtnWidget(
            margin: 20,
            btnColor: Colours.app_main,
            text: "更新公司信息",
            onPressed: (){
              _pubCompany();
            },
          ),)
          ],
        )
    )
    );
  }
}
