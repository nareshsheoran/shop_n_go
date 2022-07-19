// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/stores_dir/page/stores_details.dart';

class StoreSearchPage extends StatefulWidget {
  const StoreSearchPage({Key? key}) : super(key: key);

  @override
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  TextEditingController searchController = TextEditingController();


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
                    "Store Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.directions),
                  SizedBox(width: 8),
                  Expanded(child: Text("8 KMS")),
                  Icon(Icons.card_travel),
                  SizedBox(width: 8),
                  Text("20 Items"),
                  SizedBox(width: 16),
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
                itemCount: itemData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                height: ImageDimension.imageHeight,
                                width: ImageDimension.imageWidth,
                                fit: BoxFit.fill,
                                image: itemData[index].image),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(itemData[index].name,
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$${itemData[index].price}",
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(50, 30),
                                          primary: Constant.primaryColor),
                                      onPressed: () {},
                                      child: Text("ADD +"))
                                ],
                              )
                            ],
                          )
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
    );
  }
}

