// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:shop_n_go/shared/constant.dart';

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
    img = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    img.toString(),
                    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU",
                  ),
                ),
                Positioned(
                    top: 6,
                    right: 8,
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spencer Stores",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Spencer Stores",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 446,
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
                                        Text("\$ ${rateList[index]}"),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Constant.primaryColor),
                                            onPressed: () {},
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
                  )
                ],
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
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQjJbw3mOduJzO3hGipOnI-q0JzduC8kfzA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdckMBb1G75l-pI607XL2qItYa0sVc8vG--g&usqp=CAU",
  ];

  List nameList = [
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
    "1",
    "8",
  ];
  List rateList = [
    "55",
    "66",
    "80",
    "31",
    "18",
  ];
}
