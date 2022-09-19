import 'package:shop_n_go/shared/shared_preference_data/address_localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

Future<void> fetchDataSP() async {
  ProfileDetails.id = await LocalDataSaver.getID();
  ProfileDetails.name = await LocalDataSaver.getName();
  ProfileDetails.userName = await LocalDataSaver.getUserName();
  ProfileDetails.email = await LocalDataSaver.getEmail();
  ProfileDetails.phone = await LocalDataSaver.getPhone();
  ProfileDetails.password = await LocalDataSaver.getPassword();
  ProfileDetails.img = await LocalDataSaver.getImg();
  ProfileDetails.date = await LocalDataSaver.getDate();
  ProfileDetails.gender = await LocalDataSaver.getGender();
  ProfileDetails.signUpToken = await LocalDataSaver.getSignUpToken();
  ProfileDetails.loginToken = await LocalDataSaver.getLoginToken();
  ProfileDetails.resendPhone = await LocalDataSaver.getResendPhone();
  MapDetails.longitude = await AddressLocalDataSaver.getLongitude();
  MapDetails.latitude = await AddressLocalDataSaver.getLatitude();
  AddressDetails.flat = await AddressLocalDataSaver.getFlat();
  AddressDetails.village = await AddressLocalDataSaver.getVillage();
  AddressDetails.city = await AddressLocalDataSaver.getCity();
  AddressDetails.state = await AddressLocalDataSaver.getState();
  AddressDetails.country = await AddressLocalDataSaver.getCountry();
  AddressDetails.pinCode = await AddressLocalDataSaver.getPinCode();
}

Future<void> clearDataSP() async {
  LocalDataSaver.saveID('');
  LocalDataSaver.saveName('');
  LocalDataSaver.saveUserName('');
  LocalDataSaver.saveImg('');
  LocalDataSaver.saveEmail('');
  LocalDataSaver.savePhone('');
  LocalDataSaver.savePassword('');
  LocalDataSaver.saveLoginToken('');
  LocalDataSaver.saveSignUpToken('');
  LocalDataSaver.saveResendPhone('');
  LocalDataSaver.saveDate('');
  LocalDataSaver.saveGender('');
  LocalDataSaver.saveLoginData(false);
  AddressLocalDataSaver.saveLatitude('');
  AddressLocalDataSaver.saveLongitude('');
  AddressLocalDataSaver.saveFlat("");
  AddressLocalDataSaver.saveVillage("");
  AddressLocalDataSaver.saveCity("");
  AddressLocalDataSaver.saveState("");
  AddressLocalDataSaver.savePinCode("");
  AddressLocalDataSaver.saveCountry("");
}
