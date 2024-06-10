import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/feautre/feautre.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController unNumberController = TextEditingController();
  final LocalStorageData localStorageData = Get.put(LocalStorageData());

  bool isValidPassword(String password) {
    const passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    final RegExp regex = RegExp(passwordPattern);

    return regex.hasMatch(password);
  }

  void clearData() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final UserModel userModel =
          await AuthService.signInWithEmailAndPassword(email, password);
      EasyLoading.showSuccess('done...',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      clearData();
      Get.to(const MainScreen());
      setUser(userModel);
      _saveToken(userModel.token.toString());
    } catch (e) {
      EasyLoading.showError(
        "Wrong login",
        maskType: EasyLoadingMaskType.black,
      );
    }
  }

  Future<void> createAccount() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final unNumber = unNumberController.text;

    try {
      if (confirmPassword != password) {
        throw Exception('Faild Register');
      }
      final UserModel userModel =
          await AuthService.createAccount(email, password, unNumber);
      EasyLoading.showSuccess('done...',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      clearData();
      Get.to(const MainScreen());
      setUser(userModel);
      _saveToken(userModel.token.toString());
    } catch (e) {
      EasyLoading.showError(
        "Wrong login",
        maskType: EasyLoadingMaskType.black,
      );
    }
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
  }

  _saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    preferences.setString(key, value);
  }
}
