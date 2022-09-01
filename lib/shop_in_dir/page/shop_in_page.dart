// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scan/scan.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:images_picker/images_picker.dart';

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

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

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
      _scanBarcode = barcodeScanRes;
      scannerList.add(barcodeScanRes);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  List scannerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: scannerList.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => scanQR(),
                        child: Text('Start QR scan')),
                    Text('Scan result : $_scanBarcode\n',
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
                      style: TextStyle(fontSize: 10)),
                  // SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Product Scanned: ${scannerList.length}",
                            style: TextStyle(fontSize: 20)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(50, 30),
                                primary: Constant.primaryColor),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.CartPage,
                                  arguments: scannerList.length);
                            },
                            child: Text("Cart")),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: ListView.builder(
                      itemCount: scannerList.length,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image(
                                        height: ImageDimension.imageHeight,
                                        width: ImageDimension.imageWidth,
                                        fit: BoxFit.fill,
                                        image: itemData[index].image),
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
                                              child: Text(scannerList[index],
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
                                            Text("${AppDetails.currencySign}${itemData[index].price}",
                                                style: TextStyle(fontSize: 18)),
                                            // SizedBox(
                                            //     width: MediaQuery.of(context).size.width /
                                            //         3),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(50, 30),
                                                    primary:
                                                        Constant.primaryColor),
                                                onPressed: () {},
                                                child: Text("Buy Now")),
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
