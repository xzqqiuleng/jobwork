import 'package:flutter/material.dart';

import 'libsb_bzjob.dart';



class PageBzJobs extends StatefulWidget {

  PageBzJobs({Key key}):super(key:key);

  @override
  _PageBzJobsState createState() => _PageBzJobsState();
}

class _PageBzJobsState extends State<PageBzJobs> {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color.fromARGB(255, 242, 242, 245),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('保障无忧',
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
                width: 16,
                height: 16,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body:  new LibSbBzjob()
      );
  }
}