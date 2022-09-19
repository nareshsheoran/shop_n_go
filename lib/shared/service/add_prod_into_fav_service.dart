// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/home_page_dir/model_req/add_prod_into_fav_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class AddProdIntoFavService {
  AddProdIntoFavService._internal();

  static final AddProdIntoFavService _instance =
      AddProdIntoFavService._internal();

  factory AddProdIntoFavService() {
    return _instance;
  }

  int? statusCode;

  Future addProdIntoFav(code) async {
    String user = ProfileDetails.id!;
    String favProduct = code;
    print("user: $user===prodICart:$favProduct");

    var requestBody = {
      'user': user,
      'fav_product': favProduct,
    };

    Uri myUri = Uri.parse(NetworkUtil.getAddIntoFavouriteUrl);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      AddProdIntoFavReq addProdIntoFavReq = AddProdIntoFavReq.fromJson(map);

      if (addProdIntoFavReq.message == "Data Saved SuccessFully") {
        statusCode = 200;

        print("Product Favourite:$favProduct");
        Fluttertoast.showToast(msg: "Product Favourite", timeInSecForIosWeb: 2);
      }
    } else {
      statusCode = response.statusCode;
      Fluttertoast.showToast(
          msg: "Request failed with Error: ${response.statusCode}",
          timeInSecForIosWeb: 2);

      print(
          'addProdIntoFav: Request failed with status: ${response.statusCode}');
    }
  }
}