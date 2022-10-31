<<<<<<< HEAD
// ignore_for_file: avoid_print, prefer_conditional_assignment, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/get_favourite_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class FavouriteService {
  static FavouriteService? _instance;

  FavouriteService._internal();

  static FavouriteService getInstance() {
    if (_instance == null) {
      _instance = FavouriteService._internal();
    }
    return _instance!;
=======
// ignore_for_file: avoid_print

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
  FavouriteService._internal();

  static final FavouriteService _instance = FavouriteService._internal();

  factory FavouriteService() {
    return _instance;
>>>>>>> origin/master
  }

  bool isLoadingRecommended = false;
  List<GetFavouriteReqData> dataFavouriteList = [];

<<<<<<< HEAD
  Future<List> fetchFavouriteDetails() async {
    isLoadingRecommended = true;
    Uri myUri = Uri.parse(NetworkUtil.getFavouriteProdUrl + ProfileDetails.id!);
    print("myUri::${myUri}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      dataFavouriteList.clear();
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      GetFavouriteReq getFavouriteReq = GetFavouriteReq.fromJson(jsonResponse);
      if (getFavouriteReq.success == false) {
        isLoadingRecommended = false;
      } else {
        List<GetFavouriteReqData> list = getFavouriteReq.data!;
        dataFavouriteList.addAll(list);
        isLoadingRecommended = false;
        print("sss::${dataFavouriteList.length}");
      }
    }
    return dataFavouriteList;
=======
  Future<void> fetchFavouriteDetails() async {
      isLoadingRecommended = true;
    Uri myUri = Uri.parse(NetworkUtil.getFavouriteProdUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      GetFavouriteReq getFavouriteReq = GetFavouriteReq.fromJson(jsonResponse);
      List<GetFavouriteReqData> list = getFavouriteReq.data!;
      dataFavouriteList.addAll(list);
        isLoadingRecommended = false;
    }
>>>>>>> origin/master
  }
}
