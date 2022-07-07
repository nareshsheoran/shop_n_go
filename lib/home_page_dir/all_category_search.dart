// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';

class AllCategorySearch extends StatefulWidget {
  const AllCategorySearch({Key? key}) : super(key: key);

  @override
  State<AllCategorySearch> createState() => _AllCategorySearchState();
}

class _AllCategorySearchState extends State<AllCategorySearch> {
  TextEditingController searchController = TextEditingController();
  List imageList = [
    Images.vegetablesImg,
    Images.fruitsImg,
    Images.softDrinksImg,
    Images.nutsImg,
    Images.iceCreamImg,
    Images.soapImg,
    Images.oilImg,
    Images.biscuitsImg,
  ];

  List nameList = [
    "Vegetables",
    "Fruits",
    "Soft Drinks",
    "Nuts",
    "Ice Cream",
    "Soaps",
    "Oils",
    "Biscuits",
  ];
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
                              context, AppRoutes.CategoryNamePage,
                              arguments: nameList[index]);
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
      width: 140,
      height: 140,
      child: Card(
        elevation: CardDimension.elevation,
        shadowColor: CardDimension.shadowColor,
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
  }
}
