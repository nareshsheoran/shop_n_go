// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_go/home_page_dir/model_req/category_based_prod_req.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';

import '../../shared/auth/constant.dart';

class CategoryNamePage extends StatefulWidget {
  const CategoryNamePage({Key? key}) : super(key: key);

  @override
  State<CategoryNamePage> createState() => _CategoryNamePageState();
}

class _CategoryNamePageState extends State<CategoryNamePage> {
  TextEditingController searchController = TextEditingController();

  bool isFavourite = false;
  late int selectedIndex;
  Object? id = '';
  Object? name = '';

  List<CategoryBasedProductData> dataCategoryBasedProductList = [];

  bool isLoading = false;

  Future fetchCategoryBasedProductDetails() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri =
        Uri.parse("${NetworkUtil.getCategoryBasedProductUrl}${id.toString()}");
    Response response = await get(myUri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      CategoryBasedProductReq categoryBasedProductReq =
          CategoryBasedProductReq.fromJson(jsonResponse);
      List<CategoryBasedProductData> list = categoryBasedProductReq.data!;
      dataCategoryBasedProductList.addAll(list);

      dataCategoryBasedProductList = list;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (id == "") {
      ScreenArguments arguments =
          ModalRoute.of(context)?.settings.arguments as ScreenArguments;
      id = arguments.code;
      name = arguments.name;
      fetchCategoryBasedProductDetails();
    }
    return Scaffold(
      // appBar: AppBar(title: Text(""),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                          child: Icon(Icons.arrow_back_rounded,
                              color: Colors.black)),
                      SizedBox(width: 8),
                      Text(
                        name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                  GridView.builder(
                    itemCount: dataCategoryBasedProductList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.73,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.CategoriesDetailsPage,
                                arguments: ScreenArguments(
                                    Images.baseUrl +
                                        dataCategoryBasedProductList[index]
                                            .itemImages!,
                                    dataCategoryBasedProductList[index]
                                        .itemName!,
                                    dataCategoryBasedProductList[index]
                                        .description!,
                                    dataCategoryBasedProductList[index]
                                        .itemCode!));
                          },
                          child: categoryWidget(
                              index, dataCategoryBasedProductList));
                    },
                  )
                else if (_foundDetail.isNotEmpty)
                  GridView.builder(
                    itemCount: _foundDetail.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.73,
                    ),
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
                                    _foundDetail[index].description!,
                                    _foundDetail[index].itemCode!));
                          },
                          child: categoryWidget(index, _foundDetail));
                    },
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
        ),
      ),
    );
  }

  Widget categoryWidget(int index, List list) {
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image(
                        width: ImageDimension.imageWidth - 16,
                        height: ImageDimension.imageHeight,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            Images.baseUrl + list[index].itemImages!)),
                  ),
                  Expanded(
                    child: Text(
                      list[index].itemName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${AppDetails.currencySign}${list[index].price?.toStringAsFixed(0)}",
                          textAlign: TextAlign.left,
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

  List<CategoryBasedProductData> _foundDetail = [];
  bool isSearchLoading = false;

  Future<dynamic> _runFilter(String searchKey) async {
    if (searchController.text.characters.first.contains(" ")) {
      setState(() {
        searchController.clear();
        _foundDetail.clear();
      });
    } else {
      List<CategoryBasedProductData> results = [];
      results.clear();
      if (searchKey.isEmpty ||
          (searchController.text.isEmpty &&
              searchController.text.contains(""))) {
        results = _foundDetail;
      } else {
        setState(() {
          isSearchLoading = true;
        });
        results = dataCategoryBasedProductList
            .where((user) =>
                user.itemName!.toLowerCase().contains(searchKey.toLowerCase()))
            .toList();
        setState(() {
          _foundDetail = results;
        });
      }
      setState(() {
        _foundDetail = results;
        isSearchLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _foundDetail.clear();
    dataCategoryBasedProductList.clear();
    super.dispose();
  }
}
