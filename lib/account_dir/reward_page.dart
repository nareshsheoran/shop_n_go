// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Image(width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.width/1.5,
            fit: BoxFit.fill,
            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU")),
        ListTile(title: Text("REDEEM"),trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(title: Text("HOW TO EARN"),trailing: Icon(Icons.arrow_forward_ios)),
      ],),),
    );
  }
}
