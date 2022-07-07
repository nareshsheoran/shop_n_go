// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isFavourite = false;
  late int selectedRecommendedIndex;
  final List<bool> _selectedRecommended = List.generate(20, (i) => false);
  late int selectedProductIndex;
  final List<bool> _selectedProduct = List.generate(20, (i) => false);
  int tabIndex = 1;

  Widget? tabWidget() {
    if (tabIndex == 1) {
      return recommendedWidget();
    } else {
      return recommendedWidget();
    }
  }

  List tabList = ["All Categories", "Best Sellers", "New Products"];

  int categoryTabIndex = 1;

  Widget? categoryTabWidget() {
    if (categoryTabIndex == 1) {
      return categoryWidget();
    } else if (categoryTabIndex == 2) {
      return categoryWidget();
    } else {
      return categoryProductWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Hi, Users!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    Icon(
                      Icons.favorite_border_outlined,
                      size: IconDimension.iconSize,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.info_outline,
                      size: IconDimension.iconSize,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 2, 40),
                        primary: Constant.primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.MapSearchPage);
                    },
                    child: Text("In House Shopping")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: CardDimension.elevation,
                  shadowColor: CardDimension.shadowColor,
                  child: Image(
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBk1gqnnfaW-yDDr6amkB59pVv91M0aI1JQ&usqp=CAU"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          tabIndex = 1;
                          setState(() {
                            print(tabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            tabIndex == 1
                                ? buildTextStyle(
                                    "Recommended", Constant.primaryColor)
                                : buildTextStyle(
                                    "Recommended",
                                    Colors.black,
                                  ),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: tabIndex == 1
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 3))
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          tabIndex = 2;
                          setState(() {
                            print(tabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            tabIndex == 2
                                ? buildTextStyle(
                                    "Favorite",
                                    Constant.primaryColor,
                                  )
                                : buildTextStyle("Favorite", Colors.black),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: tabIndex == 2
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 3))
                          ],
                        )),
                  ],
                ),
              ),
              tabWidget()!,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          categoryTabIndex = 1;
                          setState(() {
                            print(categoryTabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            categoryTabIndex == 1
                                ? buildTextStyle(
                                    tabList[0], Constant.primaryColor)
                                : buildTextStyle(
                                    tabList[0],
                                    Colors.black,
                                  ),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: categoryTabIndex == 1
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 3))
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          categoryTabIndex = 2;
                          setState(() {
                            print(categoryTabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            categoryTabIndex == 2
                                ? buildTextStyle(
                                    tabList[1],
                                    Constant.primaryColor,
                                  )
                                : buildTextStyle(tabList[1], Colors.black),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: categoryTabIndex == 2
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 4))
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          categoryTabIndex = 3;
                          setState(() {
                            print(categoryTabIndex);
                          });
                        },
                        child: Column(
                          children: [
                            categoryTabIndex == 3
                                ? buildTextStyle(
                                    tabList[2],
                                    Constant.primaryColor,
                                  )
                                : buildTextStyle(tabList[2], Colors.black),
                            SizedBox(height: 6),
                            Container(
                                height: 2,
                                color: categoryTabIndex == 3
                                    ? Constant.primaryColor
                                    : Colors.white,
                                width: (MediaQuery.of(context).size.width / 4))
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (categoryTabIndex == 1) {
                            Navigator.pushNamed(
                                context, AppRoutes.AllCategorySearch,
                                arguments: tabList[0]);
                          } else if (categoryTabIndex == 2) {
                            Navigator.pushNamed(
                                context, AppRoutes.AllCategorySearch,
                                arguments: tabList[1]);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.AllProductPage,
                                // arguments: tabList[categoryTabIndex - 1]);
                                arguments: tabList[2]);
                          }
                        },
                        child: Text("View All",
                            style: TextStyle(
                                color: Constant.primaryColor,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              categoryTabWidget()!,
            ],
          ),
        ),
      ),
    );
  }

  List imageList = [
    Images.potatoImg,
    Images.tomatoImg,
    Images.onionImg,
    Images.chillyImg,
    Images.ladiesFingerImg,
    Images.radisImg,
  ];

  List nameList = [
    "Potato",
    "Tomato",
    "Onion",
    "Chilly",
    "Ladies Finger",
    "Radis",
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

  Widget buildTextStyle(title, color) {
    return Text(title,
        style:
            TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w600));
  }

  Widget recommendedWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: imageList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: 115,
                height: 150,
                child: Stack(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image(
                                  width: ImageDimension.imageWidth,
                                  height: ImageDimension.imageHeight,
                                  // fit: BoxFit.fill,
                                  fit: BoxFit.scaleDown,
                                  image: NetworkImage(imageList[index])),
                            ),
                            Text(
                              nameList[index],
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${rateList[index]}",
                                    textAlign: TextAlign.left,
                                  ),
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
                                isFavourite = true;
                                _selectedRecommended[index] =
                                    !_selectedRecommended[index];
                              });
                            },
                            child: (_selectedRecommended[index])
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
              );
            }),
      ),
    );
  }

  Widget categoryWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 140,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListView.builder(
            itemCount: imageList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 110,
                height: 150,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image(
                              width: ImageDimension.imageWidth,
                              height: ImageDimension.imageHeight,
                              fit: BoxFit.fill,
                              image: NetworkImage(imageList[index])),
                        ),
                        Text(
                          nameList[index],
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget categoryProductWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
            itemCount: imageList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 110,
                height: 150,
                child: Stack(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image(
                                  width: ImageDimension.imageWidth,
                                  height: ImageDimension.imageHeight,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imageList[index])),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    nameList[index],
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text("${weightList[index]}kg",
                                    style: TextStyle(fontSize: 12)),
                                SizedBox(width: 8),
                              ],
                            ),
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
                                isFavourite = true;
                                _selectedProduct[index] =
                                    !_selectedProduct[index];
                              });
                            },
                            child: (_selectedProduct[index])
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
              );
            }),
      ),
    );
  }
}
