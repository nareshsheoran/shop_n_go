// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/mobile_otp_auth.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({Key? key}) : super(key: key);

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();

  Future fetchOTP(controller) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: controller,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            LocalDataSaver.savePhone(controller);
            ProfileDetails.phone = (await LocalDataSaver.getPhone())!;
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == "invalid-phone-number") {
              print("Invalid phone no:$controller");
              Fluttertoast.showToast(msg: "Invalid phone no:$controller");
            } else {
              print("FirebaseAuthException code: $e");
              // Fluttertoast.showToast(msg: "FirebaseAuthException code: $e");
              Fluttertoast.showToast(msg: "$e");
            }
            setState(() {
              isLoading = false;
            });
          },
          codeSent: (String verificationId, int? resendToken) async {
            verificationID = verificationId;
            resendTokens = resendToken;
            print("resendTokens:$resendTokens");
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg:
                    "OTP has been sent to your mobile number +91${ProfileDetails.resendPhone}");
            Navigator.pop(context);

            await Navigator.pushNamed(context, AppRoutes.ConfirmOtpPage);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print("FirebaseAuthException: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
                          "JUST 10 DIGITS!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "To Get Started !!!",
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
                       EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                      controller: phoneController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Mobile Number',
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
                        return phoneController.text.trim().isEmpty
                            ? "Please Enter Mobile Number"
                            : GetUtils.isLengthEqualTo(value!, 10)
                                ? null
                                : "Please Enter Valid Mobile Number";
                      }),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        LocalDataSaver.saveResendPhone(
                            phoneController.text.toString());
                        ProfileDetails.resendPhone =
                            (await LocalDataSaver.getResendPhone())!;
                        fetchOTP(
                            "+91${phoneController.text.trim().toString()}");
                        isLoading
                            ? showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Center(
                                            child: Column(
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 12),
                                            Text("Pleas wait..."),
                                          ],
                                        ))),
                                  );
                                })
                            : isLoading == false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        primary: Constant.primaryColor),
                    child: Text("CONTINUE WITH OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.LoginScreenPage);
                  },
                  child: Text("Use Email-ID",
                      style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
