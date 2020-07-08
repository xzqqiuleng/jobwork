
class BannerModel {
  String imageUrl;
  String link;
  BannerModel({this.imageUrl,this.link});
  BannerModel.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}