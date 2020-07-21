import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/model/company_attr.dart';
import 'package:recruit_app/pages/boss/company_info_item.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';

import '../../colours.dart';
import '../btn_widget.dart';

class CompanyInfo extends StatefulWidget {
  @override
  _CompanyInfoState createState() {
    // TODO: implement createState
    return _CompanyInfoState();
  }
}

class _CompanyInfoState extends State<CompanyInfo> {
  List<CompanyAttr> _attrList = CompanyAttrList.loadAttrs();


 String c_desc="";
 String c_fl="";
 String c_img="";

//  _pubCompany(){
//    Map infor = Map();
//    infor["公司描述"] = "这是一个大公司";
//    String inforJson = json.encode(infor);
//    List<String> imags = List();
//    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
//    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
//    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
//    String imagsJson = json.encode(imags);
//    Map dMap = Map();
//    dMap["工作详情"] = work_deteail;
//    String dJson  = json.encode(dMap);
//    Map data = Map();
//
//    data["mook_img"] ="";
//    MiviceRepository().pubJob(data).then((value) {
//      var reponse = json.decode(value.toString());
//      if(reponse["status"] == "success"){
//        showToast("职位已更新");
//      }else{
//        showToast("简历更新失败");
//      }
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
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
        title: Text('公司信息',
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
        child: Column(
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
                      Text('完善公司信息',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 2,
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(
                        height: 8,
                      ),
                      Text('构建完善的公司信息，才能更好的吸引人才！。',
                          style: const TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontSize: 14,
                            color: Color.fromRGBO(77, 78, 79, 1),
                          )),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 1,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _attrList.length) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MeDesc(index+12),
                                    ));
                              },
                                behavior: HitTestBehavior.opaque,
                              child: CompanyInfoItem(
                                companyAttr: _attrList[index],
                                index: index,
                              )
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: _attrList.length,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomBtnWidget(
                        margin: 20,
                        btnColor: Colours.app_main,
                        text: "完成",
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
