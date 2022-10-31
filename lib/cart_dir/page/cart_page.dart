// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/cart_dir/model/remove_to_cart_req_res.dart';
import 'package:shop_n_go/cart_dir/model/store_list_cart_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  List<StoreListCartReqData> dataStoreCartList = [];
  Future fetchStoreListCartDetails() async {
    setState(() {
      isLoading = true;
      dataStoreCartList.clear();
    });
    Uri myUri =
    Uri.parse("${NetworkUtil.storeListCartUrl}${ProfileDetails.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StoreListCartReq storeListCartReq =
      StoreListCartReq.fromJson(jsonResponse);
      if (storeListCartReq.message == "No Any Product") {
        setState(() {
          isLoading = false;
          dataStoreCartList.clear();
        });
      } else {
        List<StoreListCartReqData> list = storeListCartReq.data!;
        dataStoreCartList.addAll(list);
      }
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
    fetchStoreListCartDetails();
    super.initState();
  }

  void _onRefresh() async {
    dataStoreCartList.clear();
    await Future.delayed(Duration(milliseconds: 1000));

    fetchStoreListCartDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // fetchStoreListCartDetails();
    return Scaffold(
        body: SafeArea(
          child: (isLoading)
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
                  )))
              : ((dataStoreCartList.isEmpty
              ? RefreshIndicator(
              onRefresh: () async {
                _onRefresh();
                setState(() {});
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 3),
                      Text("No Item In Cart",
                          style: TextStyle(fontSize: 20)),
                    ],
                  )))
              : RefreshIndicator(
            onRefresh: () async {
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
                    // itemCount: productDetailsDataList.length,
                    itemCount: dataStoreCartList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // var item = productDetailsDataList[index];
                      var item = dataStoreCartList[index];
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
                                    //item
                                    //     .vendorMasters,
                                      item.vendorName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Image(
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              Images.baseUrl +
                                                  item.vendorProfile!)),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.directions,
                                                    size: IconDimension
                                                        .iconSize),
                                                SizedBox(width: 8),
                                                Expanded(child: Text(
                                                  // "${((productDetailsDataList[index].price) * (itemData[index].counter)).toStringAsFixed(0)}")),
                                                  // "Price ${((item.price) * (itemData[index].counter)).toStringAsFixed(0)}")),
                                                    "${item.vendorId}")),
                                                Icon(Icons.card_travel,
                                                    size: IconDimension
                                                        .iconSize),
                                                SizedBox(width: 8),
                                                // itemData[index]
                                                //             .counter ==
                                                //         1
                                                //     ? Text(
                                                //         "${itemData[index].counter} Item")
                                                //     : Text(
                                                //         "${itemData[index].counter} Items"),
                                                Text(item.itemCount == 1
                                                    ? "${item.itemCount} Item"
                                                    : "${item.itemCount} Items")
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
                                                    child: Container()),
                                                // counterWidget(index),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     showDialog<
                                                //             String>(
                                                //         context:
                                                //             context,
                                                //         builder:
                                                //             (BuildContext
                                                //                 context) {
                                                //           return AlertDialog(
                                                //             title: Text(
                                                //                 "Delete?"),
                                                //             content: Text(
                                                //                 "Are you sure to delete?"),
                                                //             actions: <
                                                //                 Widget>[
                                                //               TextButton(
                                                //                 child:
                                                //                     const Text('Cancel'),
                                                //                 onPressed:
                                                //                     () {
                                                //                   Navigator.of(context).pop();
                                                //                 },
                                                //               ),
                                                //               TextButton(
                                                //                 child:
                                                //                     Text('OK'),
                                                //                 onPressed:
                                                //                     () {
                                                //                   setState(() {
                                                //                     productDetailsDataList.removeAt(index);
                                                //                     dataAllCartProductList.removeAt(index);
                                                //                     if (productDetailsDataList.isEmpty || dataAllCartProductList.isEmpty) {
                                                //                       setState(() {
                                                //                         isAllDelete = true;
                                                //                         isAllDelete == true;
                                                //                       });
                                                //                     } else {
                                                //                       setState(() {
                                                //                         isAllDelete = false;
                                                //                         isAllDelete == false;
                                                //                       });
                                                //                     }
                                                //                     itemData[index].counter = 1;
                                                //                     init();
                                                //                     Fluttertoast.showToast(msg: "Deleted Successfully");
                                                //                     // removeToCart(item.itemCode!);
                                                //                   });
                                                //                   Navigator.of(context).pop();
                                                //                 },
                                                //               ),
                                                //             ],
                                                //           );
                                                //         });
                                                //   },
                                                //   child: Icon(
                                                //       // Icons.clear,
                                                //       Icons
                                                //           .delete_forever,
                                                //       color:
                                                //           Colors.red,
                                                //       size: IconDimension
                                                //               .iconSize +
                                                //           10),
                                                // ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      // minimumSize: Size(50, 30),
                                                        primary: Constant
                                                            .primaryColor),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          AppRoutes
                                                              .CartDetailsPage,
                                                          arguments:
                                                          item)
                                                          .then((value) {
                                                        setState(() {
                                                          fetchStoreListCartDetails();
                                                          setState(() {});
                                                        });
                                                      });

                                                      // arguments: item.vendorId);
                                                    },
                                                    child: Text(
                                                        item.itemCount ==
                                                            1
                                                            ? "VIEW ITEM"
                                                            : "VIEW ITEMS"))
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Card(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Row(
                  //         mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Column(
                  //             crossAxisAlignment:
                  //                 CrossAxisAlignment.start,
                  //             children: [
                  //               productDetailsDataList.length == 1
                  //                   ? Text("Total Item Count:")
                  //                   : Text("Total Items Count:"),
                  //               SizedBox(height: 4),
                  //               productDetailsDataList.length == 1
                  //                   ? Text("Total Item Amount:")
                  //                   : Text("Total Items Amount:"),
                  //               SizedBox(height: 4),
                  //               Text("Delivery Cost:"),
                  //               SizedBox(height: 4),
                  //               Text("Total Bill Amount:",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold)),
                  //             ],
                  //           ),
                  //           Column(
                  //             crossAxisAlignment:
                  //                 CrossAxisAlignment.end,
                  //             children: [
                  //               productDetailsDataList.length == 1
                  //                   ? Text(
                  //                       "${sum.toStringAsFixed(0)} Item")
                  //                   : Text(
                  //                       "${sum.toStringAsFixed(0)} Items"),
                  //               SizedBox(height: 4),
                  //               Text(
                  //                   "${AppDetails.currencySign} ${ordersSum.toStringAsFixed(0)}"),
                  //               // Text("${AppDetails.currencySign}"),
                  //               SizedBox(height: 4),
                  //               Text(
                  //                   "${AppDetails.currencySign} ${deliveryCost.toStringAsFixed(0)}"),
                  //               // "${AppDetails.currencySign}"),
                  //               SizedBox(height: 4),
                  //               Text(
                  //                   "${AppDetails.currencySign} ${costTotal.toStringAsFixed(0)}",
                  //                   // Text("${AppDetails.currencySign} ",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold)),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     child: Card(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           crossAxisAlignment:
                  //               CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Delivery to HOME",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold)),
                  //             SizedBox(height: 4),
                  //             (AddressDetails.flat == '' ||
                  //                     AddressDetails.flat == null)
                  //                 ? GestureDetector(
                  //                     onTap: () {
                  //                       Navigator.pushNamed(context,
                  //                           AppRoutes.AddressPage);
                  //                     },
                  //                     child: Text("Enter Address",
                  //                         style: TextStyle(
                  //                             decoration:
                  //                                 TextDecoration
                  //                                     .underline,
                  //                             color: Colors.blue)))
                  //                 : Text(
                  //                     "${AddressDetails.flat}, ${AddressDetails.area}, ${AddressDetails.city}, ${AddressDetails.landMark}, ${AddressDetails.state}, ${AddressDetails.pinCode} - ${AddressDetails.country}              Mob: ${ProfileDetails.phone}",
                  //                     style: TextStyle()),
                  //             SizedBox(height: 4),
                  //             (AddressDetails.flat == '' ||
                  //                     AddressDetails.flat == null)
                  //                 ? SizedBox()
                  //                 : GestureDetector(
                  //                     onTap: () {
                  //                       Navigator.pushNamed(context,
                  //                           AppRoutes.AddressPage);
                  //                     },
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.end,
                  //                       children: [
                  //                         Text("Change Address",
                  //                             style: TextStyle(
                  //                                 decoration:
                  //                                     TextDecoration
                  //                                         .underline,
                  //                                 color: Colors.blue))
                  //                       ],
                  //                     ),
                  //                   ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           minimumSize: Size(
                  //               MediaQuery.of(context).size.width,
                  //               50),
                  //           primary: Constant.primaryColor),
                  //       onPressed: () {
                  //         (AddressDetails.flat == '' ||
                  //                 AddressDetails.flat == null)
                  //             ? Fluttertoast.showToast(
                  //                 msg:
                  //                     "Please Enter Delivery Address")
                  //             : Navigator.pushNamed(
                  //                 context, AppRoutes.OrderPage,
                  //                 arguments:
                  //                     costTotal.toStringAsFixed(0));
                  //       },
                  //       child: Text("PROCEED TO BUY")),
                  // ),
                ],
              ),
            ),
          ))),
        ));
  }

  Future removeToCart(itemCode) async {
    String consumerId = ProfileDetails.id!;
    print("consumerId: $consumerId==itemCode:$itemCode");

    Uri myUri = Uri.parse(
        "${NetworkUtil.postRemoveToCartUrl}${ProfileDetails.id}/$itemCode");
    // "${NetworkUtil.postRemoveToCartUrl}26/102");

    http.Response response = await http.delete(myUri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
      jsonDecode(response.body) as Map<String, dynamic>;
      RemoveToCartResReq removeToCartResReq = RemoveToCartResReq.fromJson(map);

      if (removeToCartResReq.success == true) {
        print('removeToCart: Success');
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
}
