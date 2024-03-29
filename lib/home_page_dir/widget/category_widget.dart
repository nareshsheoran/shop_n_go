// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/service/category_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return (CategoryService.getInstance().isLoadingAllCategory)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Center(
              child: CProgressIndicator.circularProgressIndicator,
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ListView.builder(
                  itemCount: CategoryService.getInstance().dataAllCategoryList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 110,
                      height: 160,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, AppRoutes.CategoriesDetailsPage,arguments:dataAllCategoryList[index].name );
                          Navigator.pushNamed(
                              context, AppRoutes.CategoryNamePage,
                              arguments: ScreenArguments(
                                  Images.baseUrl + imageList[index],
                                  CategoryService.getInstance()
                                      .dataAllCategoryList[index]
                                      .name!,
                                  "Description",
                                  CategoryService.getInstance()
                                      .dataAllCategoryList[index]
                                      .id
                                      .toString()));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Image(
                                      width: ImageDimension.imageWidth,
                                      height: ImageDimension.imageHeight,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(imageList[index])),
                                ),
                                Text(
                                  CategoryService.getInstance()
                                      .dataAllCategoryList[index]
                                      .name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
  }
}

List imageList = [
  Images.laysImg,
  Images.milkImg,
  Images.radisImg,
  Images.potatoImg,
  Images.tomatoImg,
  Images.onionImg,
  Images.chillyImg,
  Images.ladiesFingerImg,
  Images.radisImg,
];
