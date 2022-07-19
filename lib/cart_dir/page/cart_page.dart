// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Object? number = 0;

  @override
  Widget build(BuildContext context) {
    number == 0
        ? number = ModalRoute.of(context)?.settings.arguments
        : number == imgList;
    return Scaffold(
      body: SafeArea(
        child:
        // (number == 0 || number == null)?
        //     Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8),
        //       child: Row(
        //         children: [
        //           GestureDetector(
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //               child: Icon(Icons.arrow_back_rounded,
        //                   color: Colors.black)),
        //           SizedBox(width: 8),
        //           Text(
        //             "Cart",
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold, fontSize: 18),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(height: MediaQuery.of(context).size.width / 1.5),
        //     Text("Please add product to your Cart first!"),
        //     ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //             minimumSize: Size(50, 30),
        //             primary: Constant.primaryColor),
        //         onPressed: () {
        //           Navigator.pushNamed(context, AppRoutes.ShopInPage);
        //         },
        //         child: Text("Add to Cart")),
        //   ],
        // ):
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "CART",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:(number ==0 ||number==null) ? imgList.length : int.parse(number!.toString()),
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRoutes.StoresDetailsPage,
                      //     arguments: nameList[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameList[index],
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                            Expanded(
                                                child: Text(
                                                    "${distanceList[index]} KMS")),
                                            Icon(
                                              Icons.card_travel,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),(number == 0 || number == null)
                                                ? Text("1 Item")
                                                : number == 1
                                                ? Text("$number Item")
                                                : Text("$number Items"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: IconDimension.iconSize,
                                            ),
                                            SizedBox(width: 8),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    // minimumSize: Size(50, 30),
                                                    primary:
                                                        Constant.primaryColor),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .CartDetailsPage,arguments: number);
                                                },
                                                child:(number == 0 || number == null)
                                                    ? Text("VIEW ITEM")
                                                    : number == 1
                                                    ? Text("VIEW ITEM")
                                                    : Text("VIEW ITEMS"), )
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
    "Spencer Stores 01",
    "Spencer Stores 02",
    "Spencer Stores 03",
    "Spencer Stores 04",
    "Spencer Stores 05",
    "Spencer Stores 06",
    "Spencer Stores 07",
    "Spencer Stores 08",
  ];

  List distanceList = [
    "5",
    "6",
    "10",
    "1",
    "6",
    "10",
    "1",
    "8",
  ];
  List itemList = [
    "55",
    "66",
    "80",
    "31",
    "66",
    "80",
    "31",
    "18",
  ];
}
