// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/item_data.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  Object? number = 0;

  double sum = 0;

  double totalSum() {
    sum = 0;
    if (number == 0 || number == null) {
      for (int i = 0; i < itemData.length; i++) {
        sum += itemData[i].counter;
        sum;
      }
    } else {
      for (int i = 0; i < int.parse(number!.toString()); i++) {
        sum += itemData[i].counter;
        sum;
      }
    }

    return sum;
  }

  @override
  void initState() {
    totalSum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    (number == 0 || number == null)
        ? number = ModalRoute.of(context)?.settings.arguments
        : number == itemData.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Cart",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      primary: Constant.primaryColor),
                  onPressed: () {},
                  child: Text("PROCEED TO BUY")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Store Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  (number == 0 || number == null)
                      ? Text("${sum.toStringAsFixed(0)} Item")
                      : number == 1
                          ? Text("$number Item")
                          : Text("$number Items"),
                  SizedBox(width: MediaQuery.of(context).size.width / 4),
                  Text("\$ 60"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (number == 0 || number == null)
                    ? itemData.length
                    : int.parse(number!.toString()),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                      elevation: CardDimension.elevation,
                      shadowColor: CardDimension.shadowColor,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                height: ImageDimension.imageHeight - 10,
                                width: ImageDimension.imageWidth - 10,
                                fit: BoxFit.fill,
                                image: itemData[index].image),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  counterWidget(index)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (number == 0 || number == null)
                              ? Text("Total Item Count")
                              : number == 1
                                  ? Text("Total Item Count")
                                  : Text("Total Items Count"),
                          SizedBox(height: 4),
                          (number == 0 || number == null)
                              ? Text("Item Total")
                              : number == 1
                                  ? Text("Item Total")
                                  : Text("Items Total"),
                          SizedBox(height: 4),
                          Text("Delivery Cost"),
                          SizedBox(height: 4),
                          Text("Total Bill Amount:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (number == 0 || number == null)
                              ? Text("${sum.toStringAsFixed(0)} Item")
                              : number == 1
                                  ? Text("$number Item")
                                  : Text("$number Items"),
                          SizedBox(height: 4),
                          Text("\$ 200"),
                          SizedBox(height: 4),
                          Text("\$ 20"),
                          SizedBox(height: 4),
                          Text("\$ 220",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery to HOME",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Bharat Brance Pvt Ltd, Guduvancer, Kancnipursh, Tamil Nadu- 127291",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      primary: Constant.primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.AddressPage);
                  },
                  child: Text("CHANGE ADDRESS")),
            ),
          ],
        ),
      ),
    );
  }

  Widget counterWidget(int index) {
    return
        // itemData[index].shouldVisible
        //   ? Container(
        //       height: 30,
        //       width: 70,
        //       decoration: BoxDecoration(
        //           color: Colors.grey[200],
        //           borderRadius: BorderRadius.circular(4),
        //           border: Border.all(color: Colors.white70)),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   if (itemData[index].counter < 1) {
        //                     itemData[index].shouldVisible =
        //                         !itemData[index].shouldVisible;
        //                   } else {
        //                     itemData[index].counter--;
        //                   }
        //                 });
        //               },
        //               child: Icon(
        //                 Icons.remove,
        //                 color: Constant.primaryColor,
        //                 size: 22,
        //               )),
        //           SizedBox(width: 4),
        //           (itemData[index].counter == 0 ||
        //                   itemData[index].counter == null)
        //               ? Text(
        //                   '${itemData[index].counter}',
        //                   style: TextStyle(color: Colors.black),
        //                 )
        //               : Text(
        //                   '${itemData[index].counter}',
        //                   style: const TextStyle(color: Colors.black),
        //                 ),
        //           SizedBox(width: 4),
        //           InkWell(
        //               onTap: () {
        //                 setState(() {
        //                   itemData[index].counter++;
        //                 });
        //               },
        //               child: Icon(
        //                 Icons.add,
        //                 color: Constant.primaryColor,
        //                 size: 22,
        //               )),
        //         ],
        //       ),
        //     ):
        Container(
      padding: EdgeInsets.all(5),
      height: 30,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white70)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
              onTap: () {
                setState(() {
                  if (itemData[index].counter < 1) {
                    itemData[index].shouldVisible =
                        !itemData[index].shouldVisible;
                    totalSum();

                    (number == 0 || number == null)
                        ? itemData[index].counter--
                        : number.toString().length - 1;

                    if (itemData[index].counter == 0) {
                      setState(() {
                        itemData.removeAt(index);
                        int.parse(number!.toString());
                      });
                    }
                  } else {
                    setState(() {
                      totalSum();
                      (number == 0 || number == null)
                          ? itemData[index].counter--
                          : number.toString().length - 1;
                      if (itemData[index].counter == 0) {
                        setState(() {
                          itemData.removeAt(index);
                        });
                      }
                    });
                  }
                });
              },
              child: Center(
                  child: Icon(
                Icons.remove,
                color: Constant.primaryColor,
                size: 22,
              ))),
          SizedBox(width: 4),
          Text(
            '${itemData[index].counter}',
            style: const TextStyle(color: Colors.black),
          ),
          SizedBox(width: 4),
          InkWell(
              onTap: () {
                setState(() {
                  totalSum();
                  (number == 0 || number == null)
                      ? itemData[index].counter++
                      : number.toString().length + 1;
                  // itemData[index].counter++;
                  itemData[index].shouldVisible =
                      !itemData[index].shouldVisible;
                });
              },
              child: Center(
                  child: Icon(
                Icons.add,
                color: Constant.primaryColor,
                size: 22,
              ))),
        ],
      ),
    );
  }
}
