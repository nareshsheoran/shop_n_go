// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_n_go/home_page_dir/model_req/all_product_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import '../model_req/all_product_req.dart';
import 'package:http/http.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  TextEditingController searchController = TextEditingController();

  late int selectedIndex;
  final List<bool> _selected = List.generate(50, (i) => false);
  bool isLoading = false;
  List<AllProductData> dataAllProdList = [];

  Future<void> fetchAllProduct() async {
    setState(() {
      isLoading = true;
    });
    Uri myUri = Uri.parse(NetworkUtil.getAllProductUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      debugPrint("fetchAllProduct Response Body: ${response.body}");
      debugPrint("fetchAllProduct Status Code: ${response.statusCode}");

      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AllProductRequest allProductRequest =
          AllProductRequest.fromJson(jsonResponse);
      List<AllProductData> list = allProductRequest.data!;
      dataAllProdList.addAll(list);
      dataAllProdList = list;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchAllProduct();
    super.initState();
  }

  List imageList = [
    Images.vegetablesImg,
    Images.chillyImg,
    Images.tomatoImg,
    Images.ladiesFingerImg,
    Images.onionImg,
    Images.potatoImg,
    Images.radisImg,
    Images.fruitsImg,
    Images.mangoImg,
    Images.bananaImg,
    Images.grapesImg,
    Images.nutsImg,
    Images.munchesImg,
    Images.hippoNutsImg,
    Images.milkImg,
    Images.softDrinksImg,
    Images.oreoImg,
    Images.biscuitsImg,
    Images.iceCreamImg,
    Images.oilImg,
    Images.soapImg,
    Images.lifeBoyImg,
  ];

  List nameList = [
    "Vegetables",
    "Chilly",
    "Tomato",
    "Ladies Finger",
    "Onion",
    "Potato",
    "Radis",
    "Fruits",
    "Mango",
    "Banana",
    "Grapes",
    "Nuts",
    "Munchies",
    "Happilo Nuts",
    "Milk",
    "Soft Drinks",
    "Oreo",
    "Biscuits",
    "Ice Cream",
    "Oil",
    "Soaps",
    "Life Boy",
  ];
  List rateList = [
    "49",
    "65",
    "49",
    "65",
    "49",
    "49",
    "65",
    "65",
    "49",
    "65",
    "65",
    "65",
    "49",
    "49",
    "65",
    "49",
    "65",
    "49",
    "65",
    "49",
    "65",
    "49",
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
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:
                          Icon(Icons.arrow_back_rounded, color: Colors.black)),
                  SizedBox(width: 8),
                  Text(
                    "All Product",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            (isLoading)
                ? SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: dataAllProdList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                        ),
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, AppRoutes.CategoryNamePage,arguments: nameList[index]);
                            },
                            child: Container(
                              width: 110,
                              height: 140,
                              child: Stack(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Image(
                                                width:
                                                    ImageDimension.imageWidth,
                                                height:
                                                    ImageDimension.imageHeight,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(Images
                                                        .baseUrl +
                                                    dataAllProdList[index]
                                                        .itemImages!)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              dataAllProdList[index].itemName!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "\$${dataAllProdList[index].offerPrice?.toStringAsFixed(0)}",
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
                                              // isFavourite = true;
                                              _selected[index] =
                                                  !_selected[index];
                                            });
                                          },
                                          child: (_selected[index])
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.black,
                                                )))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
