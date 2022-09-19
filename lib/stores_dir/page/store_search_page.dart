// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/service/product_add_cart_service.dart';
import 'package:shop_n_go/stores_dir/model/store_list_details_req.dart';

import 'package:shop_n_go/stores_dir/page/stores_details.dart';

import '../model/store_list_req.dart';

class StoreSearchPage extends StatefulWidget {
  const StoreSearchPage({Key? key}) : super(key: key);

  @override
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  TextEditingController searchController = TextEditingController();
  StoreListData? storeListRequestData;

  bool isLoading = false;
  List<StoreListDetailsData> dataAllStoreDetailsList = [];
  List<StoreListDetailsData> _foundDetail = [];

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

  @override
  Widget build(BuildContext context) {
    if (storeListRequestData == null) {
      storeListRequestData =
          ModalRoute.of(context)?.settings.arguments as StoreListData;
      fetchStoreDetailsData();
    }

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
                    "${storeListRequestData?.vendorName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.directions),
                  SizedBox(width: 8),
                  Expanded(child: Text("${storeListRequestData?.distance}")),
                  Icon(Icons.card_travel),
                  SizedBox(width: 8),
                  Text("${storeListRequestData?.noOfProducts} Items"),
                  SizedBox(width: 16),
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
                  onChanged: (value) {
                    setState(() {
                      _runFilter(value);
                    });
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
            (isLoading)
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
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
                          itemCount: dataAllStoreDetailsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            StoreListDetailsData item =
                                dataAllStoreDetailsList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Card(
                                elevation: 5,
                                shadowColor: Constant.primaryColor,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                          height: ImageDimension.imageHeight,
                                          width: ImageDimension.imageWidth,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(Images.baseUrl +
                                              dataAllStoreDetailsList[index]
                                                  .itemImages!)),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(item.itemName!,
                                                style: TextStyle(fontSize: 18)),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "${AppDetails.currencySign}${item.price!.toStringAsFixed(0)}",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                Size(50, 30),
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
                                                            ? dataAllStoreDetailsList.removeAt(index)
                                                            : null;
                                                      });
                                                    },
                                                    child: Text("ADD +")),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
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
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Card(
                                elevation: 5,
                                shadowColor: Constant.primaryColor,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                          height: ImageDimension.imageHeight,
                                          width: ImageDimension.imageWidth,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(Images.baseUrl +
                                              _foundDetail[index].itemImages!)),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                                _foundDetail[index].itemName!,
                                                style: TextStyle(fontSize: 18)),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "${AppDetails.currencySign}${_foundDetail[index].price!.toStringAsFixed(0)}",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              // SizedBox(
                                              //     width: MediaQuery.of(context).size.width /
                                              //         4),
                                              // Expanded(child: Container()),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                Size(50, 30),
                                                            primary: Constant
                                                                .primaryColor),
                                                    onPressed: () {
                                                      // proAddedIntoCart(
                                                      //     index,
                                                      //     _foundDetail[index]
                                                      //         .itemCode);

                                                      ProductAddCartService()
                                                          .proAddedIntoCart(
                                                              index,
                                                              _foundDetail[
                                                                      index]
                                                                  .itemCode);
                                                      setState(() {
                                                        ProductAddCartService()
                                                            .statusCode ==
                                                            200
                                                            ? _foundDetail.removeAt(index)
                                                            : null;
                                                      });
                                                    },
                                                    child: Text("ADD +")),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
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

  void _runFilter(String searchKey) {
    List<StoreListDetailsData>? results = [];
    results.clear();
    if (searchKey.isEmpty ||
        (searchController.text.isEmpty && searchController.text.contains(""))) {
      results = _foundDetail;
    } else {
      results = dataAllStoreDetailsList
          .where((user) =>
              user.itemName!.toLowerCase().contains(searchKey.toLowerCase()))
          .cast<StoreListDetailsData>()
          .toList();
      setState(() {
        _foundDetail = results!;
      });
    }
    setState(() {
      _foundDetail = results!;
    });
  }

  @override
  void dispose() {
    _foundDetail.clear();
    dataAllStoreDetailsList.clear();
    super.dispose();
  }
}
