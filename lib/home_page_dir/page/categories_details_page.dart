// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_details_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/product_add_cart_service.dart';

class CategoriesDetailsPage extends StatefulWidget {
  const CategoriesDetailsPage({Key? key}) : super(key: key);

  @override
  State<CategoriesDetailsPage> createState() => _CategoriesDetailsPageState();
}

class _CategoriesDetailsPageState extends State<CategoriesDetailsPage> {
  Object? id = '';
  bool isFavourite = false;

  List<ProductDetailsData> dataProductDetailsList = [];

  bool isLoading = false;

  late ProductDetailsData productDetailsData;

  Future fetchProductDetails() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse("${NetworkUtil.getProductDetailsUrl}$id");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      ProductDetailsReq bestSellerRequest =
          ProductDetailsReq.fromJson(jsonResponse);

      productDetailsData = bestSellerRequest.data!;

      setState(() {
        isLoading = false;
      });
    }
  }

  int listLength = 1;

  Future<bool>? _onBackPressed() {
    Navigator.canPop(context);
    Navigator.popAndPushNamed(context, AppRoutes.DashboardPage);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (id == "" || id == null) {
      ScreenArguments arguments =
          ModalRoute.of(context)?.settings.arguments as ScreenArguments;
      id = arguments.code;
      fetchProductDetails();
    }
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed()!;
      },
      child: Scaffold(
        body: SafeArea(
          child: isLoading
              ? Center(
                  child: CProgressIndicator.circularProgressIndicator,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 4,
                                vertical: 40),
                            child: Image(
                              height: 150,
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                Images.baseUrl + productDetailsData.itemImages!,
                                // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU",
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 10,
                            right: 12,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.CartPage);
                                },
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black,
                                ))),
                        Positioned(
                            top: 10,
                            left: 12,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.black,
                                ))),
                      ],
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDetailsData.itemName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            productDetailsData.description!,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListView.builder(
                          itemCount: listLength,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${productDetailsData.vendorMasters?.toUpperCase().replaceAll("V", "")}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    // SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image(
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(Images.baseUrl +
                                              productDetailsData.itemImages!),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.directions,
                                                    size:
                                                        IconDimension.iconSize,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                      "${productDetailsData.itemCategory!} KMS")
                                                ],
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: IconDimension.iconSize,
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                "${AppDetails.currencySign} ${productDetailsData.price?.toStringAsFixed(0)}"),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Constant.primaryColor),
                                                onPressed: () {
                                                  ProductAddCartService()
                                                      .proAddedIntoCart(
                                                          index,
                                                          productDetailsData
                                                              .itemCode);
                                                  setState(() {
                                                    // ProductAddCartService()
                                                    //               .statusCode ==
                                                    //           200
                                                    //       ? listLength = 0
                                                    //       : null;
                                                  });
                                                  // proAddedIntoCart(
                                                  //     index,
                                                  //     productDetailsData
                                                  //         .itemCode);
                                                },
                                                child: Text("ADD +"))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List imgList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6-DjY67mzulVMRq80hvI-mq8dImIOgKt5Cw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREArY26l80lxfHNDyJ_kcZZWVav8i4kPadgA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQjJbw3mOduJzO3hGipOnI-q0JzduC8kfzA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdckMBb1G75l-pI607XL2qItYa0sVc8vG--g&usqp=CAU",
  ];

  List nameList = [
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
  ];

  List distanceList = [
    "5",
    "6",
    "10",
    "10",
    "1",
    "8",
  ];
  List rateList = [
    "55",
    "66",
    "80",
    "31",
    "31",
    "18",
  ];
}

//
// ListView.builder(
// itemCount: rateList.length,
// shrinkWrap: true,
// // physics: NeverScrollableScrollPhysics(),
// itemBuilder: (context, index) {
// return Card(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("${nameList[index]}${index+1}"),
// SizedBox(height: 6),
// Row(
// children: [
// Image(
// height: 90,
// width: 90,
// fit: BoxFit.fill,
// image: NetworkImage(imgList[index]),
// ),
// SizedBox(width: 10),
// Expanded(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Row(
// children: [
// Icon(
// Icons.directions,
// size: IconDimension.iconSize,
// ),
// SizedBox(width: 8),
// Text(
// "${distanceList[index]} KMS")
// ],
// ),
// Icon(
// Icons.star,
// size: IconDimension.iconSize,
// ),
// SizedBox(width: 8),
// ],
// ),
// ),
// Column(
// children: [
// Text(
// "${AppDetails.currencySign} ${rateList[index]}"),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// primary:
// Constant.primaryColor),
// onPressed: () {
// proAddedIntoCart(
// index,
// productDetailsData
//     .itemCode);
// },
// child: Text("ADD +"))
// ],
// ),
// ],
// ),
// ],
// ),
// ),
// );
// },
// ),
