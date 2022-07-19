// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/login_dir/model/login_response_req.dart';
import 'package:shop_n_go/shared/auth/localdb.dart';
import 'package:shop_n_go/login_dir/model/login_request.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController =
      TextEditingController(text: "Naresh014");
  TextEditingController passwordController =
      TextEditingController(text: "Naresh@014");

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
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter Username',
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
                        return GetUtils.isLengthGreaterOrEqual(value!, 3)
                            ? null
                            : "Please Enter valid Username";
                      }),
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      controller: passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter Your Password',
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
                        return GetUtils.isLengthGreaterOrEqual(value!, 5)
                            ? null
                            : "Please Enter 5 Digit Password";
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password?"),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Fluttertoast.showToast(
                        //     msg: "Login Successful",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     timeInSecForIosWeb: 2);

                        login();

                        // await Navigator.pushReplacementNamed(
                        //     context, AppRoutes.DashboardPage);
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Constant.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Constant.primaryColor),
                        ),
                        child: Center(
                            child: Text(
                          "LOG IN",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, AppRoutes.MobileLoginPage);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Constant.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Constant.primaryColor),
                        ),
                        child: Center(
                            child: Text(
                          "LogIn with Mobile Number",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.SignUpPage);
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

  Future login() async {
    String userName = userNameController.text;
    String password = passwordController.text;

    if (userName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Username", timeInSecForIosWeb: 2);
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Password", timeInSecForIosWeb: 2);
      return;
    }

    // LoginRequest request = LoginRequest(
    //   userName: userName,
    //   password: password,
    // );

    // var map = Map<String, dynamic>();
    // map['userName'] = userName;
    // map['password'] = password;

    var requestBody = {
      'username': userName,
      'password': password,
    };

    Uri myUri = Uri.parse(NetworkUtil.getLoginUrl);
    // "${NetworkUtil.getSignUpUrl}username=$userName&email=$email&password=$password");

    // Response response = await get(myUri);
    // Response response = await post(myUri, body: requestBody);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      debugPrint("login Response Body: ${response.body}");
      debugPrint("login Status Code: ${response.statusCode}");

      Fluttertoast.showToast(msg: "Login Successful", timeInSecForIosWeb: 2);

      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      LoginResponseRequest loginResponseRequest =
          LoginResponseRequest.fromJson(map);

      print(loginResponseRequest.token);

      LocalDataSaver.saveUserName(userName);
      LocalDataSaver.savePassword(password);
      LocalDataSaver.saveLoginToken(loginResponseRequest.token!);

      ProfileDetails.userName = (await LocalDataSaver.getUserName())!;
      ProfileDetails.password = (await LocalDataSaver.getPassword())!;
      ProfileDetails.loginToken = (await LocalDataSaver.getLoginToken())!;

      await Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
    } else {
      print('Request failed with status: ${response.statusCode}');
      Fluttertoast.showToast(
          msg: 'Request failed with status: ${response.statusCode}', timeInSecForIosWeb: 2);

      // Fluttertoast.showToast(msg: "Please SignUp First", timeInSecForIosWeb: 2);
      // await Navigator.pushNamed(context, AppRoutes.SignUpPage);
    }
  }
}
