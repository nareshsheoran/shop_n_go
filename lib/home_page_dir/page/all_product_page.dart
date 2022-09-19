// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_product_req.dart';
import 'package:shop_n_go/home_page_dir/service/new_product_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';
import '../model_req/all_product_req.dart';
import 'package:http/http.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:
                          Icon(Icons.arrow_back_rounded, color: Colors.black)),
                  SizedBox(width: 8),
                  Text(
                    "All Product",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(32.0)),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: searchController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
            (NewProductService().isLoadingAllProd)
                ? SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CProgressIndicator.circularProgressIndicator,
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: NewProductService().dataAllProdList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                        ),
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.CategoriesDetailsPage,
                                  arguments: ScreenArguments(
                                      Images.baseUrl +
                                          NewProductService()
                                              .dataAllProdList[index]
                                              .itemImages!,
                                      NewProductService()
                                          .dataAllProdList[index]
                                          .itemName!,
                                      "description",
                                      NewProductService()
                                          .dataAllProdList[index]
                                          .itemCode!));
                            },
                            child: Container(
                              width: 110,
                              height: 140,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 4),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image(
                                                width:
                                                    ImageDimension.imageWidth -
                                                        16,
                                                height:
                                                    ImageDimension.imageHeight,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(Images
                                                        .baseUrl +
                                                    NewProductService()
                                                        .dataAllProdList[index]
                                                        .itemImages!)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              NewProductService()
                                                  .dataAllProdList[index]
                                                  .itemName!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${AppDetails.currencySign}${NewProductService().dataAllProdList[index].offerPrice?.toStringAsFixed(0)}",
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
                                          _isFavorite
                                              ? AddProdIntoFavService()
                                                  .addProdIntoFav(
                                                      NewProductService()
                                                          .dataAllProdList[
                                                              index]
                                                          .itemCode)
                                              : Fluttertoast.showToast(
                                                  msg: "Favourite Removed");
                                        },
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

List imageList = [
  Images.vegetablesImg,
  Images.chillyImg,
  Images.tomatoImg,
  Images.ladiesFingerImg,
  Images.onionImg,
  Images.potatoImg,
  Images.radisImg,
  Images.fruitsImg,
  Images.mangoImg,
  Images.bananaImg,
  Images.grapesImg,
  Images.nutsImg,
  Images.munchesImg,
  Images.hippoNutsImg,
  Images.milkImg,
  Images.softDrinksImg,
  Images.oreoImg,
  Images.biscuitsImg,
  Images.iceCreamImg,
  Images.oilImg,
  Images.soapImg,
  Images.lifeBoyImg,
];

List nameList = [
  "Vegetables",
  "Chilly",
  "Tomato",
  "Ladies Finger",
  "Onion",
  "Potato",
  "Radis",
  "Fruits",
  "Mango",
  "Banana",
  "Grapes",
  "Nuts",
  "Munchies",
  "Happilo Nuts",
  "Milk",
  "Soft Drinks",
  "Oreo",
  "Biscuits",
  "Ice Cream",
  "Oil",
  "Soaps",
  "Life Boy",
];
List rateList = [
  "49",
  "65",
  "49",
  "65",
  "49",
  "49",
  "65",
  "65",
  "49",
  "65",
  "65",
  "65",
  "49",
  "49",
  "65",
  "49",
  "65",
  "49",
  "65",
  "49",
  "65",
  "49",
];
