// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';
import 'package:shop_n_go/shared/splash_page.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DotEnv().load(fileName: '.env');
  await dotenv.load(fileName: 'assets/.env');
  // await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: Constant.primaryColor,
              iconTheme: IconThemeData(
                color: Constant.primaryColor,
              )),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Constant.primaryColor,
            selectedIconTheme: IconThemeData(color: Constant.primaryColor),
            // backgroundColor: Constant.primaryColor,
          ),
          primaryColor: Constant.primaryColor,
          iconTheme: IconThemeData(color: Constant.primaryColor)),
      home: SplashPage(),
      color: Constant.primaryColor,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
