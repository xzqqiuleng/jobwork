import 'package:flutter/material.dart';
import 'package:recruit_app/viewmodel/data_compan.dart';


class InforCompinfro extends StatelessWidget {
   DataCompan companyAttr;
   int index;

   InforCompinfro({Key key, this.companyAttr, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  '${companyAttr.attr}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Text(
                '${companyAttr.status}',
                style:  TextStyle(
                  wordSpacing: 1,
                  letterSpacing: 1,
                  fontSize: 16,
                  color: companyAttr.status == "已更改" ?Colors.redAccent:Color.fromRGBO(215, 217, 218, 1),
                ),
              ),
              SizedBox(width: 15),
              Image.asset('images/pp_ic_arrow_gray.png',
                  width: 15, height: 15, fit: BoxFit.cover)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            height: 1,
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
        ],
      );
  }
}
