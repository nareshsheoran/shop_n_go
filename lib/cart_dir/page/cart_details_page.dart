// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_conditional_assignment, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/account_dir/model/cart_to_order_res.dart';
import 'package:shop_n_go/cart_dir/model/cart_item_by_store_req.dart';
import 'package:shop_n_go/cart_dir/model/remove_to_cart_req_res.dart';
import 'package:shop_n_go/cart_dir/model/store_list_cart_req.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/shared_preference_data/fetch_data_SP.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  double sum = 0;
  double ordersSum = 0;
  double costTotal = 0;
  double deliveryCost = 0;
  StoreListCartReqData? storeListCartReqData;

  double totalSum() {
    sum = 0;
    for (int i = 0; i < dataStoreCartList.length; i++) {
      setState(() {
        sum += dataStoreCartList[i].quantity!;
        sum;
      });
    }
    return sum;
  }

  double totalOrderSum() {
    ordersSum = 0;
    for (int i = 0; i < dataStoreCartList.length; i++) {
      setState(() {
        ordersSum += ((dataStoreCartList[i].offerPrice)! *
            (dataStoreCartList[i].quantity!));
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

  bool isAllDelete = false;
  bool isLoading = false;
  List<CartItemByStoreReqData> dataStoreCartList = [];

  Future fetchStoreListCartDetails() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.cartItemByStoreUrl}${ProfileDetails.id}/${storeId.toString()}");
    print(myUri);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      CartItemByStoreReq cartItemByStoreReq =
      CartItemByStoreReq.fromJson(jsonResponse);
      List<CartItemByStoreReqData> list = cartItemByStoreReq.data!;
      dataStoreCartList.addAll(list);
      init();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      isLoading = false;
    }
  }

  @override
  void initState() {
    // init();
    super.initState();
  }

  Object? storeId;
  Object? storeName;

  @override
  Widget build(BuildContext context) {
    if (storeListCartReqData == null) {
      storeListCartReqData =
      ModalRoute.of(context)?.settings.arguments as StoreListCartReqData?;
      if (storeListCartReqData != null) {
        storeId = storeListCartReqData?.vendorId!;
        storeName = storeListCartReqData?.vendorName!;
        print(storeId);
        print(storeName);
        fetchStoreListCartDetails();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: (isLoading)
              ? SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_rounded,
                                color: Colors.black)),
                        SizedBox(width: 8),
                        Text(
                          "Cart Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width / 1.5),
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CProgressIndicator.circularProgressIndicator,
                          SizedBox(height: 16),
                          Text("Please Wait..",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      )),
                ],
              ))
              : dataStoreCartList.isEmpty
              ? SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_rounded,
                                color: Colors.black)),
                        SizedBox(width: 8),
                        Text(
                          "Cart Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.width / 1.5),
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CProgressIndicator.circularProgressIndicator,
                          SizedBox(height: 16),
                          Text("Please Wait..",
                              style:
                              TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      )),
                ],
              ))
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_rounded,
                            color: Colors.black)),
                    SizedBox(width: 8),
                    Text(
                      "Cart Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(storeName.toString(),
                        style:
                        TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        sum.toStringAsFixed(0).toString() == "1"
                            ? Text("${sum.toStringAsFixed(0)} Item")
                            : Text("${sum.toStringAsFixed(0)} Items"),
                        SizedBox(
                            width: MediaQuery.of(context).size.width /
                                4),
                        Text(
                            "${AppDetails.currencySign} ${ordersSum.toStringAsFixed(0)}"),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: dataStoreCartList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = dataStoreCartList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    child: Card(
                      elevation: CardDimension.elevation,
                      shadowColor: CardDimension.shadowColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes
                                        .CategoriesDetailsPage,
                                    arguments: ScreenArguments(
                                        Images.baseUrl +
                                            item.itemImages!,
                                        item.itemName!,
                                        item.description!,
                                        item.itemCode!))
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                    height:
                                    ImageDimension.imageHeight -
                                        10,
                                    width: ImageDimension.imageWidth -
                                        10,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "${Images.baseUrl}${item.itemImages!}")),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(item.itemName!,
                                          style: TextStyle(
                                              fontSize: 18)),
                                      Expanded(child: Container()),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext
                                              context) {
                                                return AlertDialog(
                                                  title:
                                                  Text("Delete?"),
                                                  content: Text(
                                                      "Are you sure to delete?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text(
                                                          'Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(
                                                            context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                      Text('OK'),
                                                      onPressed: () {
                                                        setState(() {
                                                          dataStoreCartList
                                                              .removeAt(
                                                              index);
                                                          // if(dataStoreCartList.isEmpty){
                                                          //   Navigator.pop(context);
                                                          // }
                                                          removeToCart(
                                                              item.itemCode);

                                                          init();
                                                        });
                                                        Navigator.of(
                                                            context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(
                                          // Icons.clear,
                                            Icons.delete_forever,
                                            color: Colors.red,
                                            size: IconDimension
                                                .iconSize +
                                                10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                          "${AppDetails.currencySign}${(((item.offerPrice!) * (dataStoreCartList[index].quantity!)).toStringAsFixed(0))}",
                                          style: TextStyle(
                                              fontSize: 18)),
                                      counterWidget(index)
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
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
                            (dataStoreCartList.length == 1)
                                ? Text("Total Item Count")
                                : Text("Total Items Count"),
                            SizedBox(height: 4),
                            Text("Items Total"),
                            SizedBox(height: 4),
                            Text("Delivery Cost"),
                            SizedBox(height: 4),
                            Text("Total Bill Amount:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            (sum.toStringAsFixed(0).toString() == "1")
                                ? Text(
                                "${sum.toStringAsFixed(0)} Item")
                                : Text(
                                "${sum.toStringAsFixed(0)} Items"),
                            SizedBox(height: 4),
                            Text(
                                "${AppDetails.currencySign} ${ordersSum.toStringAsFixed(0)}"),
                            SizedBox(height: 4),
                            Text(
                                "${AppDetails.currencySign} ${deliveryCost.toStringAsFixed(0)}"),
                            SizedBox(height: 4),
                            Text(
                                "${AppDetails.currencySign} ${costTotal.toStringAsFixed(0)}",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Delivery to HOME",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          (AddressDetails.flat == '' ||
                              AddressDetails.flat == null)
                              ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    AppRoutes.AddressPage);
                              },
                              child: Text("Enter Address",
                                  style: TextStyle(
                                      decoration: TextDecoration
                                          .underline,
                                      color: Colors.blue)))
                              : Text(
                              "${AddressDetails.flat}, ${AddressDetails.area}, ${AddressDetails.city}, ${AddressDetails.landMark}, ${AddressDetails.state}, ${AddressDetails.pinCode} - ${AddressDetails.country}              Mob: ${ProfileDetails.phone}",
                              style: TextStyle()),
                          SizedBox(height: 4),
                          (AddressDetails.flat == '' ||
                              AddressDetails.flat == null)
                              ? SizedBox()
                              : GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  AppRoutes.AddressPage)
                                  .then((value) {
                                setState(() {
                                  fetchDataSP();
                                  setState(() {});
                                });
                              });
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
                            MediaQuery.of(context).size.width, 50),
                        primary: Constant.primaryColor),
                    onPressed: () {
                      (AddressDetails.flat == '' ||
                          AddressDetails.flat == null)
                          ? Fluttertoast.showToast(
                          msg: "Please Enter Delivery Address")
                          : cartToOrder();
                      // Navigator.pushNamed(
                      //         context, AppRoutes.OrderPage,
                      //         arguments:
                      //             costTotal.toStringAsFixed(0));
                    },
                    child: Text("PROCEED TO BUY")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget counterWidget(int index) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 35,
      width: 84,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white70)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
              onTap: () {
                setState(() {
                  dataStoreCartList[index].quantity == 1
                      ? null
                      : (dataStoreCartList[index].quantity =
                      dataStoreCartList[index].quantity! - 1);
                  init();
                });
              },
              child: Center(
                  child: Icon(
                    Icons.remove,
                    color: Constant.primaryColor,
                    size: 24,
                  ))),
          SizedBox(width: 4),
          Text(
            '${dataStoreCartList[index].quantity}',
            style: const TextStyle(color: Colors.black),
          ),
          SizedBox(width: 4),
          InkWell(
              onTap: () {
                setState(() {
                  dataStoreCartList[index].quantity == 99
                      ? null
                      : (dataStoreCartList[index].quantity =
                      dataStoreCartList[index].quantity! + 1);
                  init();
                  print(dataStoreCartList[index].quantity!);
                });
              },
              child: Center(
                  child: Icon(
                    Icons.add,
                    color: Constant.primaryColor,
                    size: 24,
                  ))),
        ],
      ),
    );
  }

  Future removeToCart(itemCode) async {
    isLoading = false;

    String consumerId = ProfileDetails.id!;
    print("consumerId: $consumerId==itemCode:$itemCode");

    Uri myUri = Uri.parse(
        "${NetworkUtil.postRemoveToCartUrl}${ProfileDetails.id}/$itemCode");

    http.Response response = await http.delete(myUri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
      jsonDecode(response.body) as Map<String, dynamic>;
      RemoveToCartResReq removeToCartResReq = RemoveToCartResReq.fromJson(map);

      if (removeToCartResReq.success == true) {
        print('removeToCart: Success');

        if (dataStoreCartList.isEmpty) {
          setState(() {
            Navigator.pop(context);
          });
          // Navigator.canPop(context);
          // Navigator.of(context).pop();
        } else {
          setState(() {
            init();
          });
        }
        Fluttertoast.showToast(msg: "Product Deleted Successfully");
      } else {
        Fluttertoast.showToast(
            msg: "Request failed with Error: ${response.statusCode}",
            timeInSecForIosWeb: 2);
        print(
            'removeToCart: Request failed with status: ${response.statusCode}');
      }
    }
  }

  Future cartToOrder() async {
    String id = ProfileDetails.id!;
    var requestBody = {
      'consumer_id': id,
    };

    Uri myUri = Uri.parse(NetworkUtil.cartToOrderUrl);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
      jsonDecode(response.body) as Map<String, dynamic>;
      CartToOrderRes cartToOrderRes = CartToOrderRes.fromJson(map);

      if (cartToOrderRes.success == true) {
        print(cartToOrderRes.data);

        Navigator.pushNamed(context, AppRoutes.OrderPage,
            arguments: costTotal.toStringAsFixed(0));
        Fluttertoast.showToast(
            msg: "Order Successfully", timeInSecForIosWeb: 2);
      } else {
        print(
            'removeToCart: Request failed with status: ${response.statusCode}');
      }
    }
  }
}
