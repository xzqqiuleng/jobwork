import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/util_event.dart';
import 'package:recruit_app/viewmodel/data_chat.dart';
import 'package:recruit_app/viewpages/http/pinpin_response.dart';
import 'package:recruit_app/viewpages/jobpages/ritem_chat.dart';
import 'package:recruit_app/viewpages/utils/util_gaps.dart';
import 'package:web_socket_channel/io.dart';

import '../page_jub.dart';
import '../page_nw.dart';
import '../shareprefer_utils.dart';

class PageChatLine extends StatefulWidget {
  String reply_id;
  String user_id;
  String title;
  String head_icon;
  String  jsonStr;
  int type;
  PageChatLine({this.reply_id,this.user_id,this.title,this.head_icon,this.type,this.jsonStr});
  @override
  _PageChatLineState createState() {
    // TODO: implement createState
    return _PageChatLineState();
  }
}

class _PageChatLineState extends State<PageChatLine> {
  List<ChatBean> _chatList = [];
  final ScrollController _scrollController = ScrollController();
  var  channel;
  String  jsonStr;

  StreamSubscription  _eventChangeSub;
  void _eventSub(){
    _eventChangeSub= eventBus.on<ReplayChatEvent>().listen((event) {
      print(event);
      if(event.type == "0"){
        if(widget.type == 0){
          Map map = Map();
          map["user_info"] =jsonStr;

          map["user_id"] = widget.user_id;
          map["reply_id"] =widget.reply_id;
          map["message"] ="手机号:  ${SharepreferUtils.getBosss().userMail}";
          channel.sink.add(json.encode(map));

        }else{
          Map map = Map();

          map["com_info"] =jsonStr;
          map["user_id"] = widget.user_id;
          map["reply_id"] =widget.reply_id;
          map["message"] ="手机号:  ${SharepreferUtils.getUser().userMail}";
          channel.sink.add(json.encode(map));

        }

      }else if(event.type == "1"){
        if(widget.type == 0){
          Map map = Map();
          map["user_info"] =jsonStr;

          map["user_id"] = widget.user_id;
          map["reply_id"] =widget.reply_id;
          map["message"] ="微信号:  ${SharepreferUtils.getBosss().wxId}";
          channel.sink.add(json.encode(map));

        }else{
          Map map = Map();

          map["com_info"] =jsonStr;
          map["user_id"] = widget.user_id;
          map["reply_id"] =widget.reply_id;
          map["message"] ="微信号:  ${SharepreferUtils.getUser().wxId}";
          channel.sink.add(json.encode(map));
        }
      }else if(event.type == "2"){
        if(widget.type == 0){
          Map map = Map();
          map["user_info"] =jsonStr;

          map["user_id"] = widget.user_id;
          map["reply_id"] =widget.reply_id;
          map["message"] ="邮箱:  ${SharepreferUtils.getBosss().mail}";
          channel.sink.add(json.encode(map));

        }else{
          Map map = Map();

          map["com_info"] =jsonStr;
          map["user_id"] = widget.user_id;
          map["reply_id"] =widget.reply_id;
          map["message"] ="邮箱:  ${SharepreferUtils.getUser().mail}";
          channel.sink.add(json.encode(map));
        }
      }
      _initData();
    });

  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventChangeSub.cancel();
    channel.sink.close();
  }
  @override
  void initState() {
    super.initState();

      Map map = Map();
    if(widget.type == 0){
      map["user_name"] = widget.title;
      map["head_img"] = widget.head_icon;

    }else{
      map["company_name"] = widget.title;
      map["company_img"] = widget.head_icon;
      map["pub_name"] = widget.title;
    }
    jsonStr = json.encode(map);
     channel = IOWebSocketChannel.connect("${PinPinReponse.socketUrl}${widget.user_id}");

    channel.stream.listen((message) {
      setState(() {
        _chatList.add(ChatBean(
            replayId: widget.reply_id,
            head_icon: widget.head_icon,
            user_icon: widget.type == 0?  SharepreferUtils.getBosss().headImg: SharepreferUtils.getUser().headImg,
            isMine: false,
            content: message));
      });
      _controllerjumpTo();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  _initData();
    _eventSub();
  }
  _controllerjumpTo() {
    Timer(Duration(milliseconds: 500), () {
      //List滑动到底部
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  _initData(){
    PinPinReponse().getAllMessage(widget.user_id,widget.reply_id).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        print(reponse);
        _chatList.clear();

        setState(() {
          var  data = reponse["result"];
          for(var item in data){
            ChatBean chat;
            if(widget.type == 0){
              chat = ChatBean(content: item["msg"],user_icon: SharepreferUtils.getBosss().headImg,head_icon:widget.head_icon,replayId: widget.reply_id);
              if(item["user_id"]== SharepreferUtils.getBosss().userId ){
                chat.isMine = true;
              }else{
                chat.isMine = false;
              }
            }else{
              chat = ChatBean(content: item["msg"],user_icon: SharepreferUtils.getUser().headImg,head_icon:widget.head_icon,replayId: widget.reply_id);
              if(item["user_id"]== SharepreferUtils.getUser().userId ){
                chat.isMine = true;
              }else{
                chat.isMine = false;
              }
            }

            _chatList.add(chat);
          }
        });
        _controllerjumpTo();
      }
    });
  }



  void showNormalWord(){
    List<dynamic> tip = SharepreferUtils.getNormal();
    List<dynamic>getTips;
    if(SharepreferUtils.isBossLogin()){
      getTips=["我能要一份你的联系方式吗","你对我们公司的职位有兴趣吗","你好，可以聊一聊么。","我对你的简历很感兴趣，希望可以进一步沟通。","我认为你很符合这个职位，希望可以聊一下"];
    }else{
      getTips=["您好，请问公司还在招人吗！","Boss,你好。","你好，可以聊一聊么。","我对贵公司的职位很感兴趣，希望可以进一步沟通。","我认为我符合这个职位，希望可以聊一下"];
    }

 if(tip == null){
   tip = new List();
 }
    tip.addAll(getTips);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UtilGaps.vGap16,
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageNw(),
                      ));
                },
                child:  Text("    + 添加常用语",
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorsUtils.app_main,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

            UtilGaps.vGap8,
            Container(
            color: Colors.transparent,
            child:  ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: tip.length,
                itemBuilder: (context, index) {
                  if (index < tip.length) {
                    return  GestureDetector(
                      child: ChatItem(
                        welfareData: tip[index],
                        index: index,
                        isLastItem: index == tip.length - 1,
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        if(widget.type == 0){
                          Map map = Map();
                          map["user_info"] =jsonStr;

                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["message"] =tip[index];
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getBosss().headImg,
                                content: tip[index]));

                          });
                          Navigator.of(context).pop();
                        }else{
                          Map map = Map();

                          map["com_info"] =jsonStr;
                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["message"] =tip[index];
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getUser().headImg,
                                content: tip[index]));

                          });
                          Navigator.of(context).pop();
                        }


                        _controllerjumpTo();
                      },
                    ) ;
                  }
                  return null;
                }),
          )
            ],
          ) ;
        });
  }

  @override
  Widget build(BuildContext context) {
    final editController = TextEditingController();
    editController.addListener(() {});

    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(37, 38, 39, 1))),
            ],
          ),
          leading: IconButton(
              icon: Image.asset(
                'images/pp_img_arrow_left_black.png',
                width: 20,
                height: 20,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  'images/pp_ic_action_report_black.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageJub(3,widget.reply_id)));
                }),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        if(widget.type == 0){
                          Map map = Map();
                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["user_info"] =jsonStr;


                          Map jsonMsg = Map();
                          jsonMsg["state"] = "0";
                          jsonMsg["msg"] = SharepreferUtils.getBosss().userMail;
                          jsonMsg["type"] = "0";
                          jsonMsg["userId"] = widget.user_id;
                          jsonMsg["uuid"] = "${widget.user_id}-${new DateTime.now().millisecondsSinceEpoch}";
                          map["message"] =json.encode(jsonMsg);
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getBosss().headImg,
                                content: json.encode(jsonMsg)));
                            editController.text = "";
                          });
                        }else{
                          Map map = Map();
                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["com_info"] =jsonStr;
                          Map jsonMsg = Map();
                          jsonMsg["state"] = "0";
                          jsonMsg["msg"] = SharepreferUtils.getUser().userMail;
                          jsonMsg["type"] = "0";
                          jsonMsg["userId"] = widget.user_id;
                          jsonMsg["uuid"] = "${widget.user_id}-${new DateTime.now().millisecondsSinceEpoch}";
                          map["message"] =json.encode(jsonMsg);
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getUser().headImg,
                                content: json.encode(jsonMsg)));
                            editController.text = "";
                          });
                        }
                        _controllerjumpTo();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/pp_ic_phone.png',
                              width: 25, height: 25, fit: BoxFit.cover),
                          SizedBox(
                            height: 3,
                          ),
                          Text('手机号',
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  color: Color.fromRGBO(115, 116, 117, 1)))
                        ],
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child:GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        if(widget.type == 0){
                          Map map = Map();
                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["user_info"] =jsonStr;
                          Map jsonMsg = Map();
                          jsonMsg["state"] = "0";
                          jsonMsg["msg"] = SharepreferUtils.getBosss().wxId;
                          jsonMsg["type"] = "1";
                          jsonMsg["userId"] = widget.user_id;
                          jsonMsg["uuid"] = "${widget.user_id}-${new DateTime.now().millisecondsSinceEpoch}";
                          map["message"] =json.encode(jsonMsg);
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getBosss().headImg,
                                content: json.encode(jsonMsg)));
                            editController.text = "";
                          });
                        }else{
                          Map map = Map();

                          map["com_info"] =jsonStr;
                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          Map jsonMsg = Map();
                          jsonMsg["state"] = "0";
                          jsonMsg["msg"] = SharepreferUtils.getUser().wxId;
                          jsonMsg["type"] = "1";
                          jsonMsg["userId"] = widget.user_id;
                          jsonMsg["uuid"] = "${widget.user_id}-${new DateTime.now().millisecondsSinceEpoch}";
                          map["message"] =json.encode(jsonMsg);
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getUser().headImg,
                                content: json.encode(jsonMsg)));
                            editController.text = "";
                          });
                        }
                        _controllerjumpTo();
                      },
                    child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/pp_ic_wechat.png',
                              width: 25, height: 25, fit: BoxFit.cover),
                          SizedBox(
                            height: 3,
                          ),
                          Text('微信号',
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  color: Color.fromRGBO(115, 116, 117, 1)))
                        ],
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        if(widget.type == 0){
                          Map map = Map();
                          map["user_info"] =jsonStr;
                          map["user_id"] = widget.user_id;
                          map["reply_id"] = widget.reply_id;
                          Map jsonMsg = Map();
                          jsonMsg["state"] = "0";
                          jsonMsg["msg"] = SharepreferUtils.getBosss().mail;
                          jsonMsg["type"] = "2";
                          jsonMsg["userId"] = widget.user_id;
                          jsonMsg["uuid"] = "${widget.user_id}-${new DateTime.now().millisecondsSinceEpoch}";
                          map["message"] =json.encode(jsonMsg);
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getBosss().headImg,
                                content: json.encode(jsonMsg)));
                            editController.text = "";
                          });
                        }else{
                          Map map = Map();
                          map["com_info"] =jsonStr;
                          map["user_id"] =widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          Map jsonMsg = Map();
                          jsonMsg["state"] = "0";
                          jsonMsg["msg"] = SharepreferUtils.getUser().mail;
                          jsonMsg["type"] = "2";
                          jsonMsg["userId"] = widget.user_id;
                          jsonMsg["uuid"] = "${widget.user_id}-${new DateTime.now().millisecondsSinceEpoch}";
                          map["message"] =json.encode(jsonMsg);
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getUser().headImg,
                                content: json.encode(jsonMsg)));
                            editController.text = "";
                          });
                        }
                        _controllerjumpTo();
                      },
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/pp_email.png',
                              width: 25, height: 25, fit: BoxFit.cover),
                          SizedBox(
                            height: 3,
                          ),
                          Text('邮箱',
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  color: Color.fromRGBO(115, 116, 117, 1)))
                        ],
                      ),
                    )
                  ),


                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromRGBO(241, 242, 244, 1),
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if(index==0){
                      return TopWidget();
                    }
                    if (index < (_chatList.length + 1)) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: RitemChat(
                          chat: index == 0
                              ? _chatList[0]
                              : _chatList[index - 1],
                          index: index,
                          isBoss: false,),
                        onTap: () {},
                      );
                    }
                    return null;
                  },
                  itemCount: _chatList.length + 1,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        showNormalWord();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Text(
                          "常用语",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        decoration: new BoxDecoration(
                          color: ColorsUtils.app_main,
                          borderRadius: new BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    UtilGaps.hGap8,
                    Expanded(
                      child: TextField(
                        controller: editController,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        cursorColor: Color.fromRGBO(0, 188, 173, 1),
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromRGBO(37, 38, 38, 1)),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(4.0),
                            hintText: "新消息",
                            border:InputBorder.none,
                            ),
                        onSubmitted: (text) {
                          print(text);
                        },
                      ),
                    ),
                    UtilGaps.hGap4,
