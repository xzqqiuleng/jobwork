class TopicTabModel {
  String picture;
  String link;
  TopicTabModel({this.picture,this.link});
  TopicTabModel.fromJson(Map data) {
    picture = data['pic'];
    link = data['link'];
  }
}