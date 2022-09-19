// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

class UserProfileService {
  UserProfileService._internal();

  static final UserProfileService _instance = UserProfileService._internal();

  factory UserProfileService() {
    return _instance;
  }

  int? statusCode;
  bool isUserProfileLoading = false;
  List<UserProfileRequestData> userProfileList = [];

  Future<void> fetchUserProfileDetails() async {
    isUserProfileLoading = false;
    Uri myUri =
        Uri.parse("${NetworkUtil.getUserProfileUrl}${ProfileDetails.userName}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      UserProfileRequest userProfileRequest =
          UserProfileRequest.fromJson(jsonResponse);
      UserProfileRequestData? userProfileRequestData = userProfileRequest.data;

      LocalDataSaver.saveID(userProfileRequestData!.id.toString());
      LocalDataSaver.saveUserName(userProfileRequestData.username);
      LocalDataSaver.saveEmail(userProfileRequestData.email);

      ProfileDetails.id = (await LocalDataSaver.getID())!;
      ProfileDetails.userName = (await LocalDataSaver.getUserName())!;
      ProfileDetails.email = (await LocalDataSaver.getEmail())!;
      print("ProfileDetails.email::${ProfileDetails.email}");

      isUserProfileLoading = false;
    }
  }
}