//                    GestureDetector(
//                      behavior: HitTestBehavior.opaque,
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Image.asset(
//                          'images/icon_replay_face.png',
//                          width: 24,
//                          height: 24,
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      behavior: HitTestBehavior.opaque,
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: .asset(
//                          'images/icon_increase.png',
//                          width: 24,
//                          height: 24,
//                        ),
//                      ),
//                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        SystemChannels.textInput.invokeMethod("TextInput.hide");
                        if(widget.type == 0){
                          Map map = Map();
                          map["user_info"] =jsonStr;

                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["message"] =editController.text;
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getBosss().headImg,
                                content: editController.text));
                            editController.text = "";
                          });
                        }else{
                          Map map = Map();

                          map["com_info"] =jsonStr;
                          map["user_id"] = widget.user_id;
                          map["reply_id"] =widget.reply_id;
                          map["message"] =editController.text;
                          channel.sink.add(json.encode(map));
                          setState(() {
                            _chatList.add(ChatBean(
                                isMine: true,
                                user_icon: SharepreferUtils.getUser().headImg,
                                content: editController.text));
                            editController.text = "";
                          });
                        }


                        _controllerjumpTo();
                      },
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal:8, vertical:5),
                        child: Text(
                          "发 送",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        decoration: new BoxDecoration(
                          color: ColorsUtils.app_main,
                          borderRadius: new BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
class ChatItem extends StatelessWidget {
  final String welfareData;
  final int index;
  final bool isLastItem;

  const ChatItem({Key key, this.welfareData, this.index,this.isLastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final welfareItem = Container(
      alignment: Alignment.centerLeft,
      height: 40,
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(6),
//          border: Border.all(
//              width: 0.4,
//              color: Colors.black87,
//              style: BorderStyle.solid)),
      child: Text(
        welfareData == ""?"公司福利": '${welfareData}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );

    if(isLastItem){
      return welfareItem;
    }

    return Column(
      children: <Widget>[
        welfareItem,
        Container(
         height: 0.2,
          color: ColorsUtils.gray_8A8F8A,
        ),
      ],
    );
  }
}
class TopWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Image.asset("images/pp_warn_icon.png",width: 20,height: 20,),
          Text(
              "聊天需谨慎，谨防诈骗消息！"
          )
        ],
      ),
    );
  }

}