// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class ItemData {
  // String image = '';

  String name;
  int counter = 1;
  bool shouldVisible = false;
  String weight;
  int price=0;
  NetworkImage image;

  ItemData(
    this.name,
    this.counter,
    this.shouldVisible,
    this.weight,
    this.price,
    this.image,
  );
}

List<ItemData> itemData = [
  ItemData(
    "Vegetables",
    1,
    false,
    "1",
    37,
    NetworkImage(Images.vegetablesImg),
  ),
  ItemData(
    "Chilly",
    1,
    false,
    "1",
    52,
    NetworkImage(Images.chillyImg),
  ),
  ItemData(
    "Tomato",
    1,
    false,
    "1",
    23,
    NetworkImage(Images.tomatoImg),
  ),
  ItemData(
    "Ladies Finger",
    1,
    false,
    "1",
    19,
    NetworkImage(Images.ladiesFingerImg),
  ),
  ItemData(
    "Onion",
    1,
    false,
    "1",
    31,
    NetworkImage(Images.onionImg),
  ),
  ItemData(
    "Potato",
    1,
    false,
    "1",
    17,
    NetworkImage(Images.potatoImg),
  ),
  ItemData(
    "Radis",
    1,
    false,
    "1",
    12,
    NetworkImage(Images.radisImg),
  ),
  ItemData(
    "Fruits",
    1,
    false,
    "1",
    21,
    NetworkImage(Images.fruitsImg),
  ),
  ItemData(
    "Mango",
    1,
    false,
    "1",
    25,
    NetworkImage(Images.mangoImg),
  ),
  ItemData(
    "Banana",
    1,
    false,
    "1",
    28,
    NetworkImage(Images.bananaImg),
  ),
  ItemData(
    "Grapes",
    1,
    false,
    "1",
    20,
    NetworkImage(Images.grapesImg),
  ),
  ItemData(
    "Nuts",
    1,
    false,
    "1",
    35,
    NetworkImage(Images.nutsImg),
  ),
  ItemData(
    "Munchies",
    1,
    false,
    "1",
    40,
    NetworkImage(Images.munchesImg),
  ),
  ItemData(
    "Happilo Nuts",
    1,
    false,
    "1",
    55,
    NetworkImage(Images.hippoNutsImg),
  ),
  ItemData(
    "Milk",
    1,
    false,
    "1",
    38,
    NetworkImage(Images.milkImg),
  ),
  ItemData(
    "Soft Drinks",
    1,
    false,
    "1",
    29,
    NetworkImage(Images.softDrinksImg),
  ),
  ItemData(
    "Oreo",
    1,
    false,
    "1",
    77,
    NetworkImage(Images.oreoImg),
  ),
  ItemData(
    "Biscuits",
    1,
    false,
    "1",
    69,
    NetworkImage(Images.biscuitsImg),
  ),
  ItemData(
    "Ice Cream",
    1,
    false,
    "1",
    19,
    NetworkImage(Images.iceCreamImg),
  ),
  ItemData(
    "Oil",
    1,
    false,
    "1",
    99,
    NetworkImage(Images.oilImg),
  ),
  ItemData(
    "Soap",
    1,
    false,
    "1",
    83,
    NetworkImage(Images.soapImg),
  ),
  ItemData(
    "Life Boy",
    1,
    false,
    "1",
    17,
    NetworkImage(Images.lifeBoyImg),
  ),
];
