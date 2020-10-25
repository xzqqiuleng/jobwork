class EduDataMine {
  static const _allEduList = <MeEduBean>[
    MeEduBean(school: '福建省福州市福州大学', during: '2012-2016', profession: '计算机科学与技术', level: '本科'),
  ];

  static List<MeEduBean> loadEduList() {
    return _allEduList;
  }
}

class MeEduBean {
  final String school;
  final String during;
  final String profession;
  final String level;

  const MeEduBean({this.school, this.during, this.profession, this.level});
}
