// ignore_for_file: prefer_const_constructors, prefer_final_fields, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart';
import 'package:shop_n_go/account_dir/helper/iPay_helper.dart';
import 'package:shop_n_go/account_dir/model/master_order_res.dart';
import 'package:shop_n_go/account_dir/page/checkout_page.dart';
import 'package:shop_n_go/cart_dir/model/store_list_cart_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController amountController = TextEditingController(text: "10");
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late HttpHelper helper;
  static String _phone = '';
  static String? _email = '';
  static String _amount = '';
  Object? totalAmount;

  late bool _isSubmitted = false;
  late String result = '';

  @override
  void initState() {
    helper = HttpHelper();
    // fetchMasterOrder();
    fetchStoreListCartDetails();
    super.initState();
  }

  bool isLoading = false;

  List<MasterOrderResData> productDetailsDataList = [];

  Future fetchMasterOrder() async {
    setState(() {
      isLoading = true;
    });
    productDetailsDataList.clear();
    for (int i = 0; i < fetchIdList.length; i++) {
      Uri myUri = Uri.parse(
          // "${NetworkUtil.fetchMasterOrderUrl}/${ProfileDetails.id}/V001");
          "${NetworkUtil.fetchMasterOrderUrl}/${ProfileDetails.id}/${fetchIdList[i]}");
      Response response = await get(myUri);
      print(myUri);
      if (response.statusCode == 200) {
        print("ResBody: ${fetchIdList[i]}:: ${response.body}");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        MasterOrderRes masterOrderRes = MasterOrderRes.fromJson(jsonResponse);
        if (masterOrderRes.success == false) {
          setState(() {});
        } else {
          // productDetailsDataList.clear();
          List<MasterOrderResData> list = masterOrderRes.data!;
          productDetailsDataList.addAll(list);
        }
      }if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {

    totalAmount = ModalRoute.of(context)?.settings.arguments;
    (totalAmount == null || totalAmount == '')
        ? amountController.text = "10"
        : amountController.text = totalAmount.toString();
    // amountController.text=totalAmount.toString();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Constant.primaryColor,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [Tab(text: "Open"), Tab(text: "Close")],
          ),
        ),
        key: _scaffoldKey,
        body: TabBarView(
          children: [
            openOrder(),
            buildContainer(context),
          ],
        ),
      ),
    );
  }

  Widget openOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? Center(child: CProgressIndicator.circularProgressIndicator)
          : ListView.builder(
              itemCount: productDetailsDataList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = productDetailsDataList[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.OrderDetailsPage,
                          arguments: item);
                    },
                    child: Card(
                      elevation: 8,
                      shadowColor: Constant.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order Id: ${item.mainOrderId.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Container()),
                                Text("Status: ${item.orderStatus.toString()}"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                    "Order Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item.orderDate!))}",
                                    textAlign: TextAlign.start),
                                Expanded(child: Container()),
                                Text("Store Id: ${item.storeId.toString()}"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                                "Delivery Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item.deliveryDate!))}",
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  List<StoreListCartReqData> dataStoreCartList = [];

  Future fetchStoreListCartDetails() async {
    setState(() {
      isLoading = true;
      // dataStoreCartList.clear();
    });
    Uri myUri =
        Uri.parse("${NetworkUtil.storeListCartUrl}${ProfileDetails.id}");
    print(myUri);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StoreListCartReq storeListCartReq =
          StoreListCartReq.fromJson(jsonResponse);
      if (storeListCartReq.message == "No Any Product") {
        setState(() {
          // isLoading = false;
          dataStoreCartList.clear();
        });
      } else {
        List<StoreListCartReqData> list = storeListCartReq.data!;
        dataStoreCartList.addAll(list);
      }
      // if (mounted) {
      //   setState(() {
      //      isLoading = false;
      //   });
      // }

      // isLoading = false;
      fetchId();
    }
  }

  List fetchIdList = [];

  void fetchId() {
    for (int i = 0; i < dataStoreCartList.length; i++) {
      print(dataStoreCartList.length);
      fetchIdList.add(dataStoreCartList[i].vendorId!.toString());
      print("hhh:${fetchIdList.length}");
      if (dataStoreCartList.length == fetchIdList.length) {
        fetchMasterOrder();
      }
    }
  }

  Future<String> makePayment(String phone, String email, String amount) async {
    var response = (await helper.generateUrl(phone, email, amount));
    return response;
  }

  Future _buttonSubmitted() async {
    setState(() {
      _isSubmitted = true;
    });
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();

      result = (await makePayment(_phone, _email!, _amount));

      if (result.isNotEmpty) {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => CheckoutPage(result));
        Navigator.of(context).push(route);

        setState(() {
          _isSubmitted = false;
        });
      }
    }
  }

  Widget buildText(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 16,
                  // decoration: BoxDecoration(
                  //   color: Constant.primaryColor,
                  //   border: Border.all(
                  //     color: Constant.primaryColor,
                  //   ),
                  //   borderRadius: BorderRadius.all(Radius.circular(8)
                  // )),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          AppDetails.appName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Check-Out",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                buildText("Amount"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: TextFormField(
                      controller: amountController,
                      textCapitalization: TextCapitalization.sentences,
                      readOnly: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter Amount',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constant.primaryColor))
                          // border: InputBorder.none
                          ),
                      // onChanged: (value) {
                      //   setState(() {
                      //     _amount = value;
                      //   });
                      // },
                      onSaved: (value) {
                        setState(() {
                          _amount = value!;
                        });
                      },
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!, 1)
                            ? null
                            : "Please Enter Amount";
                      }),
                ),
                buildText("Mobile No"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: TextFormField(
                      controller: phoneController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter MobileNo',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constant.primaryColor))
                          // border: InputBorder.none
                          ),
                      onSaved: (value) => _phone = value!,
                      validator: (String? value) {
                        // return GetUtils.isPhoneNumber(value!)
                        return GetUtils.isLengthGreaterOrEqual(value!, 10)
                            ? null
                            : "Please Enter Mobile No.";
                      }),
                ),
                buildText("Email"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: TextFormField(
                      controller: mailController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter email',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constant.primaryColor))
                          // border: InputBorder.none
                          ),
                      onSaved: (value) => _email = value!,
                      validator: (String? value) {
                        return GetUtils.isEmail(value!)
                            ? null
                            : "Please Enter Email";
                      }),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                //   child: TextFormField(
                //     keyboardType: const TextInputType.numberWithOptions(
                //       decimal: false,
                //       signed: true,
                //     ),
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Amount',
                //       hintText: 'Enter amount',
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter some text';
                //       }
                //       return null;
                //     },
                //     onSaved: (value) => _amount = value!,
                //   ),
                // ),
                SizedBox(height: 28),
                ElevatedButton(
                  child: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                      primary: Constant.primaryColor,
                      elevation: 5.0,
                      minimumSize: Size(250.0, 40.0),
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      )),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _buttonSubmitted();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
