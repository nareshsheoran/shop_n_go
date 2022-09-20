// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';
import 'package:shop_n_go/shared/service/product_add_cart_service.dart';
import 'package:shop_n_go/stores_dir/model/store_list_details_req.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../cart_dir/page/cart_page.dart';
import '../model/store_list_req.dart';

class StoresDetailsPage extends StatefulWidget {
  const StoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<StoresDetailsPage> createState() => _StoresDetailsPageState();
}

class _StoresDetailsPageState extends State<StoresDetailsPage> {
  // Object? image = '';
  StoreListData? storeListRequestData;

  // StoreListRequest? storeListRequestData;

  late int selectedIndex;
  final List<bool> _selected = List.generate(50, (i) => false);

  bool isLoading = false;
  List<StoreListDetailsData> dataAllStoreDetailsList = [];

  Future<void> fetchStoreDetailsData() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(
        "${NetworkUtil.getVendorProductUrl}${storeListRequestData!.authPerson?.toLowerCase()}v");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StoreListDetailsReq storeListDetailsReq =
          StoreListDetailsReq.fromJson(jsonResponse);
      List<StoreListDetailsData>? list = storeListDetailsReq.data;
      dataAllStoreDetailsList.addAll(list!);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // fetchStoreDetailsData();
    super.initState();
  }

  List nameList = [
    "Chilly",
    "Ladies Finger",
    "Onion",
    "Potato",
    "Radius",
    "Tomato",
  ];

  List rateList = [
    "49",
    "65",
    "49",
    "65",
    "49",
    "65",
  ];

  List weightList = [
    "9",
    "6",
    "4",
    "3",
    "1",
    "5",
  ];

  @override
  Widget build(BuildContext context) {
    if (storeListRequestData == null) {
      storeListRequestData =
          ModalRoute.of(context)?.settings.arguments as StoreListData;
      fetchStoreDetailsData();
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Image(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      // image.toString(),
                      Images.baseUrl + storeListRequestData!.vendorProfile!,
                    )),
                Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${storeListRequestData!.vendorName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.directions),
                            SizedBox(width: 8),
                            Expanded(
                                child:
                                    Text("${storeListRequestData!.distance}")),
                            Icon(Icons.card_travel),
                            SizedBox(width: 8),
                            (storeListRequestData!.noOfProducts == 0)
                                ? Text(
                                    "${storeListRequestData!.noOfProducts} Item")
                                : Text(
                                    "${storeListRequestData!.noOfProducts} Items")
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.directions_bike_sharp),
                            SizedBox(width: 8),
                            Text("${storeListRequestData!.isHomeDelivery}")
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.currency_rupee_rounded),
                            SizedBox(width: 8),
                            Text(
                                "Minimum Order ${AppDetails.currencySign}${storeListRequestData!.minimumOrder}")
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star),
                            SizedBox(width: 8),
                            Text("Review")
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Products Available",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.StoreSearchPage,
                                      arguments: storeListRequestData);
                                },
                                child: Text("View All",
                                    style: TextStyle(
                                        color: Constant.primaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                (isLoading)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CProgressIndicator.circularProgressIndicator,
                        ),
                      )
                    : SizedBox(
                        height: 157,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: dataAllStoreDetailsList.length >= 4
                              ? dataAllStoreDetailsList.length.toInt().bitLength
                              : dataAllStoreDetailsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  height: 157,
                                  width: 150,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 9),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: (isLoading)
                                              ? SizedBox(
                                                  height: ImageDimension
                                                          .imageWidth -
                                                      16,
                                                  width: ImageDimension
                                                          .imageWidth -
                                                      16,
                                                  child: Center(
                                                    child: CProgressIndicator
                                                        .circularProgressIndicator,
                                                  ),
                                                )
                                              : GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppRoutes
                                                      .CategoriesDetailsPage,
                                                  arguments: ScreenArguments(
                                                      Images
                                                          .baseUrl +
                                                          dataAllStoreDetailsList[
                                                          index]
                                                              .itemImages!,
                                                      dataAllStoreDetailsList[
                                                      index]
                                                          .itemName!,
                                                      dataAllStoreDetailsList[
                                                      index]
                                                          .description!,
                                                      dataAllStoreDetailsList[
                                                      index]
                                                          .itemCode!));
                                            },
                                                child: Image(
                                                    width: ImageDimension
                                                            .imageWidth -
                                                        16,
                                                    height: ImageDimension
                                                            .imageHeight -
                                                        25,
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(Images
                                                            .baseUrl +
                                                        dataAllStoreDetailsList[
                                                                index]
                                                            .itemImages!),
                                                  ),
                                              ),
                                        ),
                                        // SizedBox(height: 4),
                                        Text(
                                            // "${dataAllStoreDetailsList[index].itemName} ${itemData[index].weight}kg"),
                                            "${dataAllStoreDetailsList[index].itemName}"),
                                        // SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 0, 4, 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "${AppDetails.currencySign}${(((dataAllStoreDetailsList[index].price)!) * (itemData[index].counter)).toStringAsFixed(0)}"),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          minimumSize:
                                                              Size(20, 30),
                                                          primary: Constant
                                                              .primaryColor),
                                                  onPressed: () {
                                                    ProductAddCartService()
                                                        .proAddedIntoCart(
                                                            index,
                                                            dataAllStoreDetailsList[
                                                                    index]
                                                                .itemCode);
                                                    setState(() {
                                                      ProductAddCartService()
                                                                  .statusCode ==
                                                              200
                                                          ? dataAllStoreDetailsList
                                                              .removeAt(index)
                                                          : null;
                                                    });
                                                  },
                                                  child: Text(
                                                    "ADD +",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ))

                                              // counterWidget(index)
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
                                            dataAllStoreDetailsList[index]
                                                .itemCode)
                                            : Fluttertoast.showToast(
                                            msg: "Favourite Removed");
                                      },
                                    ))
                              ],
                            );
                          },
                        ),
                      ),
              ],
            ),
            Positioned(
                left: 12,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace_outlined,
                    size: 32,
                    color: Colors.black,
                  ),
                )),
            Positioned(
                right: 12,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.CartPage);
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 32,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget counterWidget(int index) {
    return
        // itemData[index].shouldVisible ?
        //    Center(
        //       child: Container(
        //       height: 30,
        //       width: 70,
        //       decoration: BoxDecoration(
        //           color: Colors.grey[200],
        //           borderRadius: BorderRadius.circular(4),
        //           border: Border.all(color: Colors.white70)),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   if (itemData[index].counter < 1) {
        //                     itemData[index].shouldVisible =
        //                         !itemData[index].shouldVisible;
        //                   } else {
        //                     itemData[index].counter--;
        //                   }
        //                 });
        //               },
        //               child: Icon(
        //                 Icons.remove,
        //                 color: Constant.primaryColor,
        //                 size: 22,
        //               )),
        //           SizedBox(width: 4),
        //           (itemData[index].counter == 0 ||
        //                   itemData[index].counter == null)
        //               ? Text(
        //                   '${itemData[index].counter}',
        //                   style: TextStyle(color: Colors.black),
        //                 )
        //               : Text(
        //                   '${itemData[index].counter}',
        //                   style: const TextStyle(color: Colors.black),
        //                 ),
        //           SizedBox(width: 4),
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   itemData[index].counter++;
        //                 });
        //               },
        //               child: Icon(
        //                 Icons.add,
        //                 color: Constant.primaryColor,
        //                 size: 22,
        //               )),
        //         ],
        //       ),
        //     )):
        Container(
      padding: EdgeInsets.all(5),
      height: 30,
      width: 80,
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
                  // itemData[index].counter--;
                  if (itemData[index].counter < 1) {
                    itemData[index].shouldVisible =
                        !itemData[index].shouldVisible;
                    if (itemData[index].counter == 0) {
                      setState(() {
                        itemData.removeAt(index);
                      });
                    }
                  } else {
                    itemData[index].counter--;
                    if (itemData[index].counter == 0) {
                      setState(() {
                        itemData.removeAt(index);
                      });
                    }
                  }
                });
              },
              child: Center(
                  child: Icon(
                Icons.remove,
                color: Constant.primaryColor,
                size: 22,
              ))),
          SizedBox(width: 2),
          Text(
            '${itemData[index].counter}',
            style: const TextStyle(color: Colors.black),
          ),
          SizedBox(width: 2),
          InkWell(
              onTap: () {
                setState(() {
                  itemData[index].counter++;
                  itemData[index].shouldVisible =
                      !itemData[index].shouldVisible;
                });
              },
              child: Center(
                  child: Icon(
                Icons.add,
                color: Constant.primaryColor,
                size: 22,
              ))),
        ],
      ),
    );
  }
}


