// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_collection_literals

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/login_dir/model/signUp_response_req.dart';
import 'package:shop_n_go/login_dir/model/sign_up_request.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/localdb.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                          "SignUp",
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
                      controller: nameController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter Full Name',
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
                        return GetUtils.isLengthGreaterOrEqual(value!, 4)
                            ? null
                            : "Please Enter valid User Name";
                      }),
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      controller: emailController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter Email Address',
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
                        return GetUtils.isEmail(value!)
                            ? null
                            : "Please Enter valid Email Address.";
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
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Fluttertoast.showToast(
                        //     msg: "SignUp Successful");
                        signUp();
                        // await Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
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
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR"),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.LoginScreenPage);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already Have An Account?",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: "  Login",
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

  List<SignUpRequest> signUpList = [];

  Future signUp() async {
    String userName = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (userName.isEmpty) {
      // Fluttertoast.showToast(msg: "Please Login First");
      return;
    }

    SignUpRequest request = SignUpRequest(
      userName: userName,
      email: email,
      password: password,
    );

    var map = Map<String, dynamic>();
    map['userName'] = userName;
    map['email'] = email;
    map['password'] = password;

    var requestBody = {
      'username': userName,
      'email': email,
      'password': password,
    };

    Uri myUri = Uri.parse(NetworkUtil.getSignUpUrl);
    // "${NetworkUtil.getSignUpUrl}username=$userName&email=$email&password=$password");

    // Response response = await get(myUri);
    // Response response = await post(myUri, body: requestBody);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      debugPrint("signUp Response Body: ${response.body}");
      debugPrint("signUp Status Code: ${response.statusCode}");

      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      SignUpResponseRequest signUpResponseRequest =
          SignUpResponseRequest.fromJson(map);

      LocalDataSaver.saveID((signUpResponseRequest.user!.id.toString()));
      LocalDataSaver.saveUserName(signUpResponseRequest.user!.username!);
      LocalDataSaver.saveEmail(signUpResponseRequest.user!.email!);
      LocalDataSaver.saveSignUpToken(signUpResponseRequest.token!);

      ProfileDetails.id = (await LocalDataSaver.getID())!;
      ProfileDetails.userName = (await LocalDataSaver.getUserName())!;
      ProfileDetails.email = (await LocalDataSaver.getEmail())!;
      ProfileDetails.signUpToken = (await LocalDataSaver.getSignUpToken())!;

      print("userName: ${ProfileDetails.userName}");
      print("email: ${ProfileDetails.email}");
      print("token: ${ProfileDetails.signUpToken}");

      Fluttertoast.showToast(msg: "SignUp Successful", timeInSecForIosWeb: 2);

      await Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
    } else {
      print('Request failed with status: ${response.statusCode}');
      Fluttertoast.showToast(
          msg: 'Request failed with status: ${response.statusCode}');
    }
  }
}

// {
// "user":
// {"id":9,
// "username":"userName",
// "email":"mcs01@gmail.com"},
//
// "token":"e845f8f849181f34d0a19f6131aa598640922d46066f7018db08ac8f02723313"}

//userName05
//mcs05@gmail.com
//12345
