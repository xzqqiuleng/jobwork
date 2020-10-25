import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recruit_app/viewpages/http/update_response.dart';
import 'package:recruit_app/viewpages/utils/util_plats.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'basemodel_viewstate.dart';
import 'bean_update.dart';
const kAppFirstEntry = 'kAppFirstEntry';

// 主要用于app启动相关
class AppModel with ChangeNotifier {
  bool isFirst = false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class ProviderUpdateModel extends BaseModelViewState {
  Future<BeanUpdate> checkUpdate() async {
    BeanUpdate appUpdateInfo;
    setBusy();
    try {
      var appVersion = await UtilsPlatform.getAppVersion();
      appUpdateInfo =
          await UpdateResponse().checkUpdate(appVersion);
      setIdle();
    } catch (e, s) {
      setError(e,s);
    }
    return appUpdateInfo;
  }
}
