// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_product_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/best_seller_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/recommended_req.dart';
import 'package:shop_n_go/home_page_dir/widget/best_seller_widget.dart';
import 'package:shop_n_go/home_page_dir/widget/category_widget.dart';
import 'package:shop_n_go/home_page_dir/widget/favourite_widget.dart';
import 'package:shop_n_go/home_page_dir/widget/new_product_widget.dart';
import 'package:shop_n_go/home_page_dir/widget/recommended_widget.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/home_page_dir/model_req/favrt_add_req_res.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // bool isFavourite = false;

  // late int selectedRecommendedIndex;

  // late int selectedProductIndex;
  int tabIndex = 1;

  Widget? tabWidget() {
    if (tabIndex == 1) {
      return RecommendedWidget();
    } else {
      return FavouriteWidget();
    }
  }

  List tabList = ["All Categories", "Best Sellers", "New Products"];

  int categoryTabIndex = 1;

  Widget? categoryTabWidget() {
    if (categoryTabIndex == 1) {
      return CategoryWidget();
    } else if (categoryTabIndex == 2) {
      return BestSellerWidget();
    } else {
      return NewProductWidget();
    }
  }

  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Hi, ${ProfileDetails.userName}!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                      },
                      child: isFavourite
                          ? Icon(
                              Icons.favorite,
                              size: IconDimension.iconSize + 4,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: IconDimension.iconSize + 4,
                            ),
                    ),
                    SizedBox(width: 14),
                    Icon(
                      Icons.info_outline,
                      size: IconDimension.iconSize + 4,
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 2, 40),
                        primary: Constant.primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.MapSearchPage);
                    },
                    child: Text("In House Shopping")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: CardDimension.elevation,
                  shadowColor: CardDimension.shadowColor,
                  child: Image(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      image: AssetImage(Images.logoImg)
                      // NetworkImage(
                      //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU"),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          tabIndex = 1;
                          setState(() {
                            print(tabIndex);
                            // fetchRecommendedDetails();
                          });
                        },
                        child: Column(
                          children: [
                            tabIndex == 1
                                ? buildTextStyle(
                                    "Recommended", Constant.primaryColor)
                                : buildTextStyle(
                                    "Recommended",
                                    Colors.black,
                                  ),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: tabIndex == 1
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 3))
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          tabIndex = 2;
                          setState(() {
                            print(tabIndex);
                            // fetchRecommendedDetails();
                          });
                        },
                        child: Column(
                          children: [
                            tabIndex == 2
                                ? buildTextStyle(
                                    "Favorite",
                                    Constant.primaryColor,
                                  )
                                : buildTextStyle("Favorite", Colors.black),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: tabIndex == 2
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 3))
                          ],
                        )),
                  ],
                ),
              ),
              tabWidget()!,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          categoryTabIndex = 1;
                          setState(() {
                            print(categoryTabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            categoryTabIndex == 1
                                ? buildTextStyle(
                                    tabList[0], Constant.primaryColor)
                                : buildTextStyle(
                                    tabList[0],
                                    Colors.black,
                                  ),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: categoryTabIndex == 1
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 3))
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          categoryTabIndex = 2;
                          setState(() {
                            print(categoryTabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            categoryTabIndex == 2
                                ? buildTextStyle(
                                    tabList[1],
                                    Constant.primaryColor,
                                  )
                                : buildTextStyle(tabList[1], Colors.black),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: categoryTabIndex == 2
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 4))
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          categoryTabIndex = 3;
                          setState(() {
                            print(categoryTabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            categoryTabIndex == 3
                                ? buildTextStyle(
                                    tabList[2],
                                    Constant.primaryColor,
                                  )
                                : buildTextStyle(tabList[2], Colors.black),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: categoryTabIndex == 3
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 4))
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (categoryTabIndex == 1) {
                            Navigator.pushNamed(
                                context, AppRoutes.AllCategorySearch,
                                arguments: tabList[0]);
                          } else if (categoryTabIndex == 2) {
                            Navigator.pushNamed(
                                context, AppRoutes.AllBestSellerProduct,
                                arguments: tabList[1]);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.AllProductPage,
                                // arguments: tabList[categoryTabIndex - 1]);
                                arguments: tabList[2]);
                          }
                        },
                        child: Text("View All",
                            style: TextStyle(
                                color: Constant.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              categoryTabWidget()!,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextStyle(title, color) {
    return Text(title,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w600,
        ));
  }
}
