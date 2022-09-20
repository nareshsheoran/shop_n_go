// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_product_req.dart';
import 'package:shop_n_go/home_page_dir/service/new_product_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';
import '../model_req/all_product_req.dart';
import 'package:http/http.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
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
                    "All Product",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
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
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: NewProductService().dataAllProdList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.CategoriesDetailsPage,
                              arguments: ScreenArguments(
                                  Images.baseUrl +
                                      NewProductService()
                                          .dataAllProdList[index]
                                          .itemImages!,
                                  NewProductService()
                                      .dataAllProdList[index]
                                      .itemName!,
                                  "description",
                                  NewProductService()
                                      .dataAllProdList[index]
                                      .itemCode!));
                        },
                        child: containerWidget(
                            index, NewProductService().dataAllProdList),
                      );
                    },
                  ),
                ),
              )
            else if (_foundDetail.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: _foundDetail.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.CategoriesDetailsPage,
                              arguments: ScreenArguments(
                                  Images.baseUrl +
                                      _foundDetail[index].itemImages!,
                                  _foundDetail[index].itemName!,
                                  "description",
                                  _foundDetail[index].itemCode!));
                        },
                        child: containerWidget(index, _foundDetail),
                      );
                    },
                  ),
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

  Container containerWidget(int index, List list) {
    return Container(
      width: 110,
      height: 140,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image(
                        width: ImageDimension.imageWidth - 16,
                        height: ImageDimension.imageHeight - 4,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            Images.baseUrl + list[index].itemImages!)),
                  ),
                  Expanded(
                    child: Text(
                      list[index].itemName!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${AppDetails.currencySign}${list[index].offerPrice?.toStringAsFixed(0)}",
                          textAlign: TextAlign.left,
                          // style: TextStyle(fontSize: 12),
                        ),
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
                          .addProdIntoFav(list[index].itemCode)
                      : Fluttertoast.showToast(msg: "Favourite Removed");
                },
              ))
        ],
      ),
    );
  }

  List<AllProductData> _foundDetail = [];
  bool isLoading = false;

  Future<dynamic> _runFilter(String searchKey) async {
    if (searchController.text.characters.first.contains(" ")) {
      setState(() {
        searchController.clear();
        _foundDetail.clear();
      });
    } else {
      List<AllProductData> results = [];
      results.clear();
      if (searchKey.isEmpty ||
          (searchController.text.isEmpty &&
              searchController.text.contains(""))) {
        results = _foundDetail;
      } else {
        setState(() {
          isLoading = true;
        });
        results = NewProductService()
            .dataAllProdList
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
