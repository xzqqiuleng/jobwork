import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/listjobs.dart';
import 'package:recruit_app/viewpages/jobpages/page_jobdetail.dart';

import 'mpage_comun_ritem.dart';


class MPageCollect extends StatefulWidget {
  @override
  _CollectionJobSate createState() {
    // TODO: implement createState
    return _CollectionJobSate();
  }
}

class _CollectionJobSate extends State<MPageCollect> {
  List<SJobBean> _jobList = ListJobs.loadJobs();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('我感兴趣的职位',
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < _jobList.length) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: MPageComunRitem(
                    job: _jobList[index],
                    index: index,
                    lastItem: index == _jobList.length - 1),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageJobDetail(1),
                      ));
                });
          }
          return null;
        },
        itemCount: _jobList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
