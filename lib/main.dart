import 'package:find_best_route/util/log_util.dart';
import 'package:find_best_route/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceUtil().init();
  //requesetPermision();
  LogUtil.init(tag: "KhaiTQ", isDebug: true);
  runApp(const MyApp());
}
