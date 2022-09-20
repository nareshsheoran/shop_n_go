// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class CancelRefundPage extends StatefulWidget {
  const CancelRefundPage({Key? key}) : super(key: key);

  @override
  State<CancelRefundPage> createState() => _CancelRefundPageState();
}

class _CancelRefundPageState extends State<CancelRefundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel & Refund Policy"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppDetails.appName,
                style:  TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(height: 8),
            Text("Cancel & Refund Policy",
                style:  TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
