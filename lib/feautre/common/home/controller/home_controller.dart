import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/apis/home_service.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class HomeController extends GetxController {
  RxInt selectedIndexButtons = 0.obs;
  // var checkedItemsDepart = List<bool>.filled(0, false).obs;
  // var checkedItemsStud = List<bool>.filled(0, false).obs;
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
    // patienSection.listen((_) {
    //   updateSubCheckedValuesDep();
    // });
    // patienStudent.listen((_) {
    //   updateSubCheckedValuesStud();
    // });
    super.onInit();
  }

  // void updateSubCheckedValuesDep() {
  //   checkedItemsDepart.value =
  //       List<bool>.filled(patienSection.length, false).obs;
  // }

  // void updateSubCheckedValuesStud() {
  //   checkedItemsStud.value = List<bool>.filled(patienStudent.length, false).obs;
  // }

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

  // void toggleChecked(int index, bool? value) {
  //   if (value != null && selectedIndexButtons.value == 0) {
  //     checkedItemsDepart[index] = value;
  //   }
  // }

  // void toggleCheckedStud(int index, bool? value) {
  //   if (value != null && selectedIndexButtons.value == 2) {
  //     checkedItemsStud[index] = value;
  //   }
  // }

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

  void showAlertDialog(BuildContext context, int id, int status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('Do you accept this situation or reject it.'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'reject',
                style: TextStyle(color: Palette.red),
              ),
              onPressed: () {
                rejectReffera(id, status);
                Get.back();
              },
            ),
            TextButton(
              child: const Text(
                'accept',
                style: TextStyle(color: Palette.primary),
              ),
              onPressed: () {
                acceptReffera(id, status);
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> acceptReffera(int id, int status) async {
    try {
      await HomeService.acceptReffera(id);
      if (status == 0) {
        patienSection.removeWhere((patient) => patient.id == id);
      } else {
        patienStudent.removeWhere((patient) => patient.id == id);
      }
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectReffera(int id, int status) async {
    try {
      await HomeService.rejectReffera(id);
      if (status == 0) {
        patienSection.removeWhere((patient) => patient.id == id);
      } else {
        patienStudent.removeWhere((patient) => patient.id == id);
      }
      update();
    } catch (e) {
      rethrow;
    }
  }
}
