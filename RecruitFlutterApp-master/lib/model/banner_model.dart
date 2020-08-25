
class BannerModel {
  String imageUrl;
  String link;
  String go_type;
  BannerModel({this.imageUrl,this.link,this.go_type});
  BannerModel.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}