// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';

class LocalStorageData extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await getUserData();
      // ignore: avoid_print
      print(userModel.token);
      if (userModel == null) return null;
      return userModel;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.getString(CHARED_DATA_STORAGE);
    return UserModel.fromJson(json.decode(value!));
  }

  setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
        CHARED_DATA_STORAGE, jsonEncode(userModel.toJson()));
  }

  void deleteUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(CHARED_DATA_STORAGE);
    await preferences.remove(CHARED_DATA_STORAGE);
  }
}
