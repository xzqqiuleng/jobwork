class User {
  String userSex;
  String userMail;
  String mail;
  String userId;
  String userName;
  String headImg;
  String birth;
  String type;
  String wxId;
  int status;

  User(
      {this.userSex,
        this.userMail,
        this.mail,
        this.userId,
        this.userName,
        this.headImg,
        this.birth,
        this.type,
        this.wxId,
        this.status});

  User.fromJson(Map<String, dynamic> json) {
    userSex = json['user_sex'];
    userMail = json['user_mail'];
    mail = json['mail'];
    userId = json['user_id'];
    userName = json['user_name'];
    headImg = json['head_img'];
    birth = json['birth'];
    type = json['type'].toString();
    wxId = json['wx_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_sex'] = this.userSex;
    data['user_mail'] = this.userMail;
    data['mail'] = this.mail;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['head_img'] = this.headImg;
    data['birth'] = this.birth;
    data['type'] = this.type;
    data['wx_id'] = this.wxId;
    data['status'] = this.status;
    return data;
  }
}