// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_final_fields

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
  List<AllCartProductData> dataAllCartProductList = [];
  bool isLoading = false;

  Future fetchAllCartProductDataDetails() async {
    dataAllCartProductList.clear();
    setState(() {
      isLoading = true;
    });
    Uri myUri =
        Uri.parse("${NetworkUtil.getAllCartProductUrl}${ProfileDetails.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AllCartProductReq allCartProductData =
          AllCartProductReq.fromJson(jsonResponse);
      List<AllCartProductData> list = allCartProductData.data!;
      dataAllCartProductList.addAll(list);
      if (mounted) {
        setState(() {
          fetchProductDetails();
          isLoading = false;
        });
      }
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
    fetchAllCartProductDataDetails();
    init();
    super.initState();
  }

  void _onRefresh() async {
    // CartProductService().dataAllCartProductList.clear();
    productDetailsDataList.clear();
    await Future.delayed(Duration(milliseconds: 1000));

    fetchAllCartProductDataDetails();
    setState(() {
      init();
      isDetailsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: (isDetailsLoading || isLoading)
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
                    ],
                  ))
                )
              : (productDetailsDataList.isEmpty &&
                      dataAllCartProductList.isEmpty &&
                      isDetailsLoading == false)
                  ? RefreshIndicator(
                      onRefresh: () async {
                        isDetailsLoading = true;
                        _onRefresh();
                        setState(() {});
                      },
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text("No Item In Cart")))
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        isDetailsLoading = true;
                        _onRefresh();
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("CART",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18))
                                ],
                              ),
                            ),
                            ListView.builder(
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
                                                                .itemImages))),
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
                                                          Icon(Icons.directions,
                                                              size: IconDimension
                                                                  .iconSize),
                                                          SizedBox(width: 8),
                                                          Expanded(child: Text(
                                                              // "${((productDetailsDataList[index].price) * (itemData[index].counter)).toStringAsFixed(0)}")),
                                                              "Price ${((productDetailsDataList[index].price) * (itemData[index].counter)).toStringAsFixed(0)}")),
                                                          Icon(
                                                              Icons.card_travel,
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
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          counterWidget(index),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog<
                                                                      String>(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          "Delete?"),
                                                                      content: Text(
                                                                          "Are you sure to delete?"),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Cancel'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              Text('OK'),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              productDetailsDataList.removeAt(index);
                                                                              dataAllCartProductList.removeAt(index);
                                                                              itemData[index].counter= 1;
                                                                              init();
                                                                              Fluttertoast.showToast(msg: "Deleted Successfully");
                                                                            });
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            child: Icon(
                                                                // Icons.clear,
                                                                Icons
                                                                    .delete_forever,
                                                                color:
                                                                    Colors.red,
                                                                size: IconDimension
                                                                        .iconSize +
                                                                    10),
                                                          ),
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
                                                  fontWeight: FontWeight.bold)),
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
                                                  fontWeight: FontWeight.bold)),
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
                                            : Text(
                                                "${AddressDetails.flat}, ${AddressDetails.village}, ${AddressDetails.city}, ${AddressDetails.state}, ${AddressDetails.country}-${AddressDetails.pinCode}",
                                                style: TextStyle()),
                                        SizedBox(height: 4),
                                        AddressDetails.flat == ''
                                            ? SizedBox()
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
                                                            color: Colors.blue))
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
                      ),
                    )),
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
        print(
            "AA${dataAllCartProductList.length - productDetailsDataList.length}");
      }
    }
    if (mounted) {
      isDetailsLoading = false;
      init();
    } else {
      isDetailsLoading = false;
    }
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
                  // itemData[index].shouldVisible =
                  //     !itemData[index].shouldVisible;
                });
              },
              child: Center(
                  child: itemData[index].counter != 1
                      ? Icon(Icons.remove,
                          color: Constant.primaryColor, size: 28)
                      : Icon(Icons.remove, color: Colors.grey, size: 28))),
          SizedBox(width: 8),
          Text('${itemData[index].counter}',
              style: const TextStyle(color: Colors.black)),
          SizedBox(width: 8),
          InkWell(
              onTap: () {
                setState(() {
                  itemData[index].counter == 99
                      ? null
                      : itemData[index].counter++;
                  // itemData[index].shouldVisible =
                  //     !itemData[index].shouldVisible;
                  init();
                });
              },
              child: Center(
                  child: itemData[index].counter != 99
                      ? Icon(Icons.add, color: Constant.primaryColor, size: 28)
                      : Icon(Icons.add, color: Colors.grey, size: 28))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    productDetailsDataList.clear();
    dataAllCartProductList.clear();
    super.dispose();
  }
}
