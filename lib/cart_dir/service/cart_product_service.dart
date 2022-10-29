// ignore_for_file: avoid_print, prefer_conditional_assignment, unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/cart_dir/model/store_list_cart_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class CartProductService {
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
  List<StoreListCartReqData> dataStoreCartList = [];
  bool isLoading = false;

  Future fetchStoreListCartDetails() async {
    isLoading = true;


    Uri myUri =
        Uri.parse("${NetworkUtil.storeListCartUrl}${ProfileDetails.id}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      dataStoreCartList.clear();
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StoreListCartReq storeListCartReq =
          StoreListCartReq.fromJson(jsonResponse);
      if (storeListCartReq.message == "No Any Product") {
        isLoading = false;
        dataStoreCartList.clear();
      } else {
        List<StoreListCartReqData> list = storeListCartReq.data!;
        dataStoreCartList.addAll(list);
      }

      isLoading = false;
    }
  }
}
