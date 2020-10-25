
class ModelTopBanner {
  String imageUrl;
  String link;
  String go_type;
  ModelTopBanner({this.imageUrl,this.link,this.go_type});
  ModelTopBanner.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}