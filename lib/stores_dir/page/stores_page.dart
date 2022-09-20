// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/stores_dir/service/store_list_service.dart';
import '../model/store_list_req.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({Key? key}) : super(key: key);

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  TextEditingController searchController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.search, color: Constant.primaryColor),
                      suffixIcon: IconButton(
                        color: Constant.primaryColor,
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            _foundDetail.clear();
                            searchController.text.isEmpty;
                            _foundDetail.isEmpty;
                          });
                        },
                        icon: Icon(Icons.clear),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      hintText: 'Search',
                      border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {
                      if (value.contains(" ")) {
                        searchController.clear();
                        _foundDetail.clear();
                        // _runFilter(value);
                      } else if (searchController.text == "") {
                        searchController.clear();
                        _foundDetail.clear();
                      } else {
                        _runFilter(value);
                      }
                    });
                  },
                ),
              ),
            ),
            if (isLoading)
              SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CProgressIndicator.circularProgressIndicator,
                ),
              )
            else if (searchController.text.isEmpty && _foundDetail.isEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: StoreListService().dataAllStoreList.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.StoresDetailsPage,
                            arguments:
                                StoreListService().dataAllStoreList[index]);
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "${StoreListService().dataAllStoreList[index].vendorName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Icon(
                                      Icons.alarm,
                                      size: IconDimension.iconSize,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "${StoreListService().dataAllStoreList[index].openTime!.substring(0, 5)}-${StoreListService().dataAllStoreList[index].closeTime!.substring(0, 5)}",
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
                                      image: NetworkImage(Images.baseUrl +
                                          StoreListService()
                                              .dataAllStoreList[index]
                                              .vendorProfile!),
                                    ),
                                    SizedBox(width: 14),
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
                                                size: IconDimension.iconSize,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      "${StoreListService().dataAllStoreList[index].distance}")),
                                              Icon(
                                                Icons.card_travel,
                                                size: IconDimension.iconSize,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                  "${StoreListService().dataAllStoreList[index].noOfProducts} Items"),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                size: IconDimension.iconSize,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      "Min. order ${AppDetails.currencySign}${StoreListService().dataAllStoreList[index].minimumOrder}")),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.directions_bike_sharp,
                                                size: IconDimension.iconSize,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                  "${StoreListService().dataAllStoreList[index].isHomeDelivery}")
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
            else if (_foundDetail.isNotEmpty)
              Expanded(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      image: NetworkImage(Images.baseUrl +
                                          _foundDetail[index].vendorProfile!),
                                    ),
                                    SizedBox(width: 14),
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
                                                size: IconDimension.iconSize,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                  child: Text(
                                                      "${_foundDetail[index].distance}")),
                                              Icon(
                                                Icons.card_travel,
                                                size: IconDimension.iconSize,
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
                                                size: IconDimension.iconSize,
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
                                                Icons.directions_bike_sharp,
                                                size: IconDimension.iconSize,
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
              )
            else if (isLoading == false && _foundDetail.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("No matched store found."),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List _foundDetail = [];

  Future<dynamic> _runFilter(String searchKey) async {
    if (searchController.text.characters.first.contains(" ")) {
      setState(() {
        searchController.clear();
        _foundDetail.clear();
      });
    } else {
      List results = [];
      results.clear();
      if (searchKey.isEmpty ||
          (searchController.text.isEmpty &&
              searchController.text.contains(""))) {
        results = _foundDetail;
      } else {
        setState(() {
          isLoading = true;
        });
        results = StoreListService()
            .dataAllStoreList
            .where((user) => user.vendorName!
                .toLowerCase()
                .contains(searchKey.toLowerCase()))
            .toList();
        setState(() {
          _foundDetail = results;
        });
      }
      setState(() {
        _foundDetail = results;
        isLoading = false;
      });
    }
  }

// List<StoreListData> _foundDetail = [];
// bool isFetching = false;
//
// void _runFilter(String searchKey) {
//   setState(() {
//     isFetching = true;
//   });
//   List<StoreListData>? results = [];
//   results.clear();
//   if (searchKey.isEmpty ||
//       (searchController.text.isEmpty && searchController.text.contains(""))) {
//     results = _foundDetail;
//   } else {
//     results = dataAllStoreList
//         .where((user) =>
//             user.vendorName!.toLowerCase().contains(searchKey.toLowerCase()))
//         .cast<StoreListData>()
//         .toList();
//     setState(() {
//       _foundDetail = results!;
//     });
//   }
//   setState(() {
//     _foundDetail = results!;
//     isFetching = false;
//   });
// }
}
