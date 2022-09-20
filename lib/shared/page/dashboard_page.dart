// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_n_go/account_dir/page/account_page.dart';
import 'package:shop_n_go/cart_dir/page/cart_page.dart';
import 'package:shop_n_go/home_page_dir/page/home_page.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shop_in_dir/page/shop_in_page.dart';
import 'package:shop_n_go/stores_dir/page/stores_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  List<Widget> tabPage = [
    const HomePage(),
    const StoresPage(),
    const ShopInPage(),
    const CartPage(),
    const AccountPage(),
  ];
  List list = [];

  @override
  void initState() {
    list
      ..add(HomePage())
      ..add(StoresPage())
      ..add(ShopInPage())
      ..add(CartPage())
      ..add(AccountPage());
    super.initState();
  }

  Future<bool>? _onBackPressed() {
    Navigator.canPop(context);
    Navigator.pop(context);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: list[_selectedIndex],
          bottomNavigationBar: buildBottomNavigationBar()),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 16,
      unselectedFontSize: 12,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      currentIndex: _selectedIndex,
      onTap: onTabSelect,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Stores',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Shop In',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }

  void onTabSelect(int index) {
    if (index != 3) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      setState(() {
        _selectedIndex = 3;

        // Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
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
