// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_collection_literals, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/login_dir/model/signUp_response_req.dart';
import 'package:shop_n_go/login_dir/model/sign_up_request.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
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
  bool showPassword = false;
  String upperCase = "1 Uppercase character";
  String totalChar = "At least 8 characters";
  String numericChar = "1 Numeric character";
  String specialChar = "1 Special character";

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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3,
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.sentences,
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
                        return nameController.text
                            .trim()
                            .isEmpty
                            ? "Please Enter UserName"
                            : GetUtils.isLengthGreaterOrEqual(value!, 4)
                            ? null
                            : "Please Enter valid User Name";
                      }),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(

                      controller: emailController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter email',
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
                        return emailController.text
                            .trim()
                            .isEmpty
                            ? "Please Enter Email"
                            : GetUtils.isEmail(value!)
                            ? null
                            : "Please Enter valid Email";
                      }),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      obscureText: !showPassword,
                      controller: passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      // obscuringCharacter: "*",
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () =>
                                  setState(() {
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
                      onChanged: (value) {
                        final upperExp = RegExp('[A-Z]');
                        final numericExp = RegExp('[0-9]');
                        final specialExp = RegExp(r'[!@#$%^&*()+,.?":{}|<>]');
                        setState(() {
                          upperExp.hasMatch(value.trim())
                              ? upperCase = ""
                              : upperCase = "1 Uppercase character";
                          numericExp.hasMatch(value.trim())
                              ? numericChar = ""
                              : numericChar = "1 Numeric characters";
                          specialExp.hasMatch(value.trim())
                              ? specialChar = ""
                              : specialChar = "1 Special character";
                          value.trim().length < 8
                              ? totalChar = "At least 8 character"
                              : totalChar = "";
                        });
                      },
                      validator: (String? value) {
                        return passwordController.text
                            .trim()
                            .isEmpty
                            ? "Please Enter Password"
                            : validatePassword(passwordController.text.trim());

                        // validator: (String? value) {
                        //   return passwordController.text.trim().isEmpty
                        //       ? "Please Enter Password"
                        //       : GetUtils.isLengthGreaterOrEqual(value!, 8)
                        //           ? null
                        //           : "Please Enter 8 Digit Password";
                      }),
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      upperCase == "" ? SizedBox() : buildRow(upperCase),
                      numericChar == "" ? SizedBox() : buildRow(numericChar),
                      specialChar == "" ? SizedBox() : buildRow(specialChar),
                      totalChar == "" ? SizedBox() : buildRow(totalChar),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        (totalChar == '' &&
                            specialChar == '' &&
                            numericChar == '' &&
                            upperCase == '')
                            ? signUp(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        )
                            : null;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                        Size(MediaQuery
                            .of(context)
                            .size
                            .width, 50),
                        primary: Constant.primaryColor),
                    child: Text(
                      "SIGN UP",
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
                    Text("OR", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))
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

  Row buildRow(caseExp) {
    return Row(
      children: [buildText(), Text(caseExp)],
    );
  }

  Widget buildText() {
    return Text(
      "• ",
      style: TextStyle(fontSize: 20),
    );
  }

  List<SignUpRequest> signUpList = [];

  Future signUp(userName, email, password) async {
    var requestBody = {
      'username': userName,
      'email': email,
      'password': password,
    };

    Uri myUri = Uri.parse(NetworkUtil.getSignUpUrl);
    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    if (response.statusCode == 200) {
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

      print("id: ${ProfileDetails.id}");
      print("userName: ${ProfileDetails.userName}");
      print("email: ${ProfileDetails.email}");
      print("token: ${ProfileDetails.signUpToken}");

      Fluttertoast.showToast(msg: "SignUp Successful", timeInSecForIosWeb: 2);

      await Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
    } else if (response.statusCode == 400) {
      // Fluttertoast.showToast(
      //     msg: 'Request failed with status: ${response.statusCode}');
      nameController.text = '';
      emailController.text = '';
      passwordController.text = '';
      Fluttertoast.showToast(msg: 'User already exists.');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  String? validatePassword(String value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.length < 8) {
      return 'Password must be 8 digit';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*()_+-={}[]|;:<>?/';
    Random _rnd = Random();
    var newOid = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return newOid;
  }
}
