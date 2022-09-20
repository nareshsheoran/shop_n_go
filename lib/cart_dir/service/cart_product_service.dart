// ignore_for_file: avoid_print, prefer_conditional_assignment, unnecessary_null_comparison

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:shop_n_go/cart_dir/model/all_cart_prod_req.dart';
import 'package:shop_n_go/cart_dir/service/product_details_service.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/home_page_dir/model_req/recommended_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

import '../../home_page_dir/model_req/best_seller_req.dart';

class CartProductService {
  // CartProductService._internal();
  //
  // static final CartProductService _instance = CartProductService._internal();
  //
  // factory CartProductService() {
  //   return _instance;
  // }
  static CartProductService? _instance;
  CartProductService._internal();

  static CartProductService getInstance() {
    if (_instance == null) {
      _instance = CartProductService._internal();
    }
    return _instance!;
  }






  String? length;

  int? statusCode;
  List<AllCartProductData> dataAllCartProductList = [];
  bool isLoading = false;

  Future<List> fetchAllCartProductDataDetails() async {
    // setState(() {
      isLoading = true;
      // number = 1;
    // });
    Uri myUri =
    // Uri.parse("${NetworkUtil.getOrderDetailsUrl}${ProfileDetails.id}");
    Uri.parse("${NetworkUtil.getAllCartProductUrl}${ProfileDetails.id}");
    Response response = await get(myUri);
      dataAllCartProductList.clear();
    if (response.statusCode == 200) {
      dataAllCartProductList.clear();
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AllCartProductReq allCartProductData =
      AllCartProductReq.fromJson(jsonResponse);
      List<AllCartProductData> list = allCartProductData.data!;

      dataAllCartProductList.addAll(list);
      print("ser::${dataAllCartProductList.length}");
      ProductService.getInstance().fetchProductDetails();
      // setState(() {
      length=ProductService.getInstance().fetchProductDetails().toString();
        isLoading = false;
      // });
    }
      return dataAllCartProductList;
  }
}
