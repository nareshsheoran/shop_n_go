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
  }

  bool isLoadingRecommended = false;
  List<GetFavouriteReqData> dataFavouriteList = [];

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
  }
}
