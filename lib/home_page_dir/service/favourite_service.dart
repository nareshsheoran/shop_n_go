// ignore_for_file: avoid_print, prefer_conditional_assignment

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_category_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/get_favourite_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/home_page_dir/model_req/recommended_req.dart';
import 'package:shop_n_go/home_page_dir/service/prod_details_service.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

import '../model_req/best_seller_req.dart';

class FavouriteService {
  static FavouriteService? _instance;

  FavouriteService._internal();

  static FavouriteService getInstance() {
    if (_instance == null) {
      _instance = FavouriteService._internal();
    }
    return _instance!;
  }

  bool isLoadingRecommended = false;
  List<GetFavouriteReqData> dataFavouriteList = [];

  Future<List> fetchFavouriteDetails() async {
    dataFavouriteList.clear();
      isLoadingRecommended = true;
    Uri myUri = Uri.parse(NetworkUtil.getFavouriteProdUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      GetFavouriteReq getFavouriteReq = GetFavouriteReq.fromJson(jsonResponse);
      List<GetFavouriteReqData> list = getFavouriteReq.data!;
      dataFavouriteList.addAll(list);
      FavProdDetailsService.getInstance().fetchProductDetails();
        isLoadingRecommended = false;
    }
    return dataFavouriteList;
  }
}
