// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/get_favourite_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_details_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';

class FavouriteWidget extends StatefulWidget {
  const FavouriteWidget({Key? key}) : super(key: key);

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  bool isLoadingRecommended = false;
  List<GetFavouriteReqData> dataFavouriteList = [];

  Future<void> fetchFavouriteDetails() async {
    setState(() {
      isLoadingRecommended = true;
    });
    Uri myUri = Uri.parse(NetworkUtil.getFavouriteProdUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      GetFavouriteReq getFavouriteReq = GetFavouriteReq.fromJson(jsonResponse);
      List<GetFavouriteReqData> list = getFavouriteReq.data!;
      dataFavouriteList.addAll(list);
      if (mounted) {
        fetchProductDetails();
      }

      setState(() {
        isLoadingRecommended = false;
      });
    }
  }

  @override
  void initState() {
    fetchFavouriteDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoadingRecommended || isDetailsLoading)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CProgressIndicator.circularProgressIndicator,
                    SizedBox(height: 16),
                    Text("Please Wait..",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                )),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: productDetailsDataList.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 110,
                      height: 154,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.CategoriesDetailsPage,
                              arguments: ScreenArguments(
                                  Images.baseUrl +
                                      productDetailsDataList[index].itemImages!,
                                  productDetailsDataList[index].itemName!,
                                  productDetailsDataList[index]
                                      .itemCategory!
                                      .toString(),
                                  productDetailsDataList[index].itemCode!));
                        },
                        child: Stack(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Image(
                                          width: ImageDimension.imageWidth - 12,
                                          height: ImageDimension.imageHeight,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(Images.baseUrl +
                                              productDetailsDataList[index]
                                                  .itemImages!)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            productDetailsDataList[index]
                                                .itemName!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text("${weightList[index]}kg",
                                        //     style: TextStyle(fontSize: 12)),
                                        // SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 6,
                                right: 8,
                                child: GestureDetector(
                                    onTap: () {
                                      print(index);
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 24,
                                    ))
                                // FavoriteButton(
                                //   iconSize: 32,
                                //   isFavorite: true,
                                //   valueChanged: (_isFavorite) {
                                //     print('Is Favorite : $_isFavorite');
                                //     _isFavorite
                                //         ? AddProdIntoFavService()
                                //         .addProdIntoFav(
                                //         productDetailsDataList[index]
                                //             .itemCode)
                                //         : Fluttertoast.showToast(
                                //         msg: "Favourite Removed");
                                //   },
                                // ),
                                )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
  }

  bool isDetailsLoading = false;
  ProductDetailsData? productDetailsData;
  List productDetailsDataList = [];

  Future fetchProductDetails() async {
    setState(() {
      isDetailsLoading = true;
    });
    // for (int i = 0; i < dataFavouriteList.length; i++) {
    if (dataFavouriteList.length > 5) {
      for (int i = 0; i < 5; i++) {
        print(i.toString());
        Uri myUri = Uri.parse(
            "${NetworkUtil.getProductDetailsUrl}${dataFavouriteList[i].favProduct}");

        Response response = await get(myUri);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          ProductDetailsReq productDetailsReq =
              ProductDetailsReq.fromJson(jsonResponse);

          productDetailsData = productDetailsReq.data!;
          productDetailsDataList.add(productDetailsData);
          // init();
        }
      }
    } else {
      for (int i = 0; i < dataFavouriteList.length; i++) {
        print(i.toString());
        Uri myUri = Uri.parse(
            "${NetworkUtil.getProductDetailsUrl}${dataFavouriteList[i].favProduct}");

        Response response = await get(myUri);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          ProductDetailsReq productDetailsReq =
              ProductDetailsReq.fromJson(jsonResponse);

          productDetailsData = productDetailsReq.data!;
          productDetailsDataList.add(productDetailsData);
          // init();
        }
      }
    }
    if(mounted){
    setState(() {
      isDetailsLoading = false;
      // id = ProfileDetails.id;
    });}
  }

  @override
  void dispose() {
      isDetailsLoading = false;
      productDetailsDataList.clear();
    super.dispose();
  }
}
