// ignore_for_file: await_only_futures, avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String idKey = "IdKey";
  static String nameKey = "NameKey";
  static String userNameKey = "UserNameKey";
  static String tokenSignUpKey = "TokenSignUpKey";
  static String tokenLoginKey = "TokenLoginKey";
  static String emailKey = "EmailKey";
  static String passwordKey = "PasswordKey";
  static String phoneKey = "PhoneKey";
  static String resendPhoneKey = "ResendPhoneKey";
  static String otpKey = "otpKey";
  static String dateKey = "DateKey";
  static String genderKey = "GenderKey";
  static String imgKey = "ImgKey";
  static String logKey = "LogKey";

  static Future<bool> saveID(String? userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(idKey, userID!);
  }

  static Future<String?> getID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(idKey);
  }

  static Future<bool> saveName(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nameKey, username);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nameKey);
  }

  static Future<bool> saveUserName(String? usersName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userNameKey, usersName!);
  }

  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(userNameKey);
  }

  static Future<bool> saveSignUpToken(String userSignUpToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(tokenSignUpKey, userSignUpToken);
  }

  static Future<String?> getSignUpToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(tokenSignUpKey);
  }

  static Future<bool> saveLoginToken(String userLoginToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(tokenLoginKey, userLoginToken);
  }

  static Future<String?> getLoginToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(tokenLoginKey);
  }

  static Future<bool> saveEmail(String? userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(emailKey, userEmail!);
  }

  static Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(emailKey);
  }

  static Future<bool> saveImg(String userImg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(imgKey, userImg);
  }

  static Future<String?> getImg() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(imgKey);
  }

  static Future<bool> savePassword(String userPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(passwordKey, userPassword);
  }

  static Future<String?> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(passwordKey);
  }

  static Future<bool> savePhone(String userPhone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(phoneKey, userPhone);
  }

  static Future<String?> getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(phoneKey);
  }

  static Future<bool> saveResendPhone(String userResendPhone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(resendPhoneKey, userResendPhone);
  }

  static Future<String?> getResendPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(resendPhoneKey);
  }

   static Future<bool> saveOTP(String userOTP) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(otpKey, userOTP);
  }

  static Future<String?> getOTP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(otpKey);
  }

  static Future<bool> saveDate(String userDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(dateKey, userDate);
  }

  static Future<String?> getDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(dateKey);
  }

  static Future<bool> saveGender(String userGender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(genderKey, userGender);
  }

  static Future<String?> getGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(genderKey);
  }

  static Future<bool> saveLoginData(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logKey, isUserLoggedIn);
  }

  static Future<bool?> getLogData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(logKey);
  }

  static removePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('IdKey');
    await preferences.remove('NameKey');
    await preferences.remove('UserNameKey');
    await preferences.remove('EmailKey');
    await preferences.remove('PasswordKey');
    await preferences.remove('TokenLoginKey');
    await preferences.remove('ImgKey');
    await preferences.remove('PhoneKey');
    await preferences.remove('ResendPhoneKey');
    await preferences.remove('LogKey');
    await preferences.remove('DateKey');
    await preferences.remove('GenderKey');
    await preferences.clear();
  }
}
