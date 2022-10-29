// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/mobile_otp_auth.dart';

import '../../shared/shared_preference_data/localdb.dart';
import '../../shared/auth/routes.dart';

class ConfirmOtpPage extends StatefulWidget {
  const ConfirmOtpPage({Key? key}) : super(key: key);

  @override
  State<ConfirmOtpPage> createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController otpController = TextEditingController();

  // Future otpNoVerify() async {
    // verifyOTP(otpController.text.trim().toString(), context);
    // await Navigator.pushReplacementNamed(context, AppRoutes.WelcomeAboardPage);
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = '';
  int? resendTokens;
  bool isLoading = false;

  Future fetchingOTP(controller) async {
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
            } else {
              print("FirebaseAuthException code: $e");
              Fluttertoast.showToast(msg: "FirebaseAuthException code: $e");
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
            otpController.clear();
            otpController.text = '';
            Fluttertoast.showToast(
                msg:
                    "OTP has been sent to your mobile number +91${ProfileDetails.resendPhone}");
            // await Navigator.pushReplacementNamed(
            //     context, AppRoutes.ConfirmOtpPage);
            // Navigator.canPop(context);
            Navigator.pop(context);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationID = verificationId;
          });
      setState(() {
        isLoading = false;
      });

      // await Navigator.pushNamed(context, AppRoutes.VerifyPage);
    } on FirebaseAuthException catch (e) {
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
                          "CONFIRM OTP",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "OTP Sent to your mobile number",
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
                      controller: otpController,
                      maxLength: 6,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: "",
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
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constant.primaryColor))
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
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // otpNoVerify();
                        verifyOTP(otpController.text.trim().toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        primary: Constant.primaryColor),
                    child: Text("CONFIRM OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    print("Resend: ${ProfileDetails.resendPhone}");
                    // fetchOTP("+91${ProfileDetails.resendPhone}", context);
                    fetchingOTP("+91${ProfileDetails.resendPhone}");
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
                  },
                  child: Text("Resend OTP",
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

  Future<void> verifyOTP(controller) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: controller.toString());
    print("verificationId: $verificationID");
    // _auth.signInWithCredential(phoneAuthCredential);
    await signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  Future signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException:$e");
    }
  }
}
