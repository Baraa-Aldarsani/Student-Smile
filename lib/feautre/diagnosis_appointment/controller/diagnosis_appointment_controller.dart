import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class DiagnosisAppointmentController extends GetxController {
  var diagnosis = <DiagnosisAppointmentModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getDiagnosisApp();
    typeCases.listen((_) {
      updateSubCheckedValues();
    });
    super.onInit();
  }

  Future<void> getDiagnosisApp() async {
    try {
      isLoading.value = true;

      final List<DiagnosisAppointmentModel> fetchData =
          await DiagnosisAppointmentService.getDiaApp();
      diagnosis.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  var typeCases = <TypeCasesModel>[].obs;
  Future<void> getTypeCases() async {
    try {
      final List<TypeCasesModel> fetchData =
          await DiagnosisAppointmentService.getTypes();
      typeCases.assignAll(fetchData);
    } catch (e) {
      rethrow;
    }
  }

  void updateSubCheckedValues() {
    isChecked.value = List<bool>.filled(typeCases.length, false);
    update();
  }

  void showLabItemsDialog(
      BuildContext context, DiagnosisAppointmentModel diagnosisApp) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Lab Items'),
          content: SingleChildScrollView(
            child: FutureBuilder(
                future: getTypeCases(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: 300,
                      child: GetBuilder(
                        init: DiagnosisAppointmentController(),
                        builder: (controller) => ListView.builder(
                            itemCount: controller.typeCases.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                activeColor: Palette.primary,
                                title: Text(controller.typeCases[index].type),
                                subtitle: Text(
                                    controller.typeCases[index].nameSection),
                                value: controller.isChecked[index],
                                secondary: Image.network(
                                  controller.typeCases[index].imageSection,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                onChanged: (bool? value) {
                                  controller.toggleCheckbox(index, value);
                                },
                              );
                            }),
                      ),
                    );
                  }
                }),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Palette.red)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child:
                  const Text('Send', style: TextStyle(color: Palette.primary)),
              onPressed: () async {
                await submitToolFunc();
                addPatientCases(typeCases, diagnosisApp);
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void toggleCheckbox(int index, bool? value) {
    if (value != null) {
      isChecked[index] = value;
    }
    update();
  }

  var isChecked = <bool>[].obs;
  List<TypeCasesModel> submitTools = [];
  submitToolFunc() {
    submitTools.clear();
    for (int i = 0; i < typeCases.length; i++) {
      if (isChecked[i]) {
        submitTools.add(typeCases[i]);
      }
    }
  }

  Future<void> addPatientCases(List<TypeCasesModel> typeCases,
      DiagnosisAppointmentModel diagnosisApp) async {
    try {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Processing Data ...')));
      await DiagnosisAppointmentService.addPatientCases(
          typeCases, diagnosisApp);
      diagnosis.removeWhere((diagnosis) => diagnosis.id == diagnosisApp.id);
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Success add cases'),
        backgroundColor: Palette.primary,
      ));
      update();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Faild add cases'),
        backgroundColor: Palette.red,
      ));
      rethrow;
    }
  }
}
