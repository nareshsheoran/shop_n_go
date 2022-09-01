// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/localdb.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future init() async {
    ProfileDetails.id = await LocalDataSaver.getID();
    ProfileDetails.name = await LocalDataSaver.getName();
    ProfileDetails.userName = await LocalDataSaver.getUserName();
    ProfileDetails.email = await LocalDataSaver.getEmail();
    ProfileDetails.phone = await LocalDataSaver.getPhone();
    ProfileDetails.password = await LocalDataSaver.getPassword();
    ProfileDetails.img = await LocalDataSaver.getImg();
    ProfileDetails.signUpToken = await LocalDataSaver.getSignUpToken();
    ProfileDetails.loginToken = await LocalDataSaver.getLoginToken();
    ProfileDetails.resendPhone = await LocalDataSaver.getResendPhone();
    decideScreen();
  }

  void decideScreen() async {
    print("decideScreen userName::${ProfileDetails.userName}");

    ProfileDetails.userName == null
        ? Future.delayed(const Duration(seconds: 4)).then((value) {
            Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
          })
        : Future.delayed(const Duration(seconds: 4)).then((value) {
            Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
          });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            // color: Constant.primaryColor
            // color: Colors.orangeAccent
            // image: DecorationImage(
            //     image: AssetImage("assets/images/bg_img.jpg"),
            //     fit: BoxFit.fitHeight),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const CircleAvatar(
              //   radius: 60,
              // backgroundImage: AssetImage("assets/images/logo.jpeg"),
              // foregroundImage: AssetImage("assets/images/logo.jpeg"),
              // foregroundImage: Images.logoImg,
              // ),
              const SizedBox(height: 20),
              Text(AppDetails.appName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    // color: Colors.white
                    // color: Constant.primaryColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
