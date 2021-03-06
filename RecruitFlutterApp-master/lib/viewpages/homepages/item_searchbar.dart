import 'package:flutter/material.dart';
import 'package:recruit_app/viewpages/jobpages/search_compyjobs.dart';



class ItemSearchBar extends StatefulWidget {
  final String leftIcon;
  Color  backgroudColor;
  double height;
  String txt = "职位快速搜索";
  ItemSearchBar(this.leftIcon,{Key key,this.backgroudColor,this.height,this.txt}): super(key: key);
  @override
  _ItemSearchBarState createState() => _ItemSearchBarState();
}

class _ItemSearchBarState extends State<ItemSearchBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>  Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchCompanyJobs(searchType: SearchType.job,))),
      behavior: HitTestBehavior.opaque,
      child:Container(

        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height * 0.5),
          color: widget.backgroudColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(widget.leftIcon,
                width: 14,
                height: 14,
                color: Colors.black45),
            new Container(
              padding: new EdgeInsets.only(left: 5.0),
              child: new Text(widget.txt,
                style: new TextStyle(fontSize: 12.0,color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}