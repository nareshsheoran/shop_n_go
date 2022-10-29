// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/cart_dir/service/cart_product_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/product_add_cart_service.dart';
import 'package:shop_n_go/shared/service/product_add_to_N_cart_service.dart';
import 'package:shop_n_go/stores_dir/model/store_list_details_req.dart';
import 'package:shop_n_go/stores_dir/model/store_list_req.dart';

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
bool isProduct=false;
  Future<void> fetchStoreDetailsData() async {
    setState(() {
      isLoading = true;
      isProduct = true;
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 14, 8, 8),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_backspace_outlined,
                          color: Colors.black)),
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
                  (dataAllStoreDetailsList.isNotEmpty || isLoading == false)
                      ? Icon(Icons.card_travel)
                      : Text(""),
                  SizedBox(width: 8),
                  // Text("${storeListRequestData?.noOfProducts} Items"),
                  (dataAllStoreDetailsList.isEmpty || isLoading)
                      ? Text("")
                      : dataAllStoreDetailsList.length <= 1
                          ? Text("${dataAllStoreDetailsList.length} Item")
                          : Text("${dataAllStoreDetailsList.length} Items"),
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
                  // cursorColor: Constant.primaryColor,
                  textCapitalization: TextCapitalization.sentences,
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
                ),
              ),
            ),
            if (isLoading)
              SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CProgressIndicator.circularProgressIndicator,
                  ))
              else if(isProduct==false)
              SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text("No More Product",
                      style: TextStyle(fontSize: 18)),
                  ))
            else if (searchController.text.isEmpty && _foundDetail.isEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: dataAllStoreDetailsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // StoreListDetailsData item = dataAllStoreDetailsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: buildCard(context, index, dataAllStoreDetailsList),
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: buildCard(context, index, _foundDetail)
                    );
                  },
                ),
              )
            else if (isLoading == false && _foundDetail.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("No matched Item found."),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Card buildCard(BuildContext context, int index, List list) {
    return Card(
      elevation: 5,
      shadowColor: Constant.primaryColor,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.CategoriesDetailsPage,
                  arguments: ScreenArguments(
                      Images.baseUrl + list[index].itemImages!,
                      list[index].itemName!,
                      list[index].description!,
                      list[index].itemCode!));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                  height: ImageDimension.imageHeight,
                  width: ImageDimension.imageWidth,
                  fit: BoxFit.fill,
                  image:
                      NetworkImage(Images.baseUrl + list[index].itemImages!)),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(list[index].itemName!,
                      style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${AppDetails.currencySign}${list[index].price!.toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(50, 30),
                              primary: Constant.primaryColor),
                          onPressed: () {
                            ProductAddCartService.getInstance()
                                .proAddedIntoCart(index, list[index].itemCode);
                            ProductAddToNCartService
                                .getInstance()
                                .proAddedIntoCart(
                                list[index].itemCode,
                                list[index].vendorId);
                            setState(() {
                              (ProductAddCartService.getInstance().statusCode == 200 || ProductAddToNCartService.getInstance().statusCode==200)
                                  ? list.removeAt(index)
                                  : null;
                              if (dataAllStoreDetailsList
                                  .isEmpty) {
                                setState(() {
                                  isProduct =
                                  false;
                                });
                              }
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
    );
  }

  void _runFilter(String searchKey) {
    if (searchController.text.contains(" ")) {
      setState(() {
        searchController.clear();
        _foundDetail.clear();
      });
    } else {
      List<StoreListDetailsData> results = [];
      results.clear();
      if (searchKey.isEmpty ||
          (searchController.text.isEmpty &&
              searchController.text.contains(""))) {
        results = _foundDetail;
      } else {
        setState(() {
          isLoading = true;
        });
        results = dataAllStoreDetailsList
            .where((user) =>
                user.itemName!.toLowerCase().contains(searchKey.toLowerCase()))
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

  @override
  void dispose() {
    _foundDetail.clear();
    // dataAllStoreDetailsList.clear();
    super.dispose();
  }
}
