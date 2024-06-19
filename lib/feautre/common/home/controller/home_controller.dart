import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/apis/home_service.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class HomeController extends GetxController {
  RxInt selectedIndexButtons = 0.obs;
  var checkedItemsDepart = List<bool>.filled(0, false).obs;
  var checkedItemsStud = List<bool>.filled(0, false).obs;
  List<String> title = [
    "Department",
    "The waiting list",
    "Another student",
  ];

  var patienSection = <PatientFromSectionModel>[].obs;
  var patienStudent = <PatientFromSectionModel>[].obs;

  @override
  void onInit() {
    getPatientFromDepartment();
    getPatientFromStudent();
    patienSection.listen((_) {
      updateSubCheckedValuesDep();
    });
    patienStudent.listen((_) {
      updateSubCheckedValuesStud();
    });
    super.onInit();
  }

  void updateSubCheckedValuesDep() {
    checkedItemsDepart.value =
        List<bool>.filled(patienSection.length, false).obs;
  }

  void updateSubCheckedValuesStud() {
    checkedItemsStud.value = List<bool>.filled(patienStudent.length, false).obs;
  }

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    update();
  }

  void refreshPage() {
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index ? Palette.primary : Colors.white;
  }

  Color getColorText(int index) {
    return selectedIndexButtons.value == index ? Colors.white : Palette.primary;
  }

  void toggleChecked(int index, bool? value) {
    if (value != null && selectedIndexButtons.value == 0) {
      checkedItemsDepart[index] = value;
    }
  }

  void toggleCheckedStud(int index, bool? value) {
    if (value != null && selectedIndexButtons.value == 2) {
      checkedItemsStud[index] = value;
    }
  }

  Future<void> getPatientFromDepartment() async {
    try {
      final List<PatientFromSectionModel> fetchData =
          await HomeService.getPatientFromDepartment();
      patienSection.value = fetchData;
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getPatientFromStudent() async {
    try {
      final List<PatientFromSectionModel> fetchData =
          await HomeService.getPatientFromSudent();
      patienStudent.value = fetchData;
      update();
    } catch (e) {
      rethrow;
    }
  }
}
