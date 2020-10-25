class CompanyAttrList {
  List<DataCompan>  _allAttr = <DataCompan>[
    DataCompan(attr: '公司介绍', status: '编辑'),
    DataCompan(attr: '产品及领域', status: '编辑'),
    DataCompan(attr: '投资及前景', status: '编辑'),
  ];

   List<DataCompan> loadAttrs() {
    return _allAttr;
  }
}

class DataCompan {
   String attr;
   String status;

   DataCompan({this.attr, this.status});
}
