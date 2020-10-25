class ProjDataMe {
  static const _allProjectList = <ProjectMineBean>[
    ProjectMineBean(
        projectName: 'NBA 2K19',
        during: '2018-至今',
        duty: '产品研发',
        content: '负责数据采集，人物建模，人物模型训练，产品监控，性能监测。'),
  ];

  static List<ProjectMineBean> loadProjectList() {
    return _allProjectList;
  }
}

class ProjectMineBean {
  final String projectName;
  final String during;
  final String duty;
  final String content;

  const ProjectMineBean(
      {this.projectName, this.during, this.duty, this.content});
}
