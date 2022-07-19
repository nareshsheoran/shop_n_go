// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class StoresDetailsPage extends StatefulWidget {
  const StoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<StoresDetailsPage> createState() => _StoresDetailsPageState();
}

class _StoresDetailsPageState extends State<StoresDetailsPage> {
  Object? image = '';

  late int selectedIndex;
  final List<bool> _selected = List.generate(20, (i) => false);

  List nameList = [
    "Chilly",
    "Ladies Finger",
    "Onion",
    "Potato",
    "Radius",
    "Tomato",
  ];

  List rateList = [
    "49",
    "65",
    "49",
    "65",
    "49",
    "65",
  ];

  List weightList = [
    "9",
    "6",
    "4",
    "3",
    "1",
    "5",
  ];

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)?.settings.arguments!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image(
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                image: NetworkImage(
                  image.toString(),
                )),
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spencer Stores",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.directions),
                        SizedBox(width: 8),
                        Expanded(child: Text("8 KMS")),
                        Icon(Icons.card_travel),
                        SizedBox(width: 8),
                        Text("20 Items")
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.directions_bike_sharp),
                        SizedBox(width: 8),
                        Text("HOME DELIVERY AVAILABLE")
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee_rounded),
                        SizedBox(width: 8),
                        Text("MINIMUM ORDER \$10")
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star),
                        SizedBox(width: 8),
                        Text("REVIEW")
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Products Available",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.StoreSearchPage);
                            },
                            child: Text("View All",
                                style: TextStyle(
                                    color: Constant.primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: nameList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                height: 160,
                                width: 125,
                                child: Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Image(
                                          width: ImageDimension.imageWidth,
                                          height: ImageDimension.imageHeight,
                                          fit: BoxFit.fill,
                                          image: itemData[index].image,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                          "${itemData[index].name} ${itemData[index].weight}kg"),
                                      SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("\$${itemData[index].price}"),
                                            counterWidget(index)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 6,
                                  right: 8,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // isFavourite = true;
                                          _selected[index] = !_selected[index];
                                        });
                                      },
                                      child: _selected[index]
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.black,
                                            )))
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget counterWidget(int index) {
    return
        // itemData[index].shouldVisible ?
        //    Center(
        //       child: Container(
        //       height: 30,
        //       width: 70,
        //       decoration: BoxDecoration(
        //           color: Colors.grey[200],
        //           borderRadius: BorderRadius.circular(4),
        //           border: Border.all(color: Colors.white70)),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   if (itemData[index].counter < 1) {
        //                     itemData[index].shouldVisible =
        //                         !itemData[index].shouldVisible;
        //                   } else {
        //                     itemData[index].counter--;
        //                   }
        //                 });
        //               },
        //               child: Icon(
        //                 Icons.remove,
        //                 color: Constant.primaryColor,
        //                 size: 22,
        //               )),
        //           SizedBox(width: 4),
        //           (itemData[index].counter == 0 ||
        //                   itemData[index].counter == null)
        //               ? Text(
        //                   '${itemData[index].counter}',
        //                   style: TextStyle(color: Colors.black),
        //                 )
        //               : Text(
        //                   '${itemData[index].counter}',
        //                   style: const TextStyle(color: Colors.black),
        //                 ),
        //           SizedBox(width: 4),
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   itemData[index].counter++;
        //                 });
        //               },
        //               child: Icon(
        //                 Icons.add,
        //                 color: Constant.primaryColor,
        //                 size: 22,
        //               )),
        //         ],
        //       ),
        //     )):
        Container(
      padding: EdgeInsets.all(5),
      height: 30,
      width: 72,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white70)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
              onTap: () {
                setState(() {
                  // itemData[index].counter--;
                  if (itemData[index].counter < 1) {
                    itemData[index].shouldVisible =
                        !itemData[index].shouldVisible;
                    if (itemData[index].counter == 0) {
                      setState(() {
                        itemData.removeAt(index);
                      });
                    }
                  } else {
                    itemData[index].counter--;
                    if (itemData[index].counter == 0) {
                      setState(() {
                        itemData.removeAt(index);
                      });
                    }
                  }
                });
              },
              child: Center(
                  child: Icon(
                Icons.remove,
                color: Constant.primaryColor,
                size: 22,
              ))),
          SizedBox(width: 4),
          Text(
            '${itemData[index].counter}',
            style: const TextStyle(color: Colors.black),
          ),
          SizedBox(width: 4),
          InkWell(
              onTap: () {
                setState(() {
                  itemData[index].counter++;
                  itemData[index].shouldVisible =
                      !itemData[index].shouldVisible;
                });
              },
              child: Center(
                  child: Icon(
                Icons.add,
                color: Constant.primaryColor,
                size: 22,
              ))),
        ],
      ),
    );
  }
}
