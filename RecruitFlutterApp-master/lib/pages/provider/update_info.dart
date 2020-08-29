/// CheckApp更新接口
class AppUpdateInfo {

  bool mustUpdate;
  String nowVersion;
  String updateMessage;
  String updateUrl;
  bool buildHaveNewVersion;  //写入状态

  AppUpdateInfo(
      {
        this.buildHaveNewVersion,
        this.mustUpdate,
        this.nowVersion,
        this.updateMessage,
        this.updateUrl});

  AppUpdateInfo.fromMap(Map<String, dynamic> json) {

    mustUpdate = json['mustUpdate'];
    nowVersion = json['nowVersion'].toString();
    updateMessage = json['updateMessage'];
    updateUrl = json['updateUrl'];
    buildHaveNewVersion = json['buildHaveNewVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mustUpdate'] = this.mustUpdate;
    data['nowVersion'] = this.nowVersion;
    data['updateMessage'] = this.updateMessage;
    data['updateUrl'] = this.updateUrl;
    data['buildHaveNewVersion'] = this.buildHaveNewVersion;
    return data;
  }
}