import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/datalist_company.dart';
import 'package:recruit_app/viewpages/comppages/itemrow_compy.dart';
import 'package:recruit_app/viewpages/comppages/page_compdetail.dart';


class MListFocusCompy extends StatefulWidget {
  @override
  _MListFocusCompyState createState() {
    // TODO: implement createState
    return _MListFocusCompyState();
  }
}

class _MListFocusCompyState extends State<MListFocusCompy> {
  List<CompyBean> _companyList = DataListCompany.loadCompany();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('我关注的公司',
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
          if (index < _companyList.length) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: ItemRowCopy(
//                  company: _companyList[index],
                  index: index,
                  lastItem: index == _companyList.length - 1),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageCompDetail(1),
                    ));
              },
            );
          }
          return null;
        },
        itemCount: _companyList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
