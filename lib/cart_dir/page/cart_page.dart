// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/cart_dir/model/all_cart_prod_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_details_req.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Object? number = 0;
  Object? id = '';

  List<AllCartProductData> dataAllCartProductList = [];
  bool isLoading = false;

  Future fetchAllCartProductDataDetails() async {
    setState(() {
      isLoading = true;
      number = 1;
    });
    Uri myUri =
        // Uri.parse("${NetworkUtil.getOrderDetailsUrl}${ProfileDetails.id}");
        Uri.parse("${NetworkUtil.getAllCartProductUrl}${ProfileDetails.id}");
    Response response = await get(myUri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AllCartProductReq allCartProductData =
          AllCartProductReq.fromJson(jsonResponse);
      List<AllCartProductData> list = allCartProductData.data!;

      dataAllCartProductList.addAll(list);
      fetchProductDetails();
      setState(() {
        isLoading = false;
      });
    }
  }

  double sum = 0;
  double ordersSum = 0;
  double costTotal = 0;
  double deliveryCost = 0;

  double totalSum() {
    sum = 0;
    for (int i = 0; i < productDetailsDataList.length; i++) {
      setState(() {
        sum += itemData[i].counter;
        sum;
      });
    }
    return sum;
  }

  double totalOrderSum() {
    ordersSum = 0;
    for (int i = 0; i < productDetailsDataList.length; i++) {
      setState(() {
        ordersSum += ((productDetailsDataList[i].price) * itemData[i].counter);
        ordersSum;
      });
    }
    ordersSum;

    return ordersSum;
  }

  double totalDeliveryCost() {
    setState(() {
      costTotal = deliveryCost + ordersSum;
    });
    return costTotal;
  }

  void init() {
    totalSum();
    totalOrderSum();
    totalDeliveryCost();
  }

  @override
  void initState() {
    super.initState();
    fetchAllCartProductDataDetails();
  }

  Future<bool>? _onBackPressed() {
    Navigator.canPop(context);
    Navigator.popAndPushNamed(context, AppRoutes.DashboardPage);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed()!;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("CART",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                    ],
                  ),
                ),
                (isDetailsLoading || isLoading)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CProgressIndicator.circularProgressIndicator,
                            SizedBox(height: 16),
                            Text("Please Wait..",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            // Text(
                            //     "${(dataAllCartProductList.length) - (productDetailsDataList.length)}",
                            //     style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        )),
                      )
                    : productDetailsDataList.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("No Item In Cart")))
                        : Column(
                            children: [
                              ListView.builder(
                                // itemCount: imgList.length,
                                itemCount: productDetailsDataList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(context, AppRoutes.StoresDetailsPage,
                                      //     arguments: nameList[index]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  // productDetailsDataList[index]
                                                  //     .vendorMasters,
                                                  productDetailsDataList[index]
                                                      .itemName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          AppRoutes
                                                              .CategoriesDetailsPage,
                                                          arguments: ScreenArguments(
                                                              Images
                                                                      .baseUrl +
                                                                  productDetailsDataList[
                                                                          index]
                                                                      .itemImages!,
                                                              productDetailsDataList[
                                                                      index]
                                                                  .itemName!,
                                                              productDetailsDataList[
                                                                      index]
                                                                  .description!,
                                                              productDetailsDataList[
                                                                      index]
                                                                  .itemCode!));
                                                    },
                                                    child: Image(
                                                      height: 70,
                                                      width: 70,
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(Images
                                                              .baseUrl +
                                                          productDetailsDataList[
                                                                  index]
                                                              .itemImages),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .directions,
                                                                size: IconDimension
                                                                    .iconSize),
                                                            SizedBox(width: 8),
                                                            Expanded(child: Text(
                                                                // "${((productDetailsDataList[index].price) * (itemData[index].counter)).toStringAsFixed(0)}")),
                                                                "Price ${((productDetailsDataList[index].price) * (itemData[index].counter)).toStringAsFixed(0)}")),
                                                            Icon(
                                                                Icons
                                                                    .card_travel,
                                                                size: IconDimension
                                                                    .iconSize),
                                                            SizedBox(width: 8),
                                                            itemData[index]
                                                                        .counter ==
                                                                    1
                                                                ? Text(
                                                                    // "${itemData[index].counter} Items"),
                                                                    "${itemData[index].counter} Item")
                                                                : Text(
                                                                    // "${itemData[index].counter} Items"),
                                                                    "${itemData[index].counter} Items"),
                                                          ],
                                                        ),
                                                        SizedBox(height: 8),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Icon(Icons.star,
                                                                size: IconDimension
                                                                    .iconSize),
                                                            SizedBox(width: 8),
                                                            counterWidget(
                                                                index),
                                                            // ElevatedButton(
                                                            //     style: ElevatedButton
                                                            //         .styleFrom(
                                                            //             // minimumSize: Size(50, 30),
                                                            //             primary:
                                                            //                 Constant
                                                            //                     .primaryColor),
                                                            //     onPressed: () {
                                                            //       Navigator.pushNamed(
                                                            //           context,
                                                            //           AppRoutes
                                                            //               .CartDetailsPage,
                                                            //           arguments: number);
                                                            //     },
                                                            //     child: Text(
                                                            //         "VIEW ITEMS"))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            productDetailsDataList.length == 1
                                                ? Text("Total Item Count:")
                                                : Text("Total Items Count:"),
                                            SizedBox(height: 4),
                                            productDetailsDataList.length == 1
                                                ? Text("Total Item Amount:")
                                                : Text("Total Items Amount:"),
                                            SizedBox(height: 4),
                                            Text("Delivery Cost:"),
                                            SizedBox(height: 4),
                                            Text("Total Bill Amount:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            productDetailsDataList.length == 1
                                                ? Text(
                                                    "${sum.toStringAsFixed(0)} Item")
                                                : Text(
                                                    "${sum.toStringAsFixed(0)} Items"),
                                            SizedBox(height: 4),
                                            Text(
                                                "${AppDetails.currencySign} ${ordersSum.toStringAsFixed(0)}"),
                                            // Text("${AppDetails.currencySign}"),
                                            SizedBox(height: 4),
                                            Text(
                                                "${AppDetails.currencySign} ${deliveryCost.toStringAsFixed(0)}"),
                                            // "${AppDetails.currencySign}"),
                                            SizedBox(height: 4),
                                            Text(
                                                "${AppDetails.currencySign} ${costTotal.toStringAsFixed(0)}",
                                                // Text("${AppDetails.currencySign} ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Delivery to HOME",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          AddressDetails.flat == ''
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.AddressPage);
                                                  },
                                                  child: Text("Enter Address",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Colors.blue)))
                                              : SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                ),
                                          AddressDetails.flat == ''
                                              ? Text("")
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.AddressPage);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text("Change Address",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color:
                                                                  Colors.blue))
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50),
                                        primary: Constant.primaryColor),
                                    onPressed: () {
                                      AddressDetails.flat == ""
                                          ? Fluttertoast.showToast(
                                              msg:
                                                  "Please Enter Delivery Address")
                                          : Navigator.pushNamed(
                                              context, AppRoutes.OrderPage,
                                              arguments:
                                                  costTotal.toStringAsFixed(0));
                                    },
                                    child: Text("PROCEED TO BUY")),
                              ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isDetailsLoading = false;
  late ProductDetailsData productDetailsData;
  List productDetailsDataList = [];

  Future fetchProductDetails() async {
    setState(() {
      isDetailsLoading = true;
    });
    for (int i = 0; i < dataAllCartProductList.length; i++) {
      Uri myUri = Uri.parse(
          "${NetworkUtil.getProductDetailsUrl}${dataAllCartProductList[i].addedProIntoCart}");
      Response response = await get(myUri);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        ProductDetailsReq productDetailsReq =
            ProductDetailsReq.fromJson(jsonResponse);

        productDetailsData = productDetailsReq.data!;
        productDetailsDataList.add(productDetailsData);
        init();
      }
    }
    setState(() {
      isDetailsLoading = false;
      id = ProfileDetails.id;
    });
  }

  Widget counterWidget(int index) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 34,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white70)),
      child: Row(
        children: <Widget>[
          InkWell(
              onTap: () {
                setState(() {
                  itemData[index].counter == 1
                      ? null
                      : itemData[index].counter--;
                  init();

                  itemData[index].shouldVisible =
                      !itemData[index].shouldVisible;
                });
              },
              child: Center(
                  child: Icon(
                Icons.remove,
                color: Constant.primaryColor,
                size: 28,
              ))),
          SizedBox(width: 8),
          Text(
            '${itemData[index].counter}',
            style: const TextStyle(color: Colors.black),
          ),
          SizedBox(width: 8),
          InkWell(
              onTap: () {
                setState(() {
                  itemData[index].counter == 99
                      ? null
                      : itemData[index].counter++;
                  itemData[index].shouldVisible =
                      !itemData[index].shouldVisible;
                  init();
                });
              },
              child: Center(
                  child: Icon(
                Icons.add,
                color: Constant.primaryColor,
                size: 28,
              ))),
        ],
      ),
    );
  }

  List imgList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6-DjY67mzulVMRq80hvI-mq8dImIOgKt5Cw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREArY26l80lxfHNDyJ_kcZZWVav8i4kPadgA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQjJbw3mOduJzO3hGipOnI-q0JzduC8kfzA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdckMBb1G75l-pI607XL2qItYa0sVc8vG--g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJaCYKmaRi3xV2Q-0WhIy6-8OomW7rpc2DFg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6-DjY67mzulVMRq80hvI-mq8dImIOgKt5Cw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU"
  ];

  List nameList = [
    "Spencer Stores 01",
    "Spencer Stores 02",
    "Spencer Stores 03",
    "Spencer Stores 04",
    "Spencer Stores 05",
    "Spencer Stores 06",
    "Spencer Stores 07",
    "Spencer Stores 08",
  ];

  List distanceList = [
    "5",
    "6",
    "10",
    "1",
    "6",
    "10",
    "1",
    "8",
  ];
  List itemList = [
    "55",
    "66",
    "80",
    "31",
    "66",
    "80",
    "31",
    "18",
  ];
}
