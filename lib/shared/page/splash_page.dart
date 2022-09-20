// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:shop_n_go/home_page_dir/service/best_seller_service.dart';
import 'package:shop_n_go/home_page_dir/service/category_service.dart';
import 'package:shop_n_go/home_page_dir/service/favourite_service.dart';
import 'package:shop_n_go/home_page_dir/service/new_product_service.dart';
import 'package:shop_n_go/home_page_dir/service/recommended_service.dart';
import 'package:shop_n_go/shared/shared_preference_data/address_localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/fetch_data_SP.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/service/user_profile_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future init() async {
    await fetchDataSP();
    profile();
    decideScreen();
    services();
  }

  Future services() async {
    RecommendedService().fetchRecommendedDetails();
    CategoryService().fetchAllCategory();
    BestSellerService().fetchBestSellerDetails();
    NewProductService().fetchNewProduct();
  }

  Future profile() async {
    (ProfileDetails.userName == null || ProfileDetails.userName == "")
        ? ProfileDetails.userName == ''
        : await UserProfileService().fetchUserProfileDetails();
  }

  void decideScreen() async {
    print("decideScreen email::${ProfileDetails.email}");
    print("decideScreen userName::${ProfileDetails.userName}");

    (ProfileDetails.userName == null || ProfileDetails.userName == "")
        ? Future.delayed(const Duration(seconds: 2)).then((value) {
            Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
          })
        : Future.delayed(const Duration(seconds: 2)).then((value) {
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
