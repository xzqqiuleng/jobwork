class CompanyAttrList {
  List<CompanyAttr>  _allAttr = <CompanyAttr>[
    CompanyAttr(attr: '公司介绍', status: '编辑'),
    CompanyAttr(attr: '产品及领域', status: '编辑'),
    CompanyAttr(attr: '投资及前景', status: '编辑'),
  ];

   List<CompanyAttr> loadAttrs() {
    return _allAttr;
  }
}

class CompanyAttr {
   String attr;
   String status;

   CompanyAttr({this.attr, this.status});
}
