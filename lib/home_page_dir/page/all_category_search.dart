// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_n_go/home_page_dir/service/category_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';

import '../model_req/all_category_req.dart';

class AllCategorySearch extends StatefulWidget {
  const AllCategorySearch({Key? key}) : super(key: key);

  @override
  State<AllCategorySearch> createState() => _AllCategorySearchState();
}

class _AllCategorySearchState extends State<AllCategorySearch> {
  TextEditingController searchController = TextEditingController();

  Object? name = '';

  @override
  Widget build(BuildContext context) {
    name = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: SafeArea(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              if (isSearchLoading)
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
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: CategoryService.getInstance()
                          .dataAllCategoryList
                          .length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item =
                            CategoryService.getInstance().dataAllCategoryList;
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.CategoryNamePage,
                                  arguments: ScreenArguments(
                                      Images.baseUrl + item[index].images!,
                                      item[index].name!,
                                      "description",
                                      item[index].id.toString()));
                            },
                            child: categoryWidget(index, item));
                      },
                    ),
                  ),
                )
              else if (_foundDetail.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: _foundDetail.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.CategoryNamePage,
                                  arguments: ScreenArguments(
                                      Images.baseUrl +
                                          _foundDetail[index].images!,
                                      _foundDetail[index].name!,
                                      "description",
                                      _foundDetail[index].id.toString()));
                            },
                            child: categoryWidget(index, _foundDetail));
                      },
                    ),
                  ),
                )
              else if (isSearchLoading == false && _foundDetail.isEmpty)
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
    );
  }

  Widget categoryWidget(int index, List list) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Card(
        elevation: CardDimension.elevation,
        shadowColor: CardDimension.shadowColor,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image(
                    width: ImageDimension.imageWidth,
                    height: ImageDimension.imageHeight,
                    fit: BoxFit.fill,
                    image: NetworkImage(Images.baseUrl + list[index].images!)),
              ),
              Text(
                list[index].name!,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<AllCategoryData> _foundDetail = [];
  bool isSearchLoading = false;

  Future<dynamic> _runFilter(String searchKey) async {
    if (searchController.text.characters.first.contains(" ")) {
      setState(() {
        searchController.clear();
        _foundDetail.clear();
      });
    } else {
      List<AllCategoryData> results = [];
      results.clear();
      _foundDetail.clear();
      if (searchKey.isEmpty ||
          (searchController.text.isEmpty &&
              searchController.text.contains(""))) {
        results = _foundDetail;
        results.clear();
      } else {
        setState(() {
          isSearchLoading = true;
        });
        results = CategoryService.getInstance()
            .dataAllCategoryList
            .where((user) =>
                user.name!.toLowerCase().contains(searchKey.toLowerCase()))
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
    // dataAllStoreDetailsList.clear();
    super.dispose();
  }
}
