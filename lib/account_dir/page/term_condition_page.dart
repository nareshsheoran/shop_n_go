// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class TermConditionPage extends StatefulWidget {
  const TermConditionPage({Key? key}) : super(key: key);

  @override
  State<TermConditionPage> createState() => _TermConditionPageState();
}

class _TermConditionPageState extends State<TermConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
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
            Text("Terms & Conditions",
                style: const TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
