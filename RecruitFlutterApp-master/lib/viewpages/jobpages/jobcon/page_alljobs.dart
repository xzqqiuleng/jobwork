import 'package:flutter/material.dart';

import 'libsb_jobs.dart';



class PageAllJobs extends StatefulWidget {

  PageAllJobs({Key key}):super(key:key);

  @override
  _PageAllJobsState createState() => _PageAllJobsState();
}

class _PageAllJobsState extends State<PageAllJobs> {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color.fromARGB(255, 242, 242, 245),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('职位库',
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
        body:  new LibSbjobs()
      );
  }
}