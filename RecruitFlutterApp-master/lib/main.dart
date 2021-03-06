import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/viewmodel/model_idenss.dart';
import 'package:recruit_app/viewpages/main_recruit.dart';
import 'package:recruit_app/viewpages/storage_manager.dart';


//void main() => runApp(ChangeNotifierProvider<IdentityModel>(create: (context)=>IdentityModel(),child: RecruitApp(),));
void main() async {

  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ChangeNotifierProvider<ModelIdenss>(
      create: (context)=>ModelIdenss(),child: MainRecruit(),
    )

    );
  }
}
