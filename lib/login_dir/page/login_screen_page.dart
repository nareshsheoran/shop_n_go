// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/home_page_dir/service/favourite_service.dart';
import 'package:shop_n_go/login_dir/model/login_response_req.dart';
import 'package:shop_n_go/shared/shared_preference_data/fetch_data_SP.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/shared/service/user_profile_service.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Constant.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24)),
                    border: Border.all(color: Constant.primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LogIn",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "To Explore Your Shopping !!!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      controller: userNameController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter username',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Constant.primaryColor))
                        // border: InputBorder.none
                      ),
                      validator: (String? value) {
                        return userNameController.text.trim().isEmpty
                            ? "Please Enter Username"
                            : GetUtils.isLengthGreaterOrEqual(value!, 3)
                            ? null
                            : "Please Enter valid Username";
                      }),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      obscureText: !showPassword,
                      controller: passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => setState(() {
                                showPassword = !showPassword;
                              }),
                              color: Constant.primaryColor),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter password',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Constant.primaryColor))
                        // border: InputBorder.none
                      ),
                      validator: (String? value) {
                        return passwordController.text.trim().isEmpty
                            ? "Please Enter Password"
                            : GetUtils.isLengthGreaterOrEqual(value!, 8)
                            ? null
                            : "Please Enter 8 Digit Password";
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.ForgotPasswordPage);
                        },
                        child: Text("Forgot Password?")),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login(userNameController.text.trim(),
                            passwordController.text.trim());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                        Size(MediaQuery.of(context).size.width, 50),
                        primary: Constant.primaryColor),
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.MobileLoginPage);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                        Size(MediaQuery.of(context).size.width, 50),
                        primary: Constant.primaryColor),
                    child: Text("LogIn with Mobile Number",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, AppRoutes.SignUpPage);
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.SignUpPage);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't Have An Account?",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: "  Sign Up",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        )
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login(userName, password) async {
    var requestBody = {
      'username': userName,
      'password': password,
    };

    Uri myUri = Uri.parse(NetworkUtil.getLoginUrl);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
      );
      LocalDataSaver.saveLoginData(true);
      print(response.body);

      Map<String, dynamic> map =
      jsonDecode(response.body) as Map<String, dynamic>;

      LoginResponseRequest loginResponseRequest =
      LoginResponseRequest.fromJson(map);

      print(loginResponseRequest.token);
      // LocalDataSaver.saveID("01");
      LocalDataSaver.saveUserName(userName);
      LocalDataSaver.savePassword(password);
      LocalDataSaver.saveLoginToken(loginResponseRequest.token!);
      // ProfileDetails.id = (await LocalDataSaver.getID())!;
      ProfileDetails.userName = (await LocalDataSaver.getUserName())!;
      ProfileDetails.password = (await LocalDataSaver.getPassword())!;
      ProfileDetails.loginToken = (await LocalDataSaver.getLoginToken())!;
      try {
        await UserProfileService.getInstance().fetchUserProfileDetails();
      } catch (exception) {
        print("UserProfileService:$exception");
      }
      try {
        await FavouriteService.getInstance().fetchFavouriteDetails();
      } catch (exception) {
        print("FavouriteService:$exception");
      }
      await fetchDataSP();
      await Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
    } else {
      print('Request failed with status: ${response.statusCode}');

      Fluttertoast.showToast(
        // msg: 'Request failed with status: ${response.statusCode}',
          msg: 'Invalid Credential',
          timeInSecForIosWeb: 2);
    }
  }
}
