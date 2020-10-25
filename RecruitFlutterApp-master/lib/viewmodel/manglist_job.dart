class MangeListJob {
  static const _allJob = <ManageJobBean>[
    ManageJobBean(
        jobName: 'JavaScript',
        salary: '6-7k',
        address: '福州•金山',
        degree: '本科',
        exp: '1-3年'),
    ManageJobBean(
        jobName: '全栈工程师',
        salary: '20-30k',
        address: '福州•金山',
        degree: '本科',
        exp: '3-5年'),
  ];

  static List<ManageJobBean> loadJobList() {
    return _allJob;
  }
}

class ManageJobBean {
  final String jobName;
  final String salary;
  final String address;
  final String degree;
  final String exp;

  const ManageJobBean(
      {this.jobName, this.salary, this.address, this.degree, this.exp});
}
