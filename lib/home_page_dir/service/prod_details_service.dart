// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_details_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class ProdDetailsService {
  ProdDetailsService._internal();

  static final ProdDetailsService _instance = ProdDetailsService._internal();

  factory ProdDetailsService() {
    return _instance;
  }

  bool isLoading = false;
  late ProductDetailsData productDetailsData;

  Future fetchProductDetails(id) async {
    isLoading = true;
    Uri myUri = Uri.parse("${NetworkUtil.getProductDetailsUrl}$id");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      ProductDetailsReq bestSellerRequest =
          ProductDetailsReq.fromJson(jsonResponse);

      productDetailsData = bestSellerRequest.data!;

      isLoading = false;
    }
  }
}
