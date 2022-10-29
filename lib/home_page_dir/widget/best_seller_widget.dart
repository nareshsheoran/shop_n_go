// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/home_page_dir/service/best_seller_service.dart';
import 'package:shop_n_go/home_page_dir/service/favourite_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';

class BestSellerWidget extends StatefulWidget {
  const BestSellerWidget({Key? key}) : super(key: key);

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {

  @override
  void initState() {
    // BestSellerService.getInstance().fetchBestSellerDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return (BestSellerService.getInstance().isLoadingBestSeller)
        ? SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 140,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CProgressIndicator.circularProgressIndicator,
                SizedBox(height: 16),
                Text("Please Wait..",
                    style: TextStyle(fontWeight: FontWeight.w500))
              ],
            )))
        : SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListView.builder(
            itemCount:
            BestSellerService.getInstance().dataBestSellerList.length.bitLength,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var item =
                  BestSellerService.getInstance().dataBestSellerList;
              return SizedBox(
                width: 120,
                height: 164,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.CategoriesDetailsPage,
                        arguments: ScreenArguments(
                            Images.baseUrl + item[index].itemImages!,
                            item[index].itemName!,
                            item[index].description!,
                            item[index].itemCode!));
                  },
                  child: Stack(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Image(
                                    width: ImageDimension.imageWidth - 12,
                                    height: ImageDimension.imageHeight,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(Images.baseUrl +
                                        item[index].itemImages!)),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item[index].itemName!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 4),
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
                          child: FavoriteButton(
                            iconSize: 32,
                            isFavorite: false,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                              if (_isFavorite) {
                                FavouriteService.getInstance()
                                    .fetchFavouriteDetails();
                                AddProdIntoFavService().addProdIntoFav(
                                    item[index].itemCode,
                                    item[index].vendorId);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Favourite Removed");
                              }
                            },
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
