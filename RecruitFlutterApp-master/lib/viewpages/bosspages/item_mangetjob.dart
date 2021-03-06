import 'package:flutter/material.dart';


class ItemManagetJob extends StatelessWidget {
  final Map jobManageData;
  final int index;

  const ItemManagetJob({Key key, this.jobManageData, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mlabel="";
    List<String> labels = jobManageData["label"].toString().split("|");
    labels.removeAt(0) ;

    for(var item in labels){
      if(mlabel == ""){
        mlabel = item;
      }else{
        mlabel = mlabel +"|"+item;
      }
    }
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '${jobManageData["title"]}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(38, 38, 38, 1),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${jobManageData["salary"]}',
                        style: const TextStyle(
                          wordSpacing: 1,
                          letterSpacing: 1,
                          fontSize: 14,
                          color: Color.fromRGBO(67, 67, 67, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    mlabel,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 14,
                      color: Color.fromRGBO(154, 154, 154, 1),
                    ),
                  ),
                ],
              )),
              SizedBox(width: 15),
              Image.asset('images/pp_ic_arrow_gray.png',
                  width: 10, height: 10, fit: BoxFit.cover)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 1,
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
        ],
      ),
    );
  }
}
