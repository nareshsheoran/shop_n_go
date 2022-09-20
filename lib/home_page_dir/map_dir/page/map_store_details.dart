// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/home_page_dir/map_dir/model/vendor_profile_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/service/product_add_cart_service.dart';
import 'package:shop_n_go/shop_in_dir/model/add_into_cart_store_basis_req.dart';
import 'package:shop_n_go/shop_in_dir/model/get_prod_based_on_barCode_req.dart';

class MapStoreDetailsPage extends StatefulWidget {
  const MapStoreDetailsPage({Key? key}) : super(key: key);

  @override
  State<MapStoreDetailsPage> createState() => _MapStoreDetailsPageState();
}

class _MapStoreDetailsPageState extends State<MapStoreDetailsPage> {
  // Object? image = '';
  String _scanBarcode = 'Unknown';
  VendorProfileReqData? vendorProfileReqData;

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
    vendorProfileReqData =
        ModalRoute.of(context)?.settings.arguments! as VendorProfileReqData?;

    return Scaffold(
      body: SafeArea(
        child: getProductBasedOnBarCodeReqDataList.isEmpty
            ? Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "${Images.baseUrl}${vendorProfileReqData?.vendorProfile!}",
                          )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vendorProfileReqData!.vendorName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text(vendorProfileReqData!.address!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Start QR Code', style: TextStyle(fontSize: 20)),
                          ElevatedButton(
                              onPressed: () => scanQR(), child: Text('Scan')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Scan result:\n $_scanBarcode',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      left: 12,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace_outlined,
                          size: 32,
                          color: Colors.black,
                        ),
                      ))
                ],
              )
            : Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "${Images.baseUrl}${vendorProfileReqData?.vendorProfile!}",
                          )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vendorProfileReqData!.vendorName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text(vendorProfileReqData!.address!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Scan QR Code:', style: TextStyle(fontSize: 20)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(50, 30),
                                  primary: Constant.primaryColor),
                              onPressed: () => scanQR(),
                              child: Text('Scan')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Scan result:\n $_scanBarcode',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      // SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Total Product Scanned: ${getProductBasedOnBarCodeReqDataList.length}",
                                style: TextStyle(fontSize: 18)),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(50, 30),
                                    primary: Constant.primaryColor),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.CartPage,
                                      arguments: scannerList.length);
                                },
                                child: Text("Cart")),
                          ],
                        ),
                      ),
                      // SizedBox(height: 4),
                      Expanded(
                        child: ListView.builder(
                          itemCount: getProductBasedOnBarCodeReqDataList.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            GetProductBasedOnBarCodeReqData item =
                                getProductBasedOnBarCodeReqDataList[index];
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
                                                    ImageDimension.imageHeight -
                                                        20,
                                                width:
                                                    ImageDimension.imageWidth,
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
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Delete?"),
                                                              content: Text(
                                                                  "Are you sure to delete?"),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      getProductBasedOnBarCodeReqDataList
                                                                          .removeAt(
                                                                              index);
                                                                      _scanBarcode =
                                                                          "Unknown";
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppDetails.currencySign}${(item.price)?.toStringAsFixed(0)}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                // SizedBox(
                                                //     width: MediaQuery.of(context).size.width /
                                                //         3),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                Size(50, 30),
                                                            primary: Constant
                                                                .primaryColor),
                                                    onPressed: () {
                                                      ProductAddCartService()
                                                          .proAddedIntoCart(
                                                              index,
                                                              item.itemCode);
                                                      setState(() {
                                                        ProductAddCartService()
                                                                    .statusCode ==
                                                                200
                                                            ? getProductBasedOnBarCodeReqDataList
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
                  Positioned(
                      left: 12,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace_outlined,
                          size: 32,
                          color: Colors.black,
                        ),
                      ))
                ],
              ),
      ),
    );
  }

  bool isLoading = false;
  List<GetProductBasedOnBarCodeReqData> getProductBasedOnBarCodeReqDataList =
      [];
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

        getProductBasedOnBarCodeReqDataList
            .add(getProductBasedOnBarCodeReq!.data!);
        getProductBasedOnBarCodeReqDataList;
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
    //
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
        setState(() {
          getProductBasedOnBarCodeReqDataList.removeAt(index);
          _scanBarcode = "Unknown";
        });
        // getProductBasedOnBarCodeReq = getProductBasedOnBarCodeRequ;

        // getProductBasedOnBarCodeReqDataList
        //     .add(getProductBasedOnBarCodeReq!.data!);
        // getProductBasedOnBarCodeReqDataList;
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
