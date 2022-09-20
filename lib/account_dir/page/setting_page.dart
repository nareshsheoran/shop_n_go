// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
            Text("Settings",
                style: const TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
