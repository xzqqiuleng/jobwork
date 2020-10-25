class MyUser {
  String userSex;
  String userMail;
  String mail;
  String userId;
  String userName;
  String headImg;
  String birth;
  String type;
  String wxId;
  String title ;
  String resumeStatus ;
  int  status;
  String  infoStatus;
  String  jlStatus;
  String  companyStatus;
  String  realStatus;
  MyUser(
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

  MyUser.fromJson(Map<String, dynamic> json) {
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
    title = json['title'];
    resumeStatus = json['resume_status'];
    infoStatus = json['info_status'].toString();
    jlStatus = json['jl_status'].toString();
    companyStatus = json['company_status'].toString();
    realStatus = json['real_status'].toString();
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
    data['title'] = this.title;
    data['resume_status'] = this.resumeStatus;
    data['info_status'] = this.infoStatus;
    data['jl_status'] = this.jlStatus;
    data['company_status'] = this.companyStatus;
    data['real_status'] = this.realStatus;
    return data;
  }
}