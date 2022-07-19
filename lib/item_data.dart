// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

class ItemData {
  // String image = '';

  String name;
  int counter = 1;
  bool shouldVisible = false;
  String weight;
  String price;
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
    "10",
    NetworkImage(Images.vegetablesImg),
  ),
  ItemData(
    "Chilly",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.chillyImg),
  ),
  ItemData(
    "Tomato",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.tomatoImg),
  ),
  ItemData(
    "Ladies Finger",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.ladiesFingerImg),
  ),
  ItemData(
    "Onion",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.onionImg),
  ),
  ItemData(
    "Potato",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.potatoImg),
  ),
  ItemData(
    "Radis",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.radisImg),
  ),
  ItemData(
    "Fruits",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.fruitsImg),
  ),
  ItemData(
    "Mango",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.mangoImg),
  ),
  ItemData(
    "Banana",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.bananaImg),
  ),
  ItemData(
    "Grapes",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.grapesImg),
  ),
  ItemData(
    "Nuts",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.nutsImg),
  ),
  ItemData(
    "Munchies",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.munchesImg),
  ),
  ItemData(
    "Happilo Nuts",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.hippoNutsImg),
  ),
  ItemData(
    "Milk",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.milkImg),
  ),
  ItemData(
    "Soft Drinks",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.softDrinksImg),
  ),
  ItemData(
    "Oreo",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.oreoImg),
  ),
  ItemData(
    "Biscuits",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.biscuitsImg),
  ),
  ItemData(
    "Ice Cream",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.iceCreamImg),
  ),
  ItemData(
    "Oil",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.oilImg),
  ),
  ItemData(
    "Soap",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.soapImg),
  ),
  ItemData(
    "Life Boy",
    1,
    false,
    "1",
    "10",
    NetworkImage(Images.lifeBoyImg),
  ),
];
