// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop_n_go/cart_dir/service/cart_product_service.dart';
import 'package:shop_n_go/home_page_dir/service/best_seller_service.dart';
import 'package:shop_n_go/home_page_dir/service/category_service.dart';
import 'package:shop_n_go/home_page_dir/service/favourite_service.dart';
import 'package:shop_n_go/home_page_dir/service/new_product_service.dart';
import 'package:shop_n_go/home_page_dir/service/recommended_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/fetch_data_SP.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/service/user_profile_service.dart';
import 'package:shop_n_go/stores_dir/service/store_list_service.dart';

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
    RecommendedService.getInstance().fetchRecommendedDetails();
    CategoryService.getInstance().fetchAllCategory();
    BestSellerService.getInstance().fetchBestSellerDetails();
    NewProductService.getInstance().fetchNewProduct();
    StoreListService.getInstance().fetchStoreDetails();
    CartProductService.getInstance().fetchStoreListCartDetails();
    // CartProductService.getInstance().fetchAllCartProductDataDetails();
    // FavouriteService.getInstance().fetchFavouriteDetails();
    setState(() {});
  }

  bool isLogin = false;

  getLoggedInState() async {
    await LocalDataSaver.getLogData().then((value) {
      setState(() {
        value == null ? LocalDataSaver.saveLoginData(false) : isLogin = value;
      });
    });
  }

  Future profile() async {
    // LocalDataSaver.saveLoginData(true);

    // (ProfileDetails.userName == null || ProfileDetails.userName == "")
    //     ? ProfileDetails.userName == ''
    //     : await UserProfileService().fetchUserProfileDetails();

    isLogin == true
        ? await UserProfileService.getInstance().fetchUserProfileDetails()
        : null;
  }

  void decideScreen() async {
    print("decideScreen email::${ProfileDetails.email}");
    print("decideScreen userName::${ProfileDetails.userName}");
    await services();

    (ProfileDetails.userName == null || ProfileDetails.userName == "")
        ? Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
          })
        : Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
          });
  }

  @override
  void initState() {
    getLoggedInState();
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewProductService.getInstance().dataAllProdList.isNotEmpty
        ? services()
        : null;
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
