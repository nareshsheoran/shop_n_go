import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

import 'localdb.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String verificationID = '';
int? resendTokens ;
Future fetchOTP(controller,context) async {
  try {
    await _auth.verifyPhoneNumber(
        phoneNumber: controller,
        timeout: const Duration(seconds: 60),

        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);

          LocalDataSaver.savePhone(controller);
          ProfileDetails.phone = (await LocalDataSaver.getPhone())!;

          // await Navigator.pushNamed(context, AppRoutes.VerifyPage);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == "invalid-phone-number") {
            print("Invalid phone no:$controller");
            print("Invalid phone no");

          } else{
            print("FirebaseAuthException code: $e");
            Fluttertoast.showToast(msg: "FirebaseAuthException code: $e");

          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificationID = verificationId;
          resendTokens=resendToken;
          print("resendTokens:$resendTokens");
          Fluttertoast.showToast(msg: "Code has been sent to your mobile number +91${ProfileDetails.resendPhone}");
          await Navigator.pushNamed(context, AppRoutes.ConfirmOtpPage);


        },
        codeAutoRetrievalTimeout: (String verificationId) {});


    // await Navigator.pushNamed(context, AppRoutes.VerifyPage);
  } on FirebaseAuthException catch (e) {
    print("FirebaseAuthException: $e");
  }
}

Future<void> verifyOTP(controller, context) async {
  PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationID, smsCode: controller.toString());
  print("verificationId: $verificationID");
  // _auth.signInWithCredential(phoneAuthCredential);
  await signInWithPhoneAuthCredential(phoneAuthCredential, context);
}

Future signInWithPhoneAuthCredential(
    PhoneAuthCredential phoneAuthCredential, context) async {
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