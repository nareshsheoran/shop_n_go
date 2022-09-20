// ignore_for_file: avoid_print, prefer_conditional_assignment, unnecessary_null_comparison

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:shop_n_go/cart_dir/model/all_cart_prod_req.dart';
import 'package:shop_n_go/cart_dir/service/cart_product_service.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_details_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/recommended_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

import '../../home_page_dir/model_req/best_seller_req.dart';

class ProductService {
  // ProductService._internal();
  // static final ProductService getInstance = ProductService._internal();
  // factory ProductService() {
  //   return getInstance;
  // }

  static ProductService? _instance;

  ProductService._internal();

  static ProductService getInstance() {
    if (_instance == null) {
      _instance = ProductService._internal();
    }
    return _instance!;
  }

  int? statusCode;
  bool isDetailsLoading = false;
  late ProductDetailsData productDetailsData;

  List productDetailsDataList = [];

  Future fetchProductDetails() async {
    productDetailsDataList.clear();
      isDetailsLoading = true;
      var number=CartProductService.getInstance().dataAllCartProductList;
    for (int i = 0; i < 8; i++) {
      Uri myUri = Uri.parse(
          "${NetworkUtil.getProductDetailsUrl}${CartProductService.getInstance().dataAllCartProductList[i].addedProIntoCart}");
      Response response = await get(myUri);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        ProductDetailsReq productDetailsReq =
        ProductDetailsReq.fromJson(jsonResponse);

        productDetailsData = productDetailsReq.data!;
        productDetailsDataList.add(productDetailsData);
        print(
            "QQ:${number.length - productDetailsDataList.length}");
      }
    }


    }
  }


