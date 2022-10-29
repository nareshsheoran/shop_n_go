// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/shared/shared_preference_data/address_localdb.dart';
import 'package:shop_n_go/shared/shared_preference_data/fetch_data_SP.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: Constant.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24)),
                border: Border.all(color: Constant.primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1VTcdzIfHrD1mnqlyyYKPHFSOvDM4YCOVIA&usqp=CAU"),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileDetails.userName == '' ||
                                  ProfileDetails.userName == null
                              ? Text(
                                  "User Name",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  ProfileDetails.userName!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                          ProfileDetails.email == null
                              ? Text(
                                  "User Email",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  ProfileDetails.email!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: CardDimension.elevation,
                            primary: CardDimension.shadowColor),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.ProfilePage);
                        },
                        child: Row(
                          children: [
                            Text(
                              "EDIT",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black,
                              size: 16,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildGestureDetector(
                        AppRoutes.ProfilePage, "Profile", Icons.person),
                    buildGestureDetector(AppRoutes.AddressPage, "Addresses",
                        Icons.location_on_outlined),
                    buildGestureDetector(
                        AppRoutes.OrderPage, "Orders", Icons.shopping_cart),
                    buildGestureDetector(
                        AppRoutes.PaymentPage, "Payments", Icons.payment),
                    buildGestureDetector(
                        AppRoutes.RewardPage, "Rewards", Icons.local_offer),
                    buildGestureDetector(AppRoutes.CancelRefundPage,
                        "Cancellation & Refund Policy", Icons.policy_outlined),
                    buildGestureDetector(AppRoutes.PrivacyPolicyPage,
                        "Privacy Policy", Icons.policy_rounded),
                    buildGestureDetector(AppRoutes.TermConditionPage,
                        "Terms & Conditions", Icons.local_police_rounded),
                    buildGestureDetector(
                        AppRoutes.AboutUsPage, "About Us", Icons.info_outline),
                    buildGestureDetector(
                        AppRoutes.HelpPage, "Help", Icons.help),
                    buildGestureDetector(
                        AppRoutes.SettingPage, "Settings", Icons.settings),
                    GestureDetector(
                        onTap: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Log Out?"),
                                  content: Text("Are you sure to Log Out?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        setState(() {
                                          signOut();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                          // AwesomeDialog(
                          //     context: context,
                          //     dialogType: DialogType.WARNING,
                          //     headerAnimationLoop: false,
                          //     animType: AnimType.BOTTOMSLIDE,
                          //     title: 'Warning',
                          //     titleTextStyle: const TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 20),
                          //     desc: 'Are you sure to Logout?',
                          //     descTextStyle: TextStyle(
                          //         fontSize: 16, fontWeight: FontWeight.w600),
                          //     buttonsTextStyle: TextStyle(color: Colors.black),
                          //     showCloseIcon: true,
                          //     btnCancelOnPress: () {},
                          //     btnOkOnPress: () async {
                          //       signOut();
                          //       await Navigator.pushReplacementNamed(
                          //           context, AppRoutes.LoginScreenPage);
                          //     }).show();
                        },
                        child: ListTile(
                          title: Text("Log Out"),
                          leading: Icon(Icons.logout_outlined),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGestureDetector(routes, title, icon) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routes);
        },
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
        ));
  }

  Future<String> signOut() async {
    await LocalDataSaver.saveLoginData(false);
    LocalDataSaver.removePreferences();
    AddressLocalDataSaver.removePreferences();
    await AddressLocalDataSaver.removePreferences();
    await LocalDataSaver.removePreferences();
    await clearDataSP();
    await fetchDataSP();

    await Fluttertoast.showToast(
      msg: "Logout Successful",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
    );
    Navigator.of(context).pop();

    await Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);

    return "Success";
  }
}
