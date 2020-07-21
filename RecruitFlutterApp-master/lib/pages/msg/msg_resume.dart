import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/employe/Jl_Detail.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/jobs/job_row_item.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'msg_job_item.dart';


class MsgResume extends StatefulWidget{
  int type;
  MsgResume(this.type);

  @override
  _JobState createState() {
    // TODO: implement createState
    return _JobState();
  }

}

class _JobState extends State<MsgResume>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();
 String title="";
  _OnRefresh(){
    page=0;

    new MiviceRepository().getFilterJlList(page,searchType: widget.type).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);
        page++;
        _refreshController.refreshCompleted();
      }
    });
  }
  _loadMore(){
    new MiviceRepository().getFilterJlList(page,searchType: widget.type).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        List  loaddata = reponse["result"];
        setState(() {
          data.addAll(loaddata);
        });

        page++;
        _refreshController.loadComplete();
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.type){
      case 0:
        title = "对我感兴趣的";
        break;
      case 1:
        title = "看过我的";
        break;
      case 2:
        title = "智能推荐";
        break;
      case 3:
        title = "职位上新";
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(title,
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
              width: 18,
              height: 18,
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
          child: ListView.builder(itemBuilder: (context, index) {
            if (data.length >0 && index < data.length) {
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: EmployeeRowItem(
                      employee: data[index],
                      index: index,
                      type: widget.type,
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
          )
      )
    );
  }


}
class EmployeeRowItem extends StatelessWidget {
  final Map employee;
  final int index;
  final int type;
  final bool lastItem;

  const EmployeeRowItem({Key key, this.employee, this.index, this.lastItem,this.type})
      : super(key: key);

  Widget _getrihgt(){
    switch(type){
      case 0:
        return Text(
          "对我感兴趣",
          style: TextStyle(
              color: Colors.grey
          ),
        );
      case 1:
        return Text(
          "看过我",
          style: TextStyle(
              color: Colors.grey
          ),
        );
      case 2:
        return Text(
          "推荐度${99 - index % 10}%",
          style: TextStyle(
              color: Colors.grey
          ),
        );
      case 3:
        return Image.asset("images/work_new.png",width: 20,height: 20,);
    }
  }
  @override
  Widget build(BuildContext context) {

    var dataItem = json.decode(employee["info"].toString());
    var head_icon = employee["head_img"].toString();
    List tags = List();
    tags.add(dataItem["年龄"].toString());
    tags.add(dataItem["性别"].toString());
    tags.add(dataItem["教育经历"].toString());
    final employeeItem =
    Card(
      margin: EdgeInsets.fromLTRB(15,15,15,0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),
      elevation:0.1,
      child:Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    head_icon,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${dataItem["姓名"]}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(37, 38, 39, 1),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      Text(

                          dataItem["目前状态"]==null?"离职-找工作中": dataItem["目前状态"],
                          style: const TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontSize: 11,
                            color: Colors.blueAccent,
                          )),

                    ],
                  ),
                ),
                SizedBox(width: 18),
                Text(
                    dataItem["希望月薪"],
                    style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colours.app_main,
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/hangye.png',
                  width: 17,
                  height: 18,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Text(      dataItem["求职行业"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          wordSpacing: 1,
                          letterSpacing: 1,
                          fontSize: 14,
                          color: Color.fromRGBO(53, 54, 55, 1),
                        ))),
                SizedBox(width: 10),

              ],
            ),
            SizedBox(
              height: 15,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: tags.map((item) {
                return new Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    child: Text(item,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600])));
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Text( dataItem["求职意向"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    letterSpacing: 1,
                    wordSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color.fromRGBO(93, 94, 95, 1))),
            Align(
              alignment:Alignment.topRight,
              child:     _getrihgt(),
            )

          ],
        ),
      ) ,
    );
    return  employeeItem;
  }
}
