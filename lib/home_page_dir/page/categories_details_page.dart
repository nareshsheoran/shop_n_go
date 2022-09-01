// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req.dart';
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';

class CategoriesDetailsPage extends StatefulWidget {
  const CategoriesDetailsPage({Key? key}) : super(key: key);

  @override
  State<CategoriesDetailsPage> createState() => _CategoriesDetailsPageState();
}

class _CategoriesDetailsPageState extends State<CategoriesDetailsPage> {
  Object? img = '';
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    ScreenArguments arguments =
        ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 4,
                        vertical: 40),
                    child: Image(
                      height: 150,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        arguments.img.toString(),
                        // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU",
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 12,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavourite = true;
                            // _selected[index] = !_selected[index];
                          });
                        },
                        child: isFavourite == true
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.black,
                              )))
              ],
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    arguments.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    arguments.description,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListView.builder(
                  itemCount: rateList.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nameList[index]),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Image(
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imgList[index]),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.directions,
                                            size: IconDimension.iconSize,
                                          ),
                                          SizedBox(width: 8),
                                          Text("${distanceList[index]} KMS")
                                        ],
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: IconDimension.iconSize,
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        "${AppDetails.currencySign} ${rateList[index]}"),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Constant.primaryColor),
                                        onPressed: () {
                                          proAddedIntoCart(index, arguments);
                                        },
                                        child: Text("ADD +"))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List imgList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6-DjY67mzulVMRq80hvI-mq8dImIOgKt5Cw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREArY26l80lxfHNDyJ_kcZZWVav8i4kPadgA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQjJbw3mOduJzO3hGipOnI-q0JzduC8kfzA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdckMBb1G75l-pI607XL2qItYa0sVc8vG--g&usqp=CAU",
  ];

  List nameList = [
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
  ];

  List distanceList = [
    "5",
    "6",
    "10",
    "10",
    "1",
    "8",
  ];
  List rateList = [
    "55",
    "66",
    "80",
    "31",
    "31",
    "18",
  ];

  Future proAddedIntoCart(index, ScreenArguments arguments) async {
    String user = ProfileDetails.id!;

    String prodICart = arguments.code;
    print("user: $user===prodICart:$prodICart");

    var requestBody = {
      'user': user,
      'added_pro_into_cart': prodICart,
    };

    Uri myUri = Uri.parse(NetworkUtil.getProductIntoCardUrl);

    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      debugPrint("proAddedIntoCart Response Body: ${response.body}");
      debugPrint("proAddedIntoCart Status Code: ${response.statusCode}");

      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      ProdAddedReqRes prodAddedReqRes = ProdAddedReqRes.fromJson(map);

      print("message: ${prodAddedReqRes.message}");
      if (prodAddedReqRes.message == "data Saved SuccesFully") {
        setState(() {
          imgList.removeAt(index);
          nameList.removeAt(index);
          rateList.removeAt(index);
          distanceList.removeAt(index);
        });
      }

      Fluttertoast.showToast(msg: "Product Added", timeInSecForIosWeb: 2);

      // await Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenPage);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
