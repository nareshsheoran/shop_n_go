// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';

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

  List imageList = [
    Images.laysImg,
    Images.milkImg,
    Images.softDrinksImg,
    Images.nutsImg,
    Images.iceCreamImg,
    Images.soapImg,
    Images.oilImg,
    Images.biscuitsImg,
  ];

  List nameList = [
    "Vegetables",
    "Fruits",
    "Soft Drinks",
    "Nuts",
    "Ice Cream",
    "Soaps",
    "Oils",
    "Biscuits",
  ];
  Object? name = '';

  @override
  Widget build(BuildContext context) {
    name = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          hintText: 'Search',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                (CategoryService().isLoadingAllCategory)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child:  Center(
                          child: CProgressIndicator.circularProgressIndicator,
                        ),
                      )
                    : GridView.builder(
                        itemCount: CategoryService().dataAllCategoryList.length,
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
                                        imageList[index],
                                        CategoryService().dataAllCategoryList[index].name!,
                                        "description",
                                        CategoryService().dataAllCategoryList[index].id.toString()));
                              },
                              child: categoryWidget(index));
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(int index) {
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
                    image: NetworkImage(imageList[index])),
              ),
              Text(
                CategoryService().dataAllCategoryList[index].name!,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
