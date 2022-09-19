// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart';
import '../model/store_list_req.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({Key? key}) : super(key: key);

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  List<StoreListData> dataAllStoreList = [];

  Future<void> fetchStoreDetails() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(NetworkUtil.getStoreListUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StoreListRequest storeListRequest =
          StoreListRequest.fromJson(jsonResponse);
      List<StoreListData> list = storeListRequest.data!;
      dataAllStoreList.addAll(list);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchStoreDetails();
    super.initState();
  }

  List itemList = ["55", "66", "80", "31", "66", "80", "31", "18"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "STORES",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Constant.primaryColor),
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
                  onChanged: (value) {
                    _runFilter(value);
                  },
                ),
              ),
            ),
            (isLoading)
                ? SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CProgressIndicator.circularProgressIndicator,
                    ),
                  )
                : (_foundDetail.isEmpty ||
                        (searchController.text.isEmpty &&
                            searchController.text.contains("")))
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: dataAllStoreList.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.StoresDetailsPage,
                                    arguments: dataAllStoreList[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Card(
                                  elevation: CardDimension.elevation,
                                  shadowColor: CardDimension.shadowColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "${dataAllStoreList[index].vendorName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Icon(
                                              Icons.alarm,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "${dataAllStoreList[index].openTime!.substring(0, 5)}-${dataAllStoreList[index].closeTime!.substring(0, 5)}",
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Image(
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  Images.baseUrl +
                                                      dataAllStoreList[index]
                                                          .vendorProfile!),
                                            ),
                                            SizedBox(width: 14),
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
                                                      Icon(
                                                        Icons.directions,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: Text(
                                                              "${dataAllStoreList[index].distance}")),
                                                      Icon(
                                                        Icons.card_travel,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                          "${dataAllStoreList[index].noOfProducts} Items"),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.shopping_cart,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: Text(
                                                              "Min. order ${AppDetails.currencySign}${dataAllStoreList[index].minimumOrder}")),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .directions_bike_sharp,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                          "${dataAllStoreList[index].isHomeDelivery}")
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
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _foundDetail.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.StoresDetailsPage,
                                    arguments: _foundDetail[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Card(
                                  elevation: CardDimension.elevation,
                                  shadowColor: CardDimension.shadowColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "${_foundDetail[index].vendorName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Icon(
                                              Icons.alarm,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "${_foundDetail[index].openTime!.substring(0, 5)}-${_foundDetail[index].closeTime!.substring(0, 5)}",
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Image(
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  Images.baseUrl +
                                                      _foundDetail[index]
                                                          .vendorProfile!),
                                            ),
                                            SizedBox(width: 14),
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
                                                      Icon(
                                                        Icons.directions,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: Text(
                                                              "${_foundDetail[index].distance}")),
                                                      Icon(
                                                        Icons.card_travel,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                          "${_foundDetail[index].noOfProducts} Items"),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.shopping_cart,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: Text(
                                                              "Min. order ${AppDetails.currencySign}${_foundDetail[index].minimumOrder}")),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .directions_bike_sharp,
                                                        size: IconDimension
                                                            .iconSize,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                          "${_foundDetail[index].isHomeDelivery}")
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
                      ),
          ],
        ),
      ),
    );
  }

  List<StoreListData> _foundDetail = [];

  void _runFilter(String searchKey) {
    List<StoreListData>? results = [];
    results.clear();
    if (searchKey.isEmpty ||
        (searchController.text.isEmpty && searchController.text.contains(""))) {
      results = _foundDetail;
    } else {
      results = dataAllStoreList
          .where((user) =>
              user.vendorName!.toLowerCase().contains(searchKey.toLowerCase()))
          .cast<StoreListData>()
          .toList();
      setState(() {
        _foundDetail = results!;
      });
    }
    setState(() {
      _foundDetail = results!;
    });
  }
}
