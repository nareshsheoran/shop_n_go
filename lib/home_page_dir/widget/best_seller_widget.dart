// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/best_seller_req.dart';
import 'package:shop_n_go/home_page_dir/service/best_seller_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';

class BestSellerWidget extends StatefulWidget {
  const BestSellerWidget({Key? key}) : super(key: key);

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {

  @override
  Widget build(BuildContext context) {
    return (BestSellerService().isLoadingBestSeller)
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
            itemCount: BestSellerService().dataBestSellerList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 110,
                height: 150,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.CategoriesDetailsPage,
                        arguments: ScreenArguments(
                            Images.baseUrl +
                                BestSellerService().dataBestSellerList[index].itemImages!,
                            BestSellerService().dataBestSellerList[index].itemName!,
                            BestSellerService().dataBestSellerList[index].description!,
                            BestSellerService().dataBestSellerList[index].itemCode!));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image(
                                width: ImageDimension.imageWidth,
                                height: ImageDimension.imageHeight,
                                fit: BoxFit.fill,
                                image: NetworkImage(Images.baseUrl +
                                    BestSellerService().dataBestSellerList[index]
                                        .itemImages!)),
                          ),
                          Expanded(
                            child: Text(
                              BestSellerService().dataBestSellerList[index].itemName!,
                              style:
                              TextStyle(fontWeight: FontWeight.w800),
                            ),
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
