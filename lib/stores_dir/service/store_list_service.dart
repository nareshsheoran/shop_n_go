// ignore_for_file: avoid_print, prefer_conditional_assignment

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/stores_dir/model/store_list_req.dart';

class StoreListService {
    static StoreListService? _instance;

    StoreListService._internal();

  static StoreListService getInstance() {
    if (_instance == null) {
      _instance = StoreListService._internal();
    }
    return _instance!;
  }

  int? statusCode;
  bool isLoading = false;
  List<StoreListData> dataAllStoreList = [];

  Future<void> fetchStoreDetails() async {
      isLoading = true;
    Uri myUri = Uri.parse(NetworkUtil.getStoreListUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      dataAllStoreList.clear();
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StoreListRequest storeListRequest =
      StoreListRequest.fromJson(jsonResponse);
      List<StoreListData> list = storeListRequest.data!;
      dataAllStoreList.addAll(list);

      // setState(() {
        isLoading = false;
      // });
    }
  }
}
