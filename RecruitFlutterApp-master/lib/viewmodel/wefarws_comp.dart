class WelfareDataComp {
  static const _allWelfareList = <WelfBean>[
    WelfBean(welfare: '五险一金'),
    WelfBean(welfare: '补充医疗保险'),
    WelfBean(welfare: '定期体检'),
    WelfBean(welfare: '年终奖'),
    WelfBean(welfare: '带薪年假'),
    WelfBean(welfare: '员工旅游'),
    WelfBean(welfare: '免费班车'),
    WelfBean(welfare: '交通补助'),
    WelfBean(welfare: '包吃'),
    WelfBean(welfare: '节日福利'),
    WelfBean(welfare: '无息房贷'),
  ];

  static List<WelfBean> loadWelfareList() {
    return _allWelfareList;
  }
}

class WelfBean {
  final String welfare;

  const WelfBean({this.welfare});
}
