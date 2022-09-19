import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/home_page_dir/service/new_product_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';
import 'package:shop_n_go/shared/service/add_prod_into_fav_service.dart';

class NewProductWidget extends StatefulWidget {
  const NewProductWidget({Key? key}) : super(key: key);

  @override
  State<NewProductWidget> createState() => _NewProductWidgetState();
}

class _NewProductWidgetState extends State<NewProductWidget> {
  @override
  Widget build(BuildContext context) {
    return (NewProductService().isLoadingAllProd)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Center(
              child: CProgressIndicator.circularProgressIndicator,
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount:
                      NewProductService().dataAllProdList.length.bitLength,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
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
                                      NewProductService()
                                          .dataAllProdList[index]
                                          .itemImages!,
                                  NewProductService()
                                      .dataAllProdList[index]
                                      .itemName!,
                                  "Categories",
                                  NewProductService()
                                      .dataAllProdList[index]
                                      .itemCode!));
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
                                              NewProductService()
                                                  .dataAllProdList[index]
                                                  .itemImages!)),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            NewProductService()
                                                .dataAllProdList[index]
                                                .itemName!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
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
                                    _isFavorite
                                        ? AddProdIntoFavService()
                                            .addProdIntoFav(NewProductService()
                                                .dataAllProdList[index]
                                                .itemCode)
                                        : Fluttertoast.showToast(
                                            msg: "Favourite Removed");
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