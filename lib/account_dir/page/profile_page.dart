// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_n_go/shared/auth/localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController =
      TextEditingController(text: ProfileDetails.userName);
  TextEditingController emailController =
      TextEditingController(text: ProfileDetails.email);
  TextEditingController passwordController =
      TextEditingController(text: ProfileDetails.password);
  TextEditingController mobileController =
      TextEditingController(text: ProfileDetails.phone);
  TextEditingController dateController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,
                  child: Center(
                      child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'NAME',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!, 3)
                            ? null
                            : "Please Enter Name";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: emailController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'EMAIL ID',
                          // label: Text("Enter Email",style: TextStyle(color: Constant.secondaryColor),),
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isEmail(value!)
                            ? null
                            : "Please Enter Valid Email";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: mobileController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'MOBILE NUMBER',
                          // label: Text("Enter Email",style: TextStyle(color: Constant.secondaryColor),),
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isPhoneNumber(value!)
                            ? null
                            : "Please Enter Valid Mobile Number";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'PASSWORD',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!, 5)
                            ? null
                            : "Please Enter 5 Digit Password";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        buildDateTimePicker(context);
                      },
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                buildDateTimePicker(context);
                              },
                              child: Icon(Icons.calendar_today_outlined)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'DD/MM/YYYY',
                          // label: Text("Enter Email",style: TextStyle(color: Constant.secondaryColor),),
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!,1)
                            ? null
                            : "Please Choose Date";
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: genderController,
                      readOnly: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(

                                // hint: _dropDownValue == ""
                                //     ? const Text("")
                                //     : Text(_dropDownValue),
                                // dropdownColor: Colors.white,
                                // focusColor: Colors.white,

                                items: <String>[
                                  'MALE',
                                  'FEMALE',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _dropDownValue = val!;
                                    genderController = TextEditingController(
                                        text: _dropDownValue);
                                  });
                                },
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'GENDER',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()),
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!,1)
                            ? null
                            : "Please Choose Gender";
                      }),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 50),
                          primary: Constant.primaryColor),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          LocalDataSaver.saveName(nameController.text);
                          LocalDataSaver.saveEmail(emailController.text);
                          LocalDataSaver.savePhone(mobileController.text);
                          LocalDataSaver.savePassword(passwordController.text);

                          ProfileDetails.name =
                              (await LocalDataSaver.getName())!;
                          ProfileDetails.email =
                              (await LocalDataSaver.getEmail())!;
                          ProfileDetails.phone =
                              (await LocalDataSaver.getPhone())!;
                          ProfileDetails.password =
                              (await LocalDataSaver.getPassword())!;

                          Fluttertoast.showToast(msg: "Data Saved",
                              toastLength: Toast.LENGTH_SHORT,timeInSecForIosWeb: 2);

                          await Navigator.pushNamed(
                              context, AppRoutes.DashboardPage);
                        }
                      },
                      child: Text("SAVE AND PROCEED")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  void buildDateTimePicker(context) {
    return BottomPicker.date(
      title: 'Choose Date',
      dateOrder: DatePickerDateOrder.dmy,
      // initialDateTime: DateTime.now(),
      minDateTime: DateTime.utc(1950),
      maxDateTime: DateTime.now(),
      pickerTextStyle: TextStyle(
          color: Constant.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      closeIconColor: Constant.primaryColor,

      // buttonText: "Confirm",
      // buttonTextStyle: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 18,
      //     color: Colors.black),
      // displayButtonIcon: false,

      titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Constant.primaryColor),
      onChange: (index) {
        print(index);
      },
      onSubmit: (index) {
        print("Date Time:$index");
        setState(() {
          String formattedDate = DateFormat('dd/MM/yyyy').format(index);
          dateController = TextEditingController(text: formattedDate);
        });
      },
      bottomPickerTheme: BottomPickerTheme.morningSalad,
    ).show(context);
  }
}
