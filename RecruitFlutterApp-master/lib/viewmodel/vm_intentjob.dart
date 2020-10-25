class VmIntentJob {
  static const _allIntent = <IntentBean>[
    IntentBean(city: '福州', jobName: '高级运营', industry: '互联网', salary: '10-13k'),
    IntentBean(city: '厦门', jobName: '运营总监', industry: '行业不限', salary: '20-23k'),
  ];

  static List<IntentBean> loadJobIntent() {
    return _allIntent;
  }
}

class IntentBean {
  final String city;
  final String jobName;
  final String industry;
  final String salary;

  const IntentBean({this.city, this.jobName, this.industry, this.salary});
}
