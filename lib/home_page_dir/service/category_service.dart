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

class CategoryService {
  CategoryService._internal();

  static final CategoryService _instance = CategoryService._internal();

  factory CategoryService() {
    return _instance;
  }

  int? statusCode;
  bool isLoadingAllCategory = false;
  List<AllCategoryData> dataAllCategoryList = [];

  Future<void> fetchAllCategory() async {
    // setState(() {
      isLoadingAllCategory = true;
    // });
    Uri myUri = Uri.parse(NetworkUtil.getCategoryUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AllCategoryRequest allCategoryRequest =
      AllCategoryRequest.fromJson(jsonResponse);
      List<AllCategoryData> list = allCategoryRequest.data!;
      dataAllCategoryList.addAll(list);
      dataAllCategoryList = list;
      // setState(() {
        isLoadingAllCategory = false;
      // });
    }
  }
}
