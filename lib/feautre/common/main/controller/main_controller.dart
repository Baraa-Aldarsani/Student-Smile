import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/feautre/feautre.dart';

class MainController extends GetxController {
  Widget _currentScreen = HomeScreen();
  get currentScreen => _currentScreen;
  void changeSelectedValue(int selected) {
    update();
    switch (selected) {
      case 0:
        {
          _currentScreen = HomeScreen();
          break;
        }
      case 1:
        {
          _currentScreen = OnBoarding();
          break;
        }
      case 2:
        {
          _currentScreen = HomeScreen();
          break;
        }
      case 3:
        {
          _currentScreen = HomeScreen();
          break;
        }
    }
  }
}
