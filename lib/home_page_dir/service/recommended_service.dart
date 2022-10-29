// ignore_for_file: avoid_print, prefer_conditional_assignment

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/home_page_dir/model_req/recommended_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

class RecommendedService {
  static RecommendedService? _instance;

  RecommendedService._internal();

  static RecommendedService getInstance() {
    if (_instance == null) {
      _instance = RecommendedService._internal();
    }
    return _instance!;
  }

  int? statusCode;
  bool isLoadingRecommended = false;
  List<RecommendedData> dataRecommendedList = [];

  Future<void> fetchRecommendedDetails() async {
    // setStatetate(() {
      isLoadingRecommended = true;
    // });
    Uri myUri = Uri.parse(NetworkUtil.getRecommendedUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      RecommendedRequest recommendedRequest =
      RecommendedRequest.fromJson(jsonResponse);
      List<RecommendedData> list = recommendedRequest.data!;
      dataRecommendedList.addAll(list);
      dataRecommendedList = list;
      // setStatetatee(() {
        isLoadingRecommended = false;
      // });
    }
  }
}
