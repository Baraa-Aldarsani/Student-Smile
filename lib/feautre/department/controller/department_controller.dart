import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class DepartmentController extends GetxController {
  var department = <DepartmentModel>[].obs;
  RxInt selectedIndexButtons = 0.obs;

  @override
  void onInit() {
    getInfoDepartment();
    super.onInit();
  }

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index ? Palette.primary : Colors.white;
  }

  Color getColorText(int index) {
    return selectedIndexButtons.value == index ? Colors.white : Palette.primary;
  }

  Future<void> getInfoDepartment() async {
    try {
      final List<DepartmentModel> fetchData =
          await DepartmentService.getInfoDepartment();
      department.value = fetchData;
      print(department.length);
    } catch (e) {
      rethrow;
    }
  }
}
