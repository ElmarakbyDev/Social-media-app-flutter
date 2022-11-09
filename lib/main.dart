import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/services/localization_service.dart';
import 'core/services/shared_prefs.dart';

Future<void> main() async {
  //============================================================================
  WidgetsFlutterBinding.ensureInitialized();
  //=============================== Firebase ====================================
  await Firebase.initializeApp();

  //============================== Shared Preferences =================================
  SharedPreferences pref = await SharedPreferences.getInstance();
  Get.put(SharedPrefService(prefs: pref));
  //============================== Localization =================================
  Get.put(LocalizationService());
  //============================================================================
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //============================================================================
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://7d857f1766ca4c57a9a8e72e94ddc970@o1189629.ingest.sentry.io/4504112367599616';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.

      options.tracesSampleRate = 0.0;
    },
    //============================================================================
    appRunner: () => runApp(const MyApp()),
  );
}
