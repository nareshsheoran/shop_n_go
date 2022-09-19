// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/splash_page.dart';
import 'package:flutter/foundation.dart' as foundation;
// import 'package:device_preview/device_preview.dart';



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {

  if (foundation.kDebugMode) {
    debugPrint('release mode');
  } else {
    debugPrint('debug mode');
  }


  WidgetsFlutterBinding.ensureInitialized();
  // await DotEnv().load(fileName: '.env');
  await dotenv.load(fileName: 'assets/.env');
  // await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());

  // runApp(
  // DevicePreview(
  //   enabled: true,
  //   tools: const [...DevicePreview.defaultTools],
  //   builder: (context) =>const MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppDetails.appName,
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
