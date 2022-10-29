import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

import '../shared_preference_data/localdb.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String verificationID = '';
int? resendTokens ;

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