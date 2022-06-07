import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_workout_diary_app/global/style/lib_color_schemes.g.dart';
import 'package:my_workout_diary_app/page_home.dart';
import 'package:my_workout_diary_app/route.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      onGenerateRoute: Routers.generateRoute,
      debugShowCheckedModeBanner: false,
      home: const PageHome(),
    );
  }
}
