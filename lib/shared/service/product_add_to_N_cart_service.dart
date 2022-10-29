// ignore_for_file: avoid_print, prefer_conditional_assignment

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/cart_dir/service/cart_product_service.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class ProductAddToNCartService {
  static ProductAddToNCartService? _instance;

  ProductAddToNCartService._internal();

  static ProductAddToNCartService getInstance() {
    if (_instance == null) {
      _instance = ProductAddToNCartService._internal();
    }
    return _instance!;
  }

  int? statusCode;

  Future proAddedIntoCart(itemCode, storeId) async {
    String consumerId = ProfileDetails.id!;
    print("consumerId: $consumerId==itemCode:$itemCode==storeId:$storeId");

    var requestBody = {
      'consumer_id': consumerId,
      'item_code': itemCode,
      'store_id': storeId,
      'quantity': "1",
    };

    Uri myUri = Uri.parse(NetworkUtil.postAddToCartUrl);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    print("Operation:${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      ProdAddedReqRes prodAddedReqRes = ProdAddedReqRes.fromJson(map);
      print("message:${prodAddedReqRes.message}");

      if (prodAddedReqRes.message == "Operation Success...!!!") {
        CartProductService.getInstance().fetchStoreListCartDetails();
        statusCode = 200;
        Fluttertoast.showToast(msg: "Product Added", timeInSecForIosWeb: 2);
      }
    } else {
      statusCode = response.statusCode;
      Fluttertoast.showToast(
          msg: "Request failed with Error: ${response.statusCode}",
          timeInSecForIosWeb: 2);

      print(
          'proAddedIntoCart: Request failed with status: ${response.statusCode}');
    }
  }
}
