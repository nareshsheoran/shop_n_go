// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';

class ConfirmOtpPage extends StatefulWidget {
  const ConfirmOtpPage({Key? key}) : super(key: key);

  @override
  State<ConfirmOtpPage> createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController otpController = TextEditingController(text: "999999");

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
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constant.primaryColor))
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!, 6)
                            ? null
                            : "Please Enter Valid OTP";
                      }),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        Fluttertoast.showToast(msg: "Login Successful");
                        await Navigator.pushReplacementNamed(
                            context, AppRoutes.DashboardPage);
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
                          "CONFIRM OTP",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacementNamed(
                    //     context, AppRoutes.LoginScreenPage);
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
}
