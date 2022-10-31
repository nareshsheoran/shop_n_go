// ignore_for_file: avoid_print, prefer_conditional_assignment

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class ProductAddCartService {
  // ProductAddCartService._internal();
  //
  // static final ProductAddCartService _instance =
  //     ProductAddCartService._internal();
  //
  // factory ProductAddCartService() {
  //   return _instance;
  // }

  static ProductAddCartService? _instance;

  ProductAddCartService._internal();

  static ProductAddCartService getInstance() {
    if (_instance == null) {
      _instance = ProductAddCartService._internal();
    }
    return _instance!;
  }

  int? statusCode;

  Future proAddedIntoCart(index, code) async {
    String user = ProfileDetails.id!;
    String prodICart = code;
    print("user: $user===prodICart:$prodICart");

    var requestBody = {
      'user': user,
      'added_pro_into_cart': prodICart,
    };

    Uri myUri = Uri.parse(NetworkUtil.getProductIntoCardUrl);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map =
      jsonDecode(response.body) as Map<String, dynamic>;

      ProdAddedReqRes prodAddedReqRes = ProdAddedReqRes.fromJson(map);

      if (prodAddedReqRes.message == "data Saved SuccesFully") {
        // setState(() {
        //   getProdBasedOnBarCodeList.removeAt(index);
        // });
        statusCode = 200;
        // Fluttertoast.showToast(msg: "Product Added", timeInSecForIosWeb: 2);
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
