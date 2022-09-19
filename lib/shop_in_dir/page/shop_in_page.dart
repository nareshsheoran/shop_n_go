// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scan/scan.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/home_page_dir/model_req/product_add_req_res.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:images_picker/images_picker.dart';
import 'package:shop_n_go/shared/service/product_add_cart_service.dart';
import 'package:shop_n_go/shop_in_dir/model/add_into_cart_store_basis_req.dart';
import 'package:shop_n_go/shop_in_dir/model/get_prod_based_on_barCode_req.dart';

class ShopInPage extends StatefulWidget {
  const ShopInPage({Key? key}) : super(key: key);

  @override
  State<ShopInPage> createState() => _ShopInPageState();
}

class _ShopInPageState extends State<ShopInPage> {
  // String _platformVersion = 'Unknown';
  //
  // String qrcode = 'Unknown';
  //
  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }
  //
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   try {
  //     platformVersion = await Scan.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  // @override
  // void initState() {
  //  buildShowModalBottomSheet(context);
  //   super.initState();
  // }

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
// scanQR();
    super.initState();
  }

  String? barCode;

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {

        setState(() {
          _scanBarcode = "Unknown";
        });
      } else {
        fetchScan(barcodeScanRes);
      }
    });
  }

  void fetchScan(String barcodeScanRes) {
    _scanBarcode = barcodeScanRes;
    scannerList.add(barcodeScanRes);
    fetchProdBasedOnBarCode(barcodeScanRes);
  }

  List scannerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getProdBasedOnBarCodeList.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => scanQR(),
                        child: Text('Start QR scan')),
                    Text('Scan result:\n $_scanBarcode',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () => scanQR(), child: Text('Scan QR Code')),
                  Text('Scanned Result: $_scanBarcode\n',
                      style: TextStyle(fontSize: 14)),
                  // SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Total Product Scanned: ${getProdBasedOnBarCodeList.length}",
                            style: TextStyle(fontSize: 20)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(50, 30),
                                primary: Constant.primaryColor),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.CartPage);
                            },
                            child: Text("Cart")),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: ListView.builder(
                      itemCount: getProdBasedOnBarCodeList.length,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        GetProductBasedOnBarCodeReqData item =
                            getProdBasedOnBarCodeList[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.StoresDetailsPage,
                            //     arguments: imgList[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Card(
                              elevation: CardDimension.elevation,
                              shadowColor: CardDimension.shadowColor,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 6, 8, 4),
                                        child: Image(
                                            height:
                                                ImageDimension.imageHeight - 20,
                                            width: ImageDimension.imageWidth,
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                "${Images.baseUrl}${item.itemImages!}")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 2, 8, 4),
                                        child: Text(
                                          item.barcodeSequence!,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(item.itemName!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title:
                                                              Text("Delete?"),
                                                          content: Text(
                                                              "Are you sure to delete?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  'OK'),
                                                              onPressed: () {
                                                                getProdBasedOnBarCodeList
                                                                    .removeAt(
                                                                        index);

                                                                setState(() {
                                                                  scannerList
                                                                      .removeAt(
                                                                          index);
                                                                  itemData
                                                                      .removeAt(
                                                                          index);
                                                                  _scanBarcode =
                                                                      '';
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Icon(Icons.delete,
                                                    color: Colors.red))
                                          ],
                                        ),
                                        // SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${AppDetails.currencySign}${(item.price)?.toStringAsFixed(0)}",
                                                style: TextStyle(fontSize: 18)),
                                            // SizedBox(
                                            //     width: MediaQuery.of(context).size.width /
                                            //         3),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(50, 30),
                                                    primary:
                                                        Constant.primaryColor),
                                                onPressed: () {
                                                  ProductAddCartService()
                                                      .proAddedIntoCart(
                                                          index, item.itemCode);

                                                  setState(() {
                                                    print(
                                                        "ProductAddCartService statusCode:${ProductAddCartService().statusCode}");
                                                    ProductAddCartService()
                                                                .statusCode ==
                                                            200
                                                        ? getProdBasedOnBarCodeList
                                                            .removeAt(index)
                                                        : null;
                                                  });

                                                  // proAddedIntoCart(
                                                  //     index, item.itemCode);
                                                  // fetchAddCartStoreBasis(
                                                  //     index,
                                                  //     item.itemCode,
                                                  //     "V001",
                                                  //     item.vendorMasters
                                                  //         ?.replaceAll(
                                                  //             "v", ""));
                                                },
                                                child: Text("ADD +")),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                ],
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

  bool isLoading = false;
  List<GetProductBasedOnBarCodeReqData> getProdBasedOnBarCodeList = [];
  GetProductBasedOnBarCodeReq? getProductBasedOnBarCodeReq;

  Future fetchProdBasedOnBarCode(barCode) async {
    setState(() {
      isLoading = true;
    });

    var requestBody = {
      'barcode_sequence': barCode,
    };

    Uri myUri = Uri.parse(NetworkUtil.getProdDetailsByBarCodeUrl);
    //
    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      GetProductBasedOnBarCodeReq getProductBasedOnBarCodeRequ =
          GetProductBasedOnBarCodeReq.fromJson(jsonResponse);
      if (getProductBasedOnBarCodeRequ.statusCode == 200) {
        getProductBasedOnBarCodeReq = getProductBasedOnBarCodeRequ;

        getProdBasedOnBarCodeList.add(getProductBasedOnBarCodeReq!.data!);
        getProdBasedOnBarCodeList;
      } else if (getProductBasedOnBarCodeRequ.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "$barCode: ${getProductBasedOnBarCodeRequ.message!}");
        setState(() {
          _scanBarcode = "UnMatched Barcode: $barCode";
        });
        // Fluttertoast.showToast(msg: "No product found for that BarCode");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future fetchAddCartStoreBasis(index, itemCode, storeId, storeName) async {
    setState(() {
      isLoading = true;
    });

    String user = ProfileDetails.id!;

    var requestBody = {
      'item_code': itemCode,
      'store_id': storeId,
      'store_name': storeName,
      'user': user,
    };

    Uri myUri = Uri.parse(NetworkUtil.getAddIntoCartStoreBasisUrl);
    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AddIntoCartStoreBasisReq addIntoCartStoreBasisReq =
          AddIntoCartStoreBasisReq.fromJson(jsonResponse);
      if (addIntoCartStoreBasisReq.success == true) {
        Fluttertoast.showToast(
          msg: "Product Added Successful",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
        );
        getProdBasedOnBarCodeList.removeAt(index);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.55,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text("SHOP-IN",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  Text(
                    "Are You Sure Switching SHOP-IN ?",
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "NOTICE:",
                      style: TextStyle(
                          color: Constant.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: " All Items From Cart Will Be Removed",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Constant.primaryColor),
                          onPressed: () {},
                          child: Text("Cancel")),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.ShopInPage);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          );
        });
  }
}
