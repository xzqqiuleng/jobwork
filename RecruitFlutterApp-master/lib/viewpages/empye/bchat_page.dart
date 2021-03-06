import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/data_chat.dart';
import 'package:recruit_app/viewpages/jobpages/ritem_chat.dart';

import 'bchat_pageintro.dart';


class BChatPage extends StatefulWidget {
  @override
  _BChatPageState createState() {
    // TODO: implement createState
    return _BChatPageState();
  }
}

class _BChatPageState extends State<BChatPage> {
  List<ChatBean> _chatList = DataChat.loadBossChats();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Bingo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(37, 38, 39, 1))),
              Text('全栈工程师',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 14,
                      color: Color.fromRGBO(152, 154, 155, 1))),
            ],
          ),
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
          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  'images/pp_ic_view_more.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {}),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/pp_ic_phone.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('电话号',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
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
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/pp_ic_resume_send.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('求简历',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/pp_ic_red_cancel.png',
                            width: 25, height: 25, fit: BoxFit.cover),
                        SizedBox(
                          height: 3,
                        ),
                        Text('不合适',
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Color.fromRGBO(115, 116, 117, 1)))
                      ],
                    ),
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
                      return BChatPageIntro();
                    }
                    if (index < (_chatList.length + 1)) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: RitemChat(
                          chat: index == 0
                              ? _chatList[0]
                              : _chatList[index - 1],
                          index: index,
                          isBoss: true,),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
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
                          color: Color.fromRGBO(0, 188, 173, 1),
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
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
                            contentPadding: const EdgeInsets.all(5.0),
                            border: InputBorder.none),
                        onSubmitted: (text) {
                          print(text);
                        },
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'images/pp_icon_replay_face.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'images/pp_icon_increase.png',
                          width: 24,
                          height: 24,
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
