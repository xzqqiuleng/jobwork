class MineItemBean {
  static const _allOptions = <MineBean>[
    MineBean(imgPath: 'images/pp_img_edit_resume_gray.png', itemName: '编辑简历', itemStatus: '1/3'),
    MineBean(imgPath: 'images/pp_img_job_intent_gray.png', itemName: '管理求职意向', itemStatus: '离职-随时到岗'),
    MineBean(imgPath: 'images/pp_img_love_gray.png', itemName: '收藏夹', itemStatus: ''),
    MineBean(imgPath: 'images/pp_img_blacklist_gray.png', itemName: '黑名单', itemStatus: ''),
    MineBean(imgPath: 'images/pp_img_help_gray.png', itemName: '切换角色', itemStatus: '老板'),
    MineBean(imgPath: 'images/pp_img_about_gray.png', itemName: '关于', itemStatus: ''),
  ];

  static List<MineBean> loadOptions() {
    return _allOptions;
  }

  static const _allBossOptions = <MineBean>[
    MineBean(imgPath: 'images/pp_img_cv.png', itemName: '职位管理', itemStatus: ''),
    MineBean(imgPath: 'images/pp_img_job_status.png', itemName: '企业管理', itemStatus: '未认证'),
    MineBean(imgPath: 'images/pp_img_sun.png', itemName: '公司信息', itemStatus: '未完善'),
    MineBean(imgPath: 'images/pp_img_help.png', itemName: '切换角色', itemStatus: '老板'),
    MineBean(imgPath: 'images/pp_img_service.png', itemName: '我的客服', itemStatus: ''),
    MineBean(imgPath: 'images/pp_img_about.png', itemName: '关于', itemStatus: ''),
  ];

  static List<MineBean> loadBossOptions() {
    return _allBossOptions;
  }
}

class MineBean {
  final String imgPath;
  final String itemName;
  final String itemStatus;

  const MineBean({this.imgPath, this.itemName, this.itemStatus});
}
