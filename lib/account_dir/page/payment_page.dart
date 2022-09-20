// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppDetails.appName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(height: 8),
            Text("Payments",
                style: const TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
