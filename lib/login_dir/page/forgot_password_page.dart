// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/login_dir/model/forgot_password_res_req.dart';
import 'package:shop_n_go/login_dir/model/otp_submit_res_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:expandable/expandable.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isShow = false;
  String textS = "Send OTP";

  Future forgotPassword(storeUserId, emailId) async {
    var requestBody = {
      'store_userid': storeUserId,
      'email_id': emailId,
    };

    Uri myUri = Uri.parse(NetworkUtil.getStoreMobileLoginUrl);
    //
    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      ForgotPasswordResReq forgotPasswordResReq =
          ForgotPasswordResReq.fromJson(jsonResponse);
      String? otpResponse = forgotPasswordResReq.message?.substring(18, 24);
      print("otpResponse::$otpResponse");
      print("otpResponse::$otpResponse");
      LocalDataSaver.saveOTP(otpResponse!);
      ProfileDetails.otp = await LocalDataSaver.getOTP();
      Fluttertoast.showToast(msg: "Otp sent to your Email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        "Forgot Password",
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
              Form(
                key: _formKeyEmail,
                child: Padding(
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
                      onChanged: (String? value) {
                        setState(() {
                          value == "" ? emailController.text = "" : null;
                        });
                      },
                      validator: (String? value) {
                        return emailController.text.trim().isEmpty
                            ? "Please Enter Email"
                            : GetUtils.isEmail(value!)
                            ? null
                            : "Please Enter valid Email";
                      }),
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // buildExpandablePanel();
                      if (_formKeyEmail.currentState!.validate()) {
                        print(emailController.text);
                        forgotPassword("V002", emailController.text.trim());
                        setState(() {
                          isShow = true;
                          print(isShow);
                          buildThen();
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Constant.primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: Center(child: Text("Send OTP")),
                        child: Center(child: Text(textS)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              // emailController.text == ""

              isShow == false
                  ? SizedBox()
                  : Form(
                      key: _formKeyOTP,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: TextFormField(
                            controller: otpController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter OTP',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Constant.primaryColor)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constant.primaryColor))
                                // border: InputBorder.none
                                ),
                            validator: (String? value) {
                              return otpController.text.trim().isEmpty
                                  ? "Please Enter OTP"
                                  : GetUtils.isLengthGreaterOrEqual(value!, 6)
                                  ? null
                                  : "Please Enter Valid OTP";
                            }),
                      ),
                    ),
              // emailController.text == ""

              otpController.text == ''
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // buildExpandablePanel();
                            if (_formKeyOTP.currentState!.validate()) {
                              print(otpController.text);
                              otpSubmit(otpController.text.trim());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Constant.primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("Submit OTP")),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future buildThen() {
    return Future.delayed(Duration(seconds: 30)).then((value) {
      setState(() {
        textS = "Resend OTP";
      });
    });
  }

  Future otpSubmit(otp) async {
    String enterOtp = otp;
    var requestBody = {
      'Enter_OTP': enterOtp,
    };

    // Uri myUri = Uri.parse(NetworkUtil.getStoreVerifyOtpUrl);
    Uri myUri = Uri.parse(
        "http://apiforshopandgo.pythonanywhere.com/shopngo-api/store-verify-otp");
    //
    // http.Response response = await http.post(
    //   myUri,
    //   body: requestBody,
    // );
    Response response = await post(myUri, body: requestBody);

    print("Request failed error: ${response.statusCode}");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      OtpSubmitResReq otpSubmitResReq = OtpSubmitResReq.fromJson(jsonResponse);
      if (otpSubmitResReq.message == "Verified") {
        Fluttertoast.showToast(msg: "OTP Verified successful");
        Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
      } else if (otpSubmitResReq.message == "Invalid OTP") {
        Fluttertoast.showToast(msg: "Invalid OTP");
        setState(() {
          otpController.text = '';
        });
      } else {
        Fluttertoast.showToast(
            msg: "Request failed error: ${response.statusCode}");
      }
    } else {
      setState(() {
        otpController.text = '';
      });
      Fluttertoast.showToast(
          msg: "Request failed error: ${response.statusCode}");
    }
  }
}
