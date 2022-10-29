// ignore_for_file: await_only_futures, avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class AddressLocalDataSaver {
  static String flatKey = "FlatKey";
  static String areaKey = "AreaKey";
  static String cityKey = "CityKey";
  static String landmarkKey = "LandmarkKey";
  static String stateKey = "StateKey";
  static String pinCodeKey = "PinCodeKey";
  static String countryKey = "CountryKey";
  static String longitudeKey = "LongitudeKey";
  static String latitudeKey = "LatitudeKey";

  static Future<bool> saveFlat(String userFlat) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(flatKey, userFlat);
  }

  static Future<String?> getFlat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(flatKey);
  }

  static Future<bool> saveArea(String? usersVillage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(areaKey, usersVillage!);
  }

  static Future<String?> getArea() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(areaKey);
  }

  static Future<bool> saveCity(String userCity) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(cityKey, userCity);
  }

  static Future<String?> getCity() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(cityKey);
  }

 static Future<bool> saveLandmark(String userLandmark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(landmarkKey, userLandmark);
  }

  static Future<String?> getLandmark() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(landmarkKey);
  }

  static Future<bool> saveState(String userState) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(stateKey, userState);
  }

  static Future<String?> getState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(stateKey);
  }

  static Future<bool> savePinCode(String? userPinCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(pinCodeKey, userPinCode!);
  }

  static Future<String?> getPinCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(pinCodeKey);
  }

  static Future<bool> saveCountry(String userCountry) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(countryKey, userCountry);
  }

  static Future<String?> getCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(countryKey);
  }


  static Future<bool> saveLongitude(String? userLongitude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(longitudeKey, userLongitude!);
  }

  static Future<String?> getLongitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(longitudeKey);
  }

  static Future<bool> saveLatitude(String? userLatitude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(latitudeKey, userLatitude!);
  }

  static Future<String?> getLatitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(latitudeKey);
  }

  static removePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('FlatKey');
    await preferences.remove('VillageKey');
    await preferences.remove('StateKey');
    await preferences.remove('CityKey');
    await preferences.remove('LandmarkKey');
    await preferences.remove('PinCodeKey');
    await preferences.remove('CountryKey');
    await preferences.remove('LongitudeKey');
    await preferences.remove('LatitudeKey');
    await preferences.clear();
  }
}
