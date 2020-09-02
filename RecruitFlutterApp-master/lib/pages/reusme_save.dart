import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'employe/Jl_Detail.dart';
import 'employe/employe_row_item.dart';
import 'jobs/job_detail.dart';
import 'jobs/job_row_item.dart';
import 'share_helper.dart';



class ResumeSave extends StatefulWidget{
  String title;
 ResumeSave(this.title);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<ResumeSave>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();

  _OnRefresh(){
    Map params = Map();
    int classStr;
    params["user_mail"] = ShareHelper.getBosss().userMail;
    if(widget.title == "浏览过"){
      classStr = 1;
    }else if(widget.title == "已沟通"){
      classStr = 2;
    }else{
      classStr = 0;
    }
    params["class"] = classStr;
    new MiviceRepository().getResumeSaveListByType(params).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);
        _refreshController.refreshCompleted();
      }
    });

  _refreshController.refreshCompleted();
  }
  _loadMore(){
    _refreshController.loadComplete();

  }

  Widget getContent(){
    if(data.length >0){
    return ListView.builder(itemBuilder: (context, index) {
      if (data.length >0 && index < data.length) {
        return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: EmployeeRowItem(
                employee: data[index],
                index: index,
                lastItem: index == data.length - 1),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JLDetail(data[index]["job_id"].toString()),
                  ));
            });
      }
      return null;
    },
      itemCount: data.length,
    );

    }else{
      return  Center(
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("images/empty_work.png",width: 60,height: 60,),
              Text(
                  "暂无数据，请前去投递工作"
              )
            ],
          )
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.title,
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
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SmartRefresher(

          header: WaterDropHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: _OnRefresh,
          onLoading: _loadMore,
          enablePullUp: true,
          child: getContent()
      )
    );
  }


}