// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shop_n_go/account_dir/model/add_address_res_req.dart';
import 'package:shop_n_go/shared/shared_preference_data/address_localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/shared_preference_data/fetch_data_SP.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController =
      TextEditingController(text: ProfileDetails.userName);

  TextEditingController mobileController =
      TextEditingController(text: ProfileDetails.phone);

  TextEditingController flatController =
      TextEditingController(text: AddressDetails.flat);

  TextEditingController villageController =
      TextEditingController(text: AddressDetails.village);

  TextEditingController cityController =
      TextEditingController(text: AddressDetails.city);

  TextEditingController stateController =
      TextEditingController(text: AddressDetails.state);

  TextEditingController pinCodeController =
      TextEditingController(text: AddressDetails.pinCode);

  TextEditingController countryController =
      TextEditingController(text: AddressDetails.country);

  String _dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: Row(
                //     children: [
                //       GestureDetector(
                //           onTap: () {
                //             Navigator.pop(context);
                //           },
                //           child: Icon(Icons.arrow_back_rounded,
                //               color: Colors.black)),
                //       SizedBox(width: 20),
                //       Text(
                //         "Saved Address",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 18),
                //       ),
                //     ],
                //   ),
                // ),
                AddressDetails.flat == ""
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ADD A NEW ADDRESS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "UPDATE ADDRESS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                SizedBox(height: 10),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18),
                      buildTitle("Full Name"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: nameController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter Name',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 3)
                                  ? null
                                  : "Please Enter Valid Name";
                            }),
                      ),
                      buildTitle("Mobile Number"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: mobileController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter Mobile Number',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 10)
                                  ? null
                                  : "Please Enter Valid Mobile Number";
                            }),
                      ),
                      buildTitle("House No, Flat, Building Name"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: flatController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter Address 1',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 3)
                                  ? null
                                  : "Please Enter Valid Address";
                            }),
                      ),
                      buildTitle("Area, Street, Sector, Village Name"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: villageController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter Address 2',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 3)
                                  ? null
                                  : "Please Enter Valid Address";
                            }),
                      ),
                      buildTitle("Town/City Name"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: cityController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter City',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 3)
                                  ? null
                                  : "Please Enter Valid City";
                            }),
                      ),
                      buildTitle("State Name"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: stateController,
                            readOnly: true,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                suffixIcon: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    // hint: const Text(""),
                                    disabledHint: Text(""),

                                    items: <String>[
                                      'Andhra Pradesh',
                                      'Arunachal Pradesh',
                                      'Assam',
                                      'Bihar',
                                      'Chhattisgarh',
                                      'Goa',
                                      'Gujarat',
                                      'Haryana',
                                      'Himachal Pradesh',
                                      'Jammu',
                                      'Jharkhand',
                                      'Karnataka',
                                      'Kashmir',
                                      'Kerala',
                                      'Madhya Pradesh',
                                      'Maharashtra',
                                      'Manipur',
                                      'Meghalaya',
                                      'Mizoram',
                                      'Nagaland',
                                      'Odisha',
                                      'Punjab',
                                      'Rajasthan',
                                      'Sikkim',
                                      'Tamil Nadu',
                                      'Telangana',
                                      'Tripura',
                                      'Uttar Pradesh',
                                      'Uttarakhand',
                                      'West Bengal',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _dropDownValue = val!;
                                        stateController = TextEditingController(
                                            text: _dropDownValue);
                                      });
                                    },
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 16, 0, 16),
                                hintText: 'Choose State',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 3)
                                  ? null
                                  : "Please Choose State";
                            }),
                      ),
                      buildTitle("Pin Code"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: pinCodeController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter Pin Code',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 6)
                                  ? null
                                  : "Please Enter Valid Pin Code";
                            }),
                      ),
                      buildTitle("Country Name"),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: countryController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Enter Country',
                                helperMaxLines: 2,
                                hintMaxLines: 2,
                                focusedBorder: buildFocusedBorder(),
                                border: buildOutlineInputBorder()),
                            validator: (String? value) {
                              return GetUtils.isLengthGreaterOrEqual(value!, 4)
                                  ? null
                                  : "Please Enter Valid Country";
                            }),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                                primary: Constant.primaryColor),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                AddressDetails.flat == ""
                                    ? addAddress(
                                        flatController.text,
                                        villageController.text,
                                        cityController.text,
                                        cityController.text,
                                        pinCodeController.text,
                                      )
                                    : updateAddress(
                                        flatController.text,
                                        villageController.text,
                                        cityController.text,
                                        cityController.text,
                                        pinCodeController.text,
                                      );
                                LocalDataSaver.saveName(nameController.text);
                                LocalDataSaver.savePhone(mobileController.text);
                                AddressLocalDataSaver.saveFlat(
                                    flatController.text);
                                AddressLocalDataSaver.saveVillage(
                                    villageController.text);
                                AddressLocalDataSaver.saveCity(
                                    cityController.text);
                                AddressLocalDataSaver.saveState(
                                    stateController.text);
                                AddressLocalDataSaver.savePinCode(
                                    pinCodeController.text);
                                AddressLocalDataSaver.saveCountry(
                                    countryController.text);

                                await fetchDataSP();

                                // Navigator.pop(context);
                              }
                            },
                            child:AddressDetails.flat == ""? Text("Save Address"):Text("Update Address")),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addAddress(buildingName, area, city, landMark, pinCode) async {
    String users = ProfileDetails.userName!;
    var requestBody = {
      'users': users,
      'Building_no_or_name': buildingName,
      'Area': area,
      'City': city,
      'Landmark': landMark,
      'Pincode': pinCode,
    };

    Uri myUri = Uri.parse(NetworkUtil.getConsumerAddressUrl);
    //
    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AddAddressResReq addAddressResReq =
          AddAddressResReq.fromJson(jsonResponse);

      if (addAddressResReq.message == "Created Successfully") {
        Fluttertoast.showToast(
            msg: "Address Saved", toastLength: Toast.LENGTH_SHORT);
        Navigator.pop(context);
        await Navigator.pushNamed(context, AppRoutes.DashboardPage);
      }
    }
  }

  Future updateAddress(buildingName, area, city, landMark, pinCode) async {
    var requestBody = {
      'Building_no_or_name': buildingName,
      'Area': area,
      'City': city,
      'Landmark': landMark,
      'Pincode': pinCode,
    };

    Uri myUri = Uri.parse(NetworkUtil.getConsumerAddressUrl);
    http.Response response = await http.patch(
      myUri,
      body: requestBody,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      AddAddressResReq addAddressResReq =
          AddAddressResReq.fromJson(jsonResponse);

      if (addAddressResReq.message == "UPDATED") {
        Fluttertoast.showToast(
            msg: "Address Update", toastLength: Toast.LENGTH_SHORT);
        Navigator.pop(context);
        await Navigator.pushNamed(context, AppRoutes.DashboardPage);
      }
    }
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Constant.primaryColor));
  }

  OutlineInputBorder buildFocusedBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Constant.primaryColor));
  }

  Widget buildTitle(title) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)));
}
