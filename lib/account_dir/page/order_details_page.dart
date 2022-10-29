// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/model/master_order_details_res.dart';
import 'package:shop_n_go/account_dir/model/master_order_res.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/page/screen_arguments.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool isLoading = false;

  List<MasterOrderDetailsData> productDetailsDataList = [];

  Future fetchMasterOrderDetails() async {
    setState(() {
      isLoading = true;
    });

    Uri myUri = Uri.parse(
        // "${NetworkUtil.fetchMasterOrderUrl}/${ProfileDetails.id}/V001");
        "${NetworkUtil.fetchMasterOrderDetailsUrl}/${ProfileDetails.id}/${masterOrderResData?.mainOrderId}/${masterOrderResData?.storeId!}");
    Response response = await get(myUri);
    print(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      MasterOrderDetailsRes masterOrderDetailsRes =
          MasterOrderDetailsRes.fromJson(jsonResponse);
      if (masterOrderDetailsRes.success == false) {
      } else {
        productDetailsDataList.clear();
        List<MasterOrderDetailsData> list = masterOrderDetailsRes.data!;
        productDetailsDataList.addAll(list);
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      isLoading = false;
    }
  }

  MasterOrderResData? masterOrderResData;

  @override
  Widget build(BuildContext context) {
    if (masterOrderResData == null) {
      masterOrderResData =
          ModalRoute.of(context)?.settings.arguments as MasterOrderResData?;
      if (masterOrderResData != null) {
        fetchMasterOrderDetails();
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: isLoading
          ? Center(child: CProgressIndicator.circularProgressIndicator)
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Order ID: ${productDetailsDataList.first.mainOrderId}",
                  style: TextStyle(fontSize: 18,color: Constant.primaryColor,fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: productDetailsDataList.length,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = productDetailsDataList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.CategoriesDetailsPage,
                                  arguments: ScreenArguments(
                                      Images.baseUrl + item.productImage!,
                                      item.productTitle!.substring(8),
                                      "Description",
                                      item.itemCode.toString()));
                            },
                            child: Card(
                              shadowColor: CardDimension.shadowColor,
                              elevation: CardDimension.elevation,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "${item.indivisualOrderId}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image(
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(Images.baseUrl +
                                              item.productImage!)
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
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                      child: Text(
                                                          "Title: ${item.productTitle!.substring(8)}")),
                                                  Text(
                                                      "Price: ${item.itemPrice!.toStringAsFixed(0)}")
                                                ],
                                              ),
                                              SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                      child: Text(
                                                          "Item Code: ${item.itemCode!.toString()}")),
                                                  Text(
                                                      "Store ID: ${item.storeId}")
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
                      }),
                ),
            ],
          ),
    );
  }
}
