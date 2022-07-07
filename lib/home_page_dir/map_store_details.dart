// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/constant.dart';
import 'package:shop_n_go/shared/routes.dart';

class MapStoreDetailsPage extends StatefulWidget {
  const MapStoreDetailsPage({Key? key}) : super(key: key);

  @override
  State<MapStoreDetailsPage> createState() => _MapStoreDetailsPageState();
}

class _MapStoreDetailsPageState extends State<MapStoreDetailsPage> {
  Object? image = '';
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
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

  List scannerList = [];

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)?.settings.arguments!;

    return Scaffold(
      body: SafeArea(
        child: scannerList.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        image.toString(),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Spencer Stores",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Start QR Code', style: TextStyle(fontSize: 20)),
                      ElevatedButton(
                          onPressed: () => scanQR(), child: Text('Scan')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('Scan result : $_scanBarcode\n',
                            maxLines: 2, style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        image.toString(),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Spencer Stores",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Scan QR Code', style: TextStyle(fontSize: 20)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(50, 30),
                              primary: Constant.primaryColor),
                          onPressed: () => scanQR(),
                          child: Text('Scan')),
                    ],
                  ),
                  Text('Scan result : $_scanBarcode\n',
                      maxLines: 2, style: TextStyle(fontSize: 20)),
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
                      // reverse: true,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
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
                                                                itemData.removeAt(index);
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
                                          Text("\$${itemData[index].price}",
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
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
