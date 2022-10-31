<<<<<<< HEAD
// ignore_for_file: avoid_print, prefer_conditional_assignment, prefer_conditional_assignment
=======
// ignore_for_file: avoid_print
>>>>>>> origin/master

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_details_req.dart';
<<<<<<< HEAD
import 'package:shop_n_go/home_page_dir/service/favourite_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class FavProdDetailsService {
  static FavProdDetailsService? _instance;

  FavProdDetailsService._internal();

  static FavProdDetailsService getInstance() {
    if (_instance == null) {
      _instance = FavProdDetailsService._internal();
    }
    return _instance!;
  }

  bool isDetailsLoading = false;
  ProductDetailsData? productDetailsData;
  List productDetailsDataList = [];

  Future fetchProductDetails() async {
    isDetailsLoading = true;
    productDetailsDataList.clear();
    print("aa::${FavouriteService.getInstance().dataFavouriteList.length}");
    print("bb::${FavProdDetailsService.getInstance().productDetailsDataList.length}");
    if (FavouriteService.getInstance().dataFavouriteList.isNotEmpty) {
      // for (int i = 0; i < 5; i++) {
      for (int i = 0; i < FavouriteService.getInstance().dataFavouriteList.length; i++) {
        print(i.toString());
        Uri myUri = Uri.parse(
            "${NetworkUtil.getProductDetailsUrl}${FavouriteService.getInstance().dataFavouriteList[i].itemCode}");

        Response response = await get(myUri);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          ProductDetailsReq productDetailsReq =
              ProductDetailsReq.fromJson(jsonResponse);
          List<ProductDetailsData> list = productDetailsReq.data!;
          productDetailsDataList.addAll(list);
          print("productDetailsDataList:${productDetailsDataList.length}");
        }
      }
    } else {
      for (int i = 0; i < FavouriteService.getInstance().dataFavouriteList.length; i++) {
        print(i.toString());
        Uri myUri = Uri.parse(
            "${NetworkUtil.getProductDetailsUrl}${FavouriteService.getInstance().dataFavouriteList[i].itemCode}");

        Response response = await get(myUri);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          ProductDetailsReq productDetailsReq =
              ProductDetailsReq.fromJson(jsonResponse);

          List<ProductDetailsData> list = productDetailsReq.data!;
          productDetailsDataList.addAll(list);
          // init();
          print("productDetailsDataList:${productDetailsDataList.length}");
        }
      }
=======
import 'package:shop_n_go/shared/auth/constant.dart';

class ProdDetailsService {
  ProdDetailsService._internal();

  static final ProdDetailsService _instance = ProdDetailsService._internal();

  factory ProdDetailsService() {
    return _instance;
  }

  bool isLoading = false;
  late ProductDetailsData productDetailsData;

  Future fetchProductDetails(id) async {
    isLoading = true;
    Uri myUri = Uri.parse("${NetworkUtil.getProductDetailsUrl}$id");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      ProductDetailsReq bestSellerRequest =
          ProductDetailsReq.fromJson(jsonResponse);

      productDetailsData = bestSellerRequest.data!;

      isLoading = false;
>>>>>>> origin/master
    }
  }
}
