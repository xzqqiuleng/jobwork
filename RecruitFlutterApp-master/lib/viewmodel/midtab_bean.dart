class MidTabBean {
  String picture;
  String link;
  MidTabBean({this.picture,this.link});
  MidTabBean.fromJson(Map data) {
    picture = data['pic'];
    link = data['link'];
  }
}