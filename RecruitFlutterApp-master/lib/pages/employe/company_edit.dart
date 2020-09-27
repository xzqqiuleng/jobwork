import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/login/login_type.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/city_page.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/map_loc.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';
import 'package:recruit_app/widgets/photo_select.dart';

class CompanyEdit extends StatefulWidget {
  @override
  _CompanyEditState createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _codeController = TextEditingController();



 String name;
  String code ;
  String city="";
  String address1="";
  String address2="";
  String province="";
  String lat="";
  String lng;
  String c_img="http://www.zaojiong.com/data/logo/20170418/14906489056.PNG";
  String license_url="";
 String companyState = "";
 String id ;
 String img_state ="";
  static const _regExp=r"^[ZA-ZZa-z0-9_]+$";

  _back(){
    if(companyState != "1"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginType(),
          ));
    }else{
      Navigator.of(context).pop();
    }
  }

  _pubCompany(){
    
//    Map infor = Map();
//    infor["公司描述"] = "这是一个大公司";
//    String inforJson = json.encode(infor);
//    List<String> imags = List();
//    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
//    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
//    imags.add("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=209265447,2361612875&fm=26&gp=0.jpg");
//    String imagsJson = json.encode(imags);
    if(RegExp(_regExp).firstMatch(_codeController.text)==null){
      showToast("统一信用代码格式错误");
      return ;
    }
  if(_nameController.text.length <2||_addressController.text.length <2 ||_codeController.text.length<2||license_url.length<2||c_img.length<2 || city ==""){
    showToast("请填写完整信息");
    return;
  }

    Map data = Map();
    data["name"] = _nameController.text;
    data["certificate"] = _codeController.text;
    data["address"] = address1+"·"+_addressController.text;
    data["license_url"] = license_url;
    data["user_mail"] =ShareHelper.getBosss().userMail;
//    data["company_info"] =inforJson;
    data["company_img"] =c_img;
    data["city"] =city;
    data["lat"] =lat;
    data["lng"] =lng;
    data["province"] =province;
//    data["label"] ="{}";   //jsonmp，网上爬的
//    data["img_list"] =imagsJson;
    data["id"] =id;
    MiviceRepository().pubCompany(data).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        if(companyState != "1"){
          Map userMap = Map();
          userMap["company_status"] ="1";
          userMap["user_id"] =ShareHelper.getBosss().userId;
          MiviceRepository().updateUser(userMap).then((value){

            User user = ShareHelper.getBosss();
            user.companyStatus ="1";


            StorageManager.localStorage.setItem(ShareHelper.BOSSUser, user);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RecruitHomeApp(),
                ));
          });

        }
        showToast("公司已更新");
      }else{
        showToast(reponse["msg"]);
      }
    });

  }

 _getCompany(){
   MiviceRepository().getCompany(ShareHelper.getBosss().userMail).then((value) {
     var reponse = json.decode(value.toString());
     if(reponse["status"] == "success"){
       Map data = reponse["result"];
       name=  data["name"];
       code = data["certificate"];
       city = data["city"];
      String maddress =data["address"];

_nameController.text=  data["name"];
 _codeController.text= data["certificate"];
       if(maddress.contains("·")){

             address1 = maddress.split("·")[0];
         address2 = maddress.split("·")[1];


         _addressController.text = address2;
       }
       license_url =  data["license_url"];
       c_img= data["company_img"];
       shState= data["sh_state"].toString();
       id =data["id"].toString();
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
    companyState = ShareHelper.getBosss().companyStatus;
    if(companyState == "1"){
      _getCompany();
    }
  }
  String shState ="1";
 Widget  _getShWidget(){
 if(shState =="0"){
   return  Container(
     alignment: Alignment.center,
     color: Colors.redAccent,
     padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
     child: Text(
       "公司信息认证失败，请修改后重新提交审核！",
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
    return  WillPopScope(
      onWillPop: () {
        _back();
      },

      child:Scaffold(
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
                  _back();
                }),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: <Widget>[
//          IconButton(
//              icon: Image.asset(
//                'images/complete.png',
//                width: 20,
//                height: 20,
//              ),
//              onPressed: () {
//
//
//              }),
            ],
          ),
          body:SafeArea(
              top: false,

              child: Stack(
                children: [
                  SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 0, bottom: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                         _getShWidget(),
                          SizedBox(height: 16),
                          Text(
                            '* 公司头像',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              img_state ="0";
                              _showSelectPhoto();
                            },
                            child: Row(
                              children: <Widget>[


                                Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        image: DecorationImage(
                                            image: NetworkImage(c_img),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),

                                Expanded(
                                    flex: 1,
                                    child:Container(

                                    )
                                ),
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

                            label: name,
                            controller:  _nameController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            obscureText: false,

                          ),
                          SizedBox(height: 20),
                          Text(
                            '* 地址定位',
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
                              onTap: () async {
//                                var    reslut = await  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => CityPage(),
//                                    ));
//                                setState(() {
//                                  if(reslut != null){
//                                    city = reslut;
//                                  }
//                                });

                                var    reslut = await   Navigator.push(context,  MaterialPageRoute(
                                  builder: (context) => MapLoc(),
                                ));
                                if(reslut != null){
                                   List infros= reslut.toString().split("|");

                                    lat = infros[0];
                                    lng = infros[1];
                                   province = infros[2];
                                    city = infros[3];
                                    setState(() {
                                      address1 = infros[4];
                                    });

                                  }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:   Text(address1,
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
                            '* 详细地址信息(楼层，门牌号)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          LogRegTextField(

                            label: address2,
                            controller:  _addressController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            obscureText: false,

                          ),

                          SizedBox(height: 30),
                          Text(
                            '* 统一信用代码',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          LogRegTextField(

                            label: code,
                            controller:  _codeController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,

                          ),
                          SizedBox(height: 30),
                          Text(
                            '* 营业执照',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: (){
                              img_state ="1";
                              _showSelectPhoto();
                            },
                            child:  Image(
                              image: license_url == ""?AssetImage("images/yy_add.png"):NetworkImage(license_url),
                              width: 100,
                              height: 160,
                            ),
                          ),

                          SizedBox(height: 60),
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
      ) ,
    );
  }


  ImagePicker _picker;

  /*拍照*/
  _takePhoto() async {

    var image = await _picker.getImage(source: ImageSource.camera,imageQuality: 30);
    _cancle();
    if(image == null){
      return;
    }
    _upLoadImage(image.path);

  }
  /*相册*/
  _openGallery() async {

    var image = await _picker.getImage(source: ImageSource.gallery,imageQuality: 30);
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
            if(img_state == "0"){
              c_img = head_img;
            }else{
              license_url = head_img;
            }

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
