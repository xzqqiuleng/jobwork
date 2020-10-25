import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colors_utils.dart';
import 'package:recruit_app/viewmodel/datalist_empl.dart';
import 'package:recruit_app/viewpages/jobpages/search_compyjobs.dart';

import 'barsele_emp.dart';


class ListDataEmp extends StatefulWidget {
  @override
  _ListDataEmpState createState() {
    // TODO: implement createState
    return _ListDataEmpState();
  }
}

class _ListDataEmpState extends State<ListDataEmp> {
  List<Empyess> _employeeList = DataListEmpl.loadEmployees();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar (
        automaticallyImplyLeading:false,
         elevation: 0,
        title: Text("人才库",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: ColorsUtils.app_main,

        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchCompanyJobs(searchType: SearchType.jl)));
            },

          child: Image.asset("images/pp_icon_home_search_20x20_@3x.png",height: 22,width: 22,
                color: Colors.white),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: BarseleEmp()
    );
  }
}
