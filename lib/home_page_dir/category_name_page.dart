// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/routes.dart';

import '../shared/constant.dart';

class CategoryNamePage extends StatefulWidget {
  const CategoryNamePage({Key? key}) : super(key: key);

  @override
  State<CategoryNamePage> createState() => _CategoryNamePageState();
}

class _CategoryNamePageState extends State<CategoryNamePage> {
  TextEditingController searchController = TextEditingController();
  List imageList = [
    Images.chillyImg,
    Images.ladiesFingerImg,
    Images.onionImg,
    Images.potatoImg,
    Images.radisImg,
    Images.tomatoImg,
  ];

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

  bool isFavourite = false;
  late int selectedIndex;
  final List<bool> _selected = List.generate(20, (i) => false);
  Object? name = '';

  @override
  Widget build(BuildContext context) {
    name = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_rounded,
                              color: Colors.black)),
                      SizedBox(width: 8),
                      Text(
                        name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                GridView.builder(
                  itemCount: imageList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.CategoriesDetailsPage,
                              arguments: imageList[index]);
                        },
                        child: categoryWidget(index));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(int index) {
    return SizedBox(
      width: 110,
      height: 140,
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(5),
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
                  Padding(
                    padding: const EdgeInsets.all(5),
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
                      _selected[index] = !_selected[index];
                    });
                  },
                  child: (_selected[index])
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
  }
}
