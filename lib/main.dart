import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/firebase_options.dart';
import 'package:my_workout_diary_app/global/model/model_config.dart';
import 'package:my_workout_diary_app/global/provider/auth_provider.dart';
import 'package:my_workout_diary_app/global/provider/user_provider.dart';
import 'package:my_workout_diary_app/global/provider/timer_provider.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/page_home.dart';
import 'package:my_workout_diary_app/route.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) async {
    kakao.KakaoSdk.init(
      nativeAppKey: '0ce0a45061c3064eba6d0e8d1f960317',
    );
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await readConfigFile();
    MobileAds.instance.initialize();
    runApp(const MyApp());
  });
}

Future<void> readConfigFile() async {
  var configJson;

  configJson = await rootBundle.loadString('assets/texts/config.json');

  print(configJson);
  final configObject = jsonDecode(configJson);
  ModelConfig().fromJson(configObject);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RecordProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: DSColors.blue5,
            appBarTheme: AppBarTheme(
              color: DSColors.white,
              foregroundColor: DSColors.black,
              elevation: 0,
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white),
        onGenerateRoute: Routers.generateRoute,
        debugShowCheckedModeBanner: false,
        home: PageHome(),
      ),
    );
  }
}
