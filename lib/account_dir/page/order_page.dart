// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/account_dir/helper/iPay_helper.dart';
import 'package:shop_n_go/account_dir/page/checkout_page.dart';
import 'package:shop_n_go/shared/auth/constant.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    totalAmount = ModalRoute.of(context)?.settings.arguments;
    totalAmount == null
        ? amountController.text = "10"
        : amountController.text = totalAmount.toString();
    // amountController.text=totalAmount.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.all(8),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    child: TextFormField(
                        controller: phoneController,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
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
                          return GetUtils.isPhoneNumber(value!)
                              ? null
                              : "Please Enter Phone";
                        }),
                  ),
                  buildText("Email"),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                    child: const Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                        primary: Constant.primaryColor,
                        elevation: 5.0,
                        minimumSize: const Size(250.0, 40.0),
                        textStyle: const TextStyle(
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
      ),
    );
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
}
