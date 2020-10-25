import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatefulWidget {
  final String text;
  final double height;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final Color textColor;
  final Color boxColor;
  final Color textSelectColor;
  final Color boxSelectColor;
  final BorderRadiusGeometry borderRadius;
  final BoxBorder border;
  final BoxBorder selectBorder;
  final ValueChanged<bool> onSelected;
  final bool selected;

  const ChoiceChipWidget(
      {@required this.text,
        this.height = 30,

        this.padding =
        const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
        this.fontSize = 14,
        this.textColor = const Color(0xFF535353),
        this.boxColor = const Color(0xFFFFFFFF),
        this.borderRadius = const BorderRadius.all(Radius.circular(12)),
        this.border = const Border.fromBorderSide(BorderSide(
            color: Color(0xFF535353), width: 1, style: BorderStyle.solid)),
        this.selectBorder = const Border.fromBorderSide(BorderSide(
            color: Color(0xFF23B38E), width: 1, style: BorderStyle.solid)),
        this.onSelected,
        this.selected,
        this.textSelectColor = const Color(0xFF23B38E),
        this.boxSelectColor = const Color(0xFFFFFFFF)});


  @override
  State<StatefulWidget> createState() {
    return _ChoiceChipWidgetState();
  }
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  @override
  Widget build(BuildContext context) {
    bool _select = widget.selected;

    return GestureDetector(
      onTap: () {
        widget.onSelected(!_select);
      },
      child: Container(
          height: widget.height,
          width: 120,
          padding: widget.padding,


          child: _select?new Stack(
              alignment: const FractionalOffset(1, 1),
              children: <Widget>[
                new Container(
                  width:120,
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: widget.fontSize,
                        color:  widget.textSelectColor),
                  ),
                ),
                new Container(
                  child: Icon(
                    Icons.check,
                    color: Color(0xFF23B38E),
                    size: 16,
                  ),
                )
              ]
          ):new Text(
            widget.text,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: widget.fontSize,
                color: widget.textColor),
          ),
          decoration: new BoxDecoration(
              color: _select ? widget.boxSelectColor : widget.boxColor,
              borderRadius: widget.borderRadius,
              border: _select ? widget.selectBorder : widget.border)
      ),
    );
  }
}


class MultipleChoiceeChipWidget extends StatefulWidget{

  final List<String> strings;
  final List<String> selectList;
  final void Function(List<String>) onChanged;
  MultipleChoiceeChipWidget({this.strings,this.selectList,this.onChanged, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MultipleChoiceeChipWidgetState();
  }
}
class MultipleChoiceeChipWidgetState extends State<MultipleChoiceeChipWidget>  {
  @override
  // TODO: implement wantKeepAlive


  Iterable<Widget> get actorWidgets sync* {
    List<String> list=this.widget.strings;
    List<String> selectList=this.widget.selectList;
    if(ObjectUtil.isEmptyList(list)){
      Container();
    }else{
      for (String actor in list) {
        yield Container(
          padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
          child: ChoiceChipWidget(
            height: 34,
            text: actor,
            selected: selectList.contains(actor),
            onSelected: (selected) {
              selectList.contains(actor)
                  ? selectList.remove(actor)
                  : selectList.add(actor);
              this.widget.onChanged(selectList);
            },
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: actorWidgets.toList(),
        ),
      ],
    );
  }
}