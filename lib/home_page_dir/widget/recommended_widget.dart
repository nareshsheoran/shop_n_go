// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/home_page_dir/service/favourite_service.dart';
import 'package:shop_n_go/home_page_dir/service/recommended_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';

class RecommendedWidget extends StatefulWidget {
  const RecommendedWidget({Key? key}) : super(key: key);

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  @override
  void initState() {
    // RecommendedService.getInstance().fetchRecommendedDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (RecommendedService.getInstance().isLoadingRecommended)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CProgressIndicator.circularProgressIndicator,
                SizedBox(height: 16),
                Text("Please Wait..",
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            )),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: RecommendedService.getInstance()
                      .dataRecommendedList
                      .length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item =
                        RecommendedService.getInstance().dataRecommendedList;
                    return SizedBox(
                      width: 115,
                      height: 160,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.CategoriesDetailsPage,
                              arguments: ScreenArguments(
                                  Images.baseUrl + item[index].itemImages!,
                                  item[index].itemName!,
                                  item[index].description!,
                                  item[index].itemCode!));
                        },
                        child: Stack(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Image(
                                          width: ImageDimension.imageWidth - 16,
                                          height: ImageDimension.imageHeight,
                                          // fit: BoxFit.fill,
                                          fit: BoxFit.scaleDown,
                                          image: NetworkImage(Images.baseUrl +
                                              item[index].itemImages!)),
                                      // image: NetworkImage("${NetworkUtil.baseUrl}${dataRecommendedList[index].itemImages!}")),
                                    ),
                                    Expanded(
                                      child: Text(
                                        item[index].itemName!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppDetails.currencySign}${item[index].price?.toStringAsFixed(0)}",
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 6,
                                right: 8,
                                child: FavoriteButton(
                                  iconSize: 32,
                                  isFavorite: false,
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite : $_isFavorite');
                                    if (_isFavorite) {
                                      FavouriteService.getInstance()
                                          .fetchFavouriteDetails();
                                      AddProdIntoFavService.getInstance().addProdIntoFav(
                                          item[index].itemCode,
                                          item[index].vendorId);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Favourite Removed");
                                    }
                                  },
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
  }
}
