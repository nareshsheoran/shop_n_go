// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/home_page_dir/model_req/recommended_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

import '../model_req/best_seller_req.dart';

class BestSellerService {
  BestSellerService._internal();

  static final BestSellerService _instance = BestSellerService._internal();

  factory BestSellerService() {
    return _instance;
  }

  int? statusCode;
  bool isLoadingBestSeller = false;
  List<BestSellerData> dataBestSellerList = [];

  Future<void> fetchBestSellerDetails() async {
    isLoadingBestSeller = true;

    Uri myUri = Uri.parse(NetworkUtil.getRecommendedUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      BestSellerRequest bestSellerRequest =
          BestSellerRequest.fromJson(jsonResponse);
      List<BestSellerData> list = bestSellerRequest.data!;
      dataBestSellerList.addAll(list);
      dataBestSellerList = list;

      isLoadingBestSeller = false;
    }
  }
}
