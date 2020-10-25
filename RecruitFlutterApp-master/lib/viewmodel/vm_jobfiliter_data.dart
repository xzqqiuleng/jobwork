class JobFilteData {
  static List<JobFilteSubBean> _schoolLevelData = <JobFilteSubBean>[
    JobFilteSubBean(filterName: '全部', isChecked: true),
    JobFilteSubBean(filterName: '初中及以下', isChecked: false),
    JobFilteSubBean(filterName: '高中', isChecked: false),
    JobFilteSubBean(filterName: '大学', isChecked: false),
    JobFilteSubBean(filterName: '研究生', isChecked: false),
    JobFilteSubBean(filterName: '硕士', isChecked: false),
    JobFilteSubBean(filterName: '博士', isChecked: false),
  ];

  static List<JobFilteSubBean> _salaryData = <JobFilteSubBean>[
    JobFilteSubBean(filterName: '全部', isChecked: true),
    JobFilteSubBean(filterName: '3K以下', isChecked: false),
    JobFilteSubBean(filterName: '3-5K', isChecked: false),
    JobFilteSubBean(filterName: '5-10K', isChecked: false),
    JobFilteSubBean(filterName: '10-20K', isChecked: false),
    JobFilteSubBean(filterName: '20-50K', isChecked: false),
    JobFilteSubBean(filterName: '50K以上', isChecked: false),
  ];

  static List<JobFilteSubBean> _expData = <JobFilteSubBean>[
    JobFilteSubBean(filterName: '全部', isChecked: true),
    JobFilteSubBean(filterName: '在校生', isChecked: false),
    JobFilteSubBean(filterName: '应届生', isChecked: false),
    JobFilteSubBean(filterName: '1年以内', isChecked: false),
    JobFilteSubBean(filterName: '1-3年', isChecked: false),
    JobFilteSubBean(filterName: '3-5年', isChecked: false),
    JobFilteSubBean(filterName: '5-10年', isChecked: false),
    JobFilteSubBean(filterName: '10年以上', isChecked: false),
  ];

  static List<JobFilteSubBean> _scaleData = <JobFilteSubBean>[
    JobFilteSubBean(filterName: '全部', isChecked: true),
    JobFilteSubBean(filterName: '0-20人', isChecked: false),
    JobFilteSubBean(filterName: '20-99人', isChecked: false),
    JobFilteSubBean(filterName: '100-499人', isChecked: false),
    JobFilteSubBean(filterName: '500-999人', isChecked: false),
    JobFilteSubBean(filterName: '1000-9999人', isChecked: false),
    JobFilteSubBean(filterName: '1000人以上', isChecked: false),
  ];

  static List<JobFiltsBean> _allJobFilterData = <JobFiltsBean>[
    JobFiltsBean(
      filterName: '学历要求',
      filterSubData: _schoolLevelData,
    ),
    JobFiltsBean(
      filterName: '薪资待遇',
      filterSubData: _salaryData,
    ),
    JobFiltsBean(
      filterName: '经验要求',
      filterSubData: _expData,
    ),
    JobFiltsBean(
      filterName: '公司规模',
      filterSubData: _scaleData,
    ),
  ];

  static List<JobFiltsBean> loadJobFilterData() {
    return _allJobFilterData;
  }
}

class CityFiltDtas {
  static List<JobFiltsBean> _allCityFilterData = <JobFiltsBean>[
    JobFiltsBean(
      filterName: 'A',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'B',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'C',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'D',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'E',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'F',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'G',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'H',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'I',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'J',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'K',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'L',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'M',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'N',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'O',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'P',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'Q',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'R',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'S',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'T',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'U',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'V',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'W',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'X',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'Y',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
    JobFiltsBean(
      filterName: 'Z',
      filterSubData: <JobFilteSubBean>[
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
        JobFilteSubBean(filterName: '洛杉矶', isChecked: false),
      ],
    ),
  ];

  static List<JobFiltsBean> loadCityFilterData() {
    return _allCityFilterData;
  }
}

class JobFiltsBean {
  String filterName;
  List<JobFilteSubBean> filterSubData;

  JobFiltsBean({this.filterName, this.filterSubData});
}

class JobFilteSubBean {
  String filterName;
  bool isChecked;

  JobFilteSubBean({this.filterName, this.isChecked});
}
