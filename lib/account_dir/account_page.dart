// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/auth/localdb.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';

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
                          ProfileDetails.name == '' ||
                                  ProfileDetails.name == null
                              ? Text(
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  ProfileDetails.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                          Text(
                            ProfileDetails.email,
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
                    buildGestureDetector(AppRoutes.ProfilePage, "Profile"),
                    buildGestureDetector(AppRoutes.AddressPage, "Addresses"),
                    ListTile(title: Text("Orders")),
                    ListTile(title: Text("Payments")),
                    buildGestureDetector(AppRoutes.RewardPage, "Rewards"),
                    ListTile(title: Text("Cancellation & Refund Policy")),
                    ListTile(title: Text("Privacy Policy")),
                    ListTile(title: Text("Terms & Conditions")),
                    ListTile(title: Text("About Us")),
                    ListTile(title: Text("Help")),
                    ListTile(title: Text("Settings")),
                    GestureDetector(
                        onTap: () {
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
                                        setState(() async {
                                          signOut();
                                          await Navigator.pushReplacementNamed(
                                              context,
                                              AppRoutes.LoginScreenPage);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: ListTile(title: Text("Log Out"))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGestureDetector(routes, title) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routes);
        },
        child: ListTile(title: Text(title)));
  }

  Future<String> signOut() async {
    await LocalDataSaver.removePreferences();

    LocalDataSaver.saveName('');
    LocalDataSaver.saveEmail('');
    LocalDataSaver.savePhone('');
    LocalDataSaver.savePassword('');

    ProfileDetails.name = (await LocalDataSaver.getName())!;
    ProfileDetails.email = (await LocalDataSaver.getEmail())!;
    ProfileDetails.phone = (await LocalDataSaver.getPhone())!;
    ProfileDetails.password = (await LocalDataSaver.getPassword())!;

    await Fluttertoast.showToast(msg: "Logout Successful",
        toastLength: Toast.LENGTH_SHORT,timeInSecForIosWeb: 2);

    return "Success";
  }
}
