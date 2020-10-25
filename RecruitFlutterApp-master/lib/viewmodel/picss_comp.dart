class PicssCompy {
  static const _allCompanyPicList = <CompyPicBean>[
    CompyPicBean(picPath: 'images/pp_timg1.png'),
    CompyPicBean(picPath: 'images/pp_timg2.png'),
    CompyPicBean(picPath: 'images/pp_timg3.png'),
    CompyPicBean(picPath: 'images/pp_timg1.png'),
    CompyPicBean(picPath: 'images/pp_timg2.png'),
    CompyPicBean(picPath: 'images/pp_timg3.png'),
  ];

  static List<CompyPicBean> loadCompanyPicList() {
    return _allCompanyPicList;
  }
}

class CompyPicBean {
  final String picPath;

  const CompyPicBean({this.picPath});
}
