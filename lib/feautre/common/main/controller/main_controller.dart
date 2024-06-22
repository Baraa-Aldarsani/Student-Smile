import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/feautre/feautre.dart';
import 'package:student_smile/core/core.dart';

class MainController extends GetxController {
  Widget _currentScreen = HomeScreen();
  get currentScreen => _currentScreen;
  @override
  void onInit() {
    getInotUser();
    super.onInit();
  }

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
          _currentScreen = DepartmentView();
          break;
        }
      case 2:
        {
          _currentScreen = DailyAppointmentView();
          break;
        }
      case 3:
        {
          _currentScreen = DiagnosisAppointmentView();
          break;
        }
      case 4:
        {
          _currentScreen = PatientView();
          break;
        }
      case 5:
        {
          _currentScreen = HomeScreen();
          break;
        }
      case 6:
        {
          _currentScreen = LaborarotyPicesView();
          break;
        }
    }
  }

  void logout() {
    Get.bottomSheet(
      Logout(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  var profileData = UserModel();

  Future<void> getInotUser() async {
    try {
      final UserModel fetchedUser = await AuthService.getUserInfo();
      profileData = fetchedUser;
    } catch (e) {
      rethrow;
    }
  }
}

class Logout extends StatelessWidget {
  Logout({super.key});
  final LocalStorageData localStorageData = Get.put(LocalStorageData());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          _buildDivider(),
          const SizedBox(height: 30),
          const Text(
            "Logout",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Palette.red),
          ),
          const SizedBox(height: 30),
          const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          _buildButtons(
              label: 'Yes, Logout',
              backgroundColor: Palette.primary,
              textColor: Palette.primaryLight,
              onPressed: () {
                localStorageData.deleteUser();
                Get.offAll(SignIn());
              }),
          const SizedBox(height: 20),
          _buildButtons(
              label: 'Cancel',
              backgroundColor: Palette.primaryLight,
              textColor: Palette.primary,
              onPressed: () {
                Get.back();
              }),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 5,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.grey,
      ),
    );
  }

  Widget _buildButtons(
      {required String label,
      required Color backgroundColor,
      required Color textColor,
      required VoidCallback onPressed}) {
    return _buildMaterialButton(
        label: label,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onPressed: onPressed);
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: MaterialButton(
        height: 40,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: backgroundColor),
        ),
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
