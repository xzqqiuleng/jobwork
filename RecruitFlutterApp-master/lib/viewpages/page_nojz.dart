import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'http/pinpin_response.dart';
import 'jobpages/page_jobdetail.dart';
import 'jobpages/ritem_jobs.dart';
import 'shareprefer_utils.dart';



class PageNoJz extends StatefulWidget{
  String title;
 PageNoJz(this.title);

  @override
  _PageNoJzState createState() {
    // TODO: implement createState
    return _PageNoJzState();
  }

}

class _PageNoJzState extends State<PageNoJz>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();

  _OnRefresh(){
    Map params = Map();
    int classStr;
    params["user_mail"] = SharepreferUtils.getUser().userMail;
    if(widget.title == "浏览过"){
      classStr = 1;
    }else if(widget.title == "已沟通"){
      classStr = 2;
    }else{
      classStr = 0;
    }
    params["class"] = classStr;
    new PinPinReponse().getJodSaveListByType(params).then((value) {
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
            child: RitemJobs(
                job: data[index],
                index: index,
                lastItem: index == data.length - 1),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageJobDetail(data[index]["job_id"]),
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
              Image.asset("images/pp_empty_work.png",width: 60,height: 60,),
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
              'images/pp_ic_back_arrow.png',
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