// ignore_for_file: avoid_print, prefer_conditional_assignment

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_product_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

import '../model_req/best_seller_req.dart';

class NewProductService {
  static NewProductService? _instance;

  NewProductService._internal();

  static NewProductService getInstance() {
    if (_instance == null) {
      _instance = NewProductService._internal();
    }
    return _instance!;
  }

  int? statusCode;
  bool isLoadingAllProd = false;
  List<AllProductData> dataAllProdList = [];

  Future<void> fetchNewProduct() async {
      isLoadingAllProd = true;

    Uri myUri = Uri.parse(NetworkUtil.getAllProductUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AllProductRequest allProductRequest =
      AllProductRequest.fromJson(jsonResponse);
      List<AllProductData> list = allProductRequest.data!;
      dataAllProdList.addAll(list);
      dataAllProdList = list;

        isLoadingAllProd = false;

    }
  }

}
