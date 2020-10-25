import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/viewmodel/data_compan.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/mine/mine_desc.dart';
import '../../colors_utils.dart';
import '../cusbtn.dart';
import '../shareprefer_utils.dart';
import 'item_compinfro.dart';

class InforComp extends StatefulWidget {
  @override
  _InforCompState createState() {
    // TODO: implement createState
    return _InforCompState();
  }
}

class _InforCompState extends State<InforComp> {
  List<DataCompan> _attrList = CompanyAttrList().loadAttrs();


 String c_desc="";
 String c_fl="";
 String c_img="";

  _pubCompany(){
    if(shState == "0"){
      showToast("对不起，你的公司资质认证失败，暂时不能更新信息");
      return;
    }
    if(shState == "2"){
      showToast("对不起，你的公司资质正在审核中，暂时不能更新信息");
      return;
    }
    if(m1 != null && m2 != null && m3 !=null){
      bool isSave = false;
      for(var item in _attrList){
        if(item.status == "已更改"){
          isSave = true;
        }
      }
      if(isSave){
        Map infor = Map();
        infor["公司介绍"] = m1;
        infor["产品及领域"] = m2;
        infor["投资及前景"] = m3;
        String inforJson = json.encode(infor);

        Map data = Map();
        data["company_info"] =inforJson;
        data["id"] =id;
        PinPinReponse().pubCompany(data).then((value) {
          var reponse = json.decode(value.toString());
          if(reponse["status"] == "success"){
            showToast("公司信息已更新");
            Navigator.of(context).pop();
          }else{
            showToast(reponse["msg"]);
          }
        });

      }else{
        showToast("公司信息未有修改");
      }
    }else{
      showToast("公司信息未填写完成");
    }

  }
  var id;
  String inforJson;
  int clickPos = -1;
  String m1;
  String m2;
  String m3;
  _getCompany(){
    PinPinReponse().getCompany(SharepreferUtils.getBosss().userMail).then((value) {
      var reponse = json.decode(value.toString());
      print(reponse);
      if(reponse["status"] == "success"){
        Map data = reponse["result"];
        inforJson=   data["company_info"];
        id =data["id"];
        shState= data["sh_state"].toString();
         if(inforJson != null && inforJson != ""){
           Map map = json.decode(inforJson);
           m1 = map["公司介绍"];
           m2 = map["产品及领域"];
           m3 = map["投资及前景"];
         }
        setState(() {

        });
      }else{
        showToast(reponse["msg"]);
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompany();
  }
  String shState ="1";
  Widget  _getShWidget(){
    if(shState =="0"){
      return  Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Text(
          "公司资质审核失败，请先修改！",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      );
    } else if(shState =="2"){
      return  Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Text(
          "公司资质正在审核中，暂时不能更新公司信息！",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      );
    }else{
      return Text("");
    }
  }
  @override
  Widget build(BuildContext context) {
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
                      left: 15.0, right: 15, top: 0, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _getShWidget(),
                      SizedBox(height: 16,),
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
                              onTap: () async{
                                clickPos = index;
                                String mHint;
                                if(clickPos == 0){
                                  mHint = m1;
                                }else  if(clickPos == 1){
                                  mHint = m2;
                                }else  if(clickPos == 2){
                                  mHint = m3;
                                }
                            var mresult = await  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MineDesc(index+12,mhint: mHint),
                                    ));
                               if(mresult !=null){
                                 if(clickPos == 0){
                                   m1 = mresult;
                                 }else  if(clickPos == 1){
                                   m2 = mresult;
                                 }else  if(clickPos == 2){
                                   m3 = mresult;
                                 }
                                 setState(() {
                                   _attrList[clickPos].status ="已更改";
                                 });
                               }
                              },
                                behavior: HitTestBehavior.opaque,
                              child: InforCompinfro(
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
                      Cusbtn(
                        margin: 20,
                        btnColor: ColorsUtils.app_main,
                        text: "更新信息",
                        onPressed: (){
                          _pubCompany();

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
