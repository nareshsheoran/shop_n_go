// import 'dart:convert';
//
// import 'package:shared_preferences/shared_preferences.dart';
// final SharedPreferences prefs = await SharedPreferences.getInstance();
//
// void storeIdP() async {
//   Person person = Person('Mary', 30);
//   Map<String, dynamic> map = {
//     'name': person.name,
//     'age': person.age
//   };
//   String rawJson = jsonEncode(map);
//   prefs.setString('my_string_key', rawJson);
//   }
//
// final rawJson = prefs.getString('my_string_key') ?? '';
// Map<String, dynamic> map = jsonDecode(rawJson);
// final person = Person(map['name'], map['age']);
