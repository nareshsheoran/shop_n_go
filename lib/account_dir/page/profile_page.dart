// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_n_go/shared/shared_preference_data/localdb.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/account_dir/model/user_prof_req_res.dart';
import 'package:shop_n_go/account_dir/model/user_profile_request.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController dateController =
      TextEditingController(text: ProfileDetails.date);
  TextEditingController genderController =
      TextEditingController(text: ProfileDetails.gender);

  final _formKey = GlobalKey<FormState>();
  String _dropDownValue = '';

  bool isUserProfileLoading = false;
  List<UserProfileRequestData> userProfileList = [];

  Future<void> fetchUserProfileDetails() async {
    setState(() {
      isUserProfileLoading = true;
    });
    Uri myUri =
        Uri.parse("${NetworkUtil.getUserProfileUrl}${ProfileDetails.userName}");
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      UserProfileRequest userProfileRequest =
          UserProfileRequest.fromJson(jsonResponse);
      UserProfileRequestData? userProfileRequestData = userProfileRequest.data;
      nameController =
          TextEditingController(text: userProfileRequestData?.username!);
      emailController =
          TextEditingController(text: userProfileRequestData?.email!);

      LocalDataSaver.saveID(userProfileRequestData!.id.toString());
      LocalDataSaver.saveUserName(userProfileRequestData.username);
      LocalDataSaver.saveEmail(userProfileRequestData.email);

      ProfileDetails.id = (await LocalDataSaver.getID())!;
      ProfileDetails.userName = (await LocalDataSaver.getUserName())!;
      ProfileDetails.email = (await LocalDataSaver.getEmail())!;
      setState(() {
        isUserProfileLoading = false;
      });
    }
  }

  Future updateProfilePassword() async {
    String oldPass = ProfileDetails.password!;
    String newPass = passwordController.text;

    var requestBody = {
      'old_password': oldPass,
      'new_password': newPass,
    };

    Uri myUri = Uri.parse(NetworkUtil.getUpdatePasswordUrl);

    http.Response response = await http.put(
      myUri,
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Token ${ProfileDetails.loginToken}',
      },
      body: requestBody,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
          jsonDecode(response.body) as Map<String, dynamic>;

      UserProfResReq userProfResReq = UserProfResReq.fromJson(map);

      LocalDataSaver.savePhone(mobileController.text);
      LocalDataSaver.savePassword(newPass);
      ProfileDetails.phone = (await LocalDataSaver.getPhone())!;
      ProfileDetails.password = (await LocalDataSaver.getPassword())!;

      await Navigator.pushReplacementNamed(context, AppRoutes.DashboardPage);
      Fluttertoast.showToast(
          msg: "${userProfResReq.message}", timeInSecForIosWeb: 2);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // fetchUserProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                // (isUserProfileLoading)?
                //      SizedBox(
                //         width: MediaQuery.of(context).size.width,
                //         height: MediaQuery.of(context).size.height,
                //         child:  Center(
                //           child: CProgressIndicator.circularProgressIndicator,
                //         ),
                //       ):
                Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 44,
                  child: Center(
                      child: Text(
                    ProfileDetails.userName!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(height: 30),
                buildText("Name"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                buildText("Email ID"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                buildText("Mobile Number"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: TextFormField(
                      maxLength: 16,
                      controller: mobileController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.phone,
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
                            : "Please Enter Phone";
                      }),
                ),
                buildText("Password"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                buildText("DOB"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        // buildDateTimePicker(context);
                        selectDateTime(context);
                      },
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                // buildDateTimePicker(context);
                                selectDateTime(context);
                              },
                              child: Icon(Icons.calendar_today_outlined)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'MM/DD/YYYY',
                          // label: Text("Enter Email",style: TextStyle(color: Constant.secondaryColor),),
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: buildFocusedBorder(),
                          border: buildOutlineInputBorder()
                          // border: InputBorder.none
                          ),
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value!, 1)
                            ? null
                            : "Please Choose Date";
                      }),
                ),
                buildText("Gender"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                        return GetUtils.isLengthGreaterOrEqual(value!, 1)
                            ? null
                            : "Please Choose Gender";
                      }),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                          LocalDataSaver.saveDate(dateController.text);
                          LocalDataSaver.saveGender(genderController.text);

                          ProfileDetails.name =
                              (await LocalDataSaver.getName())!;
                          ProfileDetails.email =
                              (await LocalDataSaver.getEmail())!;
                          ProfileDetails.phone =
                              (await LocalDataSaver.getPhone())!;
                          ProfileDetails.password =
                              (await LocalDataSaver.getPassword())!;
                          ProfileDetails.date =
                              (await LocalDataSaver.getDate())!;
                          ProfileDetails.gender =
                              (await LocalDataSaver.getGender())!;

                          Fluttertoast.showToast(
                              msg: "Data Saved",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 2);

                          await updateProfilePassword();
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

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
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

  DateTime selectedDate = DateTime.now();

  Future selectDateTime(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        // lastDate: DateTime(2025),
        helpText: "Select DOB",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                  primary: Constant.primaryColor, secondary: Colors.black),
            ),
            child: child ?? Text(""),
          );
        });
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        var dateTime = DateTime.parse(selectedDate.toString());

        var formatDate = "${dateTime.month}/${dateTime.day}/${dateTime.year}";
        // selectedDate.toString().trim();
        dateController = TextEditingController(text: formatDate);
      });
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
          String formattedDate = DateFormat('MM/dd/yyyy').format(index);
          dateController = TextEditingController(text: formattedDate);
        });
      },
      bottomPickerTheme: BottomPickerTheme.morningSalad,
    ).show(context);
  }
}
