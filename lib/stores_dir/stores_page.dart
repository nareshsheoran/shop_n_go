// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({Key? key}) : super(key: key);

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  TextEditingController searchController = TextEditingController();

  List imgList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6-DjY67mzulVMRq80hvI-mq8dImIOgKt5Cw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREArY26l80lxfHNDyJ_kcZZWVav8i4kPadgA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdQjJbw3mOduJzO3hGipOnI-q0JzduC8kfzA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdckMBb1G75l-pI607XL2qItYa0sVc8vG--g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJaCYKmaRi3xV2Q-0WhIy6-8OomW7rpc2DFg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6-DjY67mzulVMRq80hvI-mq8dImIOgKt5Cw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiT2KSFH6y04zyIvWox_XKHa7rOZfmv8RPzw&usqp=CAU"
  ];

  List nameList = [
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
    "Spencer Stores",
  ];

  List distanceList = ["5", "6", "10", "1", "6", "10", "1", "8"];
  List orderList = ["5", "6", "10", "1", "8", "10", "1", "8"];
  List itemList = ["55", "66", "80", "31", "66", "80", "31", "18"];
  List startTimeList = [
    "10.00",
    "11.00",
    "12.00",
    "09.00",
    "08.00",
    "07.00",
    "05.00",
    "02.00",
  ];
  List endTimeList = [
    "20.00",
    "21.00",
    "22.00",
    "19.00",
    "18.00",
    "17.00",
    "15.00",
    "22.00",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "STORES",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Constant.primaryColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(32.0)),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: searchController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: imgList.length,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.StoresDetailsPage,
                          arguments: imgList[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                      child: Card(elevation: CardDimension.elevation,
                        shadowColor: CardDimension.shadowColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                    "${nameList[index]} 0${index + 1}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  Icon(
                                    Icons.alarm,
                                    size: IconDimension.iconSize,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      "${startTimeList[index]}-${endTimeList[index]}"),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Image(
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(imgList[index]),
                                  ),
                                  SizedBox(width: 14),
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
                                            Expanded(
                                                child: Text(
                                                    "${distanceList[index]} KMS")),
                                            Icon(
                                              Icons.card_travel,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),
                                            Text("${itemList[index]} Items"),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_cart,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                                child: Text(
                                                    "Min. order \$${orderList[index]}")),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.directions_bike_sharp,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Home Delivery Available")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
