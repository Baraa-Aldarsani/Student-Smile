import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class PatientController extends GetxController {
  var patient = <PatientModel>[].obs;
  RxBool isLoading = false.obs;
  var patientSession = <DailyAppointmentModel>[].obs;
  @override
  void onInit() {
    getAllPatients();
    super.onInit();
  }

  Future<void> getAllPatients() async {
    isLoading.value = true;
    try {
      final List<PatientModel> fetchData = await PatientSevice.getAllPatients();
      patient.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPatientSession(int id) async {
    isLoading.value = true;
    try {
      final fetchData = await PatientSevice.getPatientSession(id);
      patientSession.assignAll(fetchData);
      update();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  var allStudent = <UserModel>[].obs;

  Future<void> getAllStudent() async {
    try {
      final List<UserModel> fetchData = await PatientSevice.getAllStudent();
      allStudent.assignAll(fetchData);
    } catch (e) {
      rethrow;
    }
  }

  RxInt selectedStudent = 0.obs;
  void showLabItemsDialogTool(BuildContext context, int patientId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Student'),
          content: SingleChildScrollView(
            child: FutureBuilder(
                future: getAllStudent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: 300,
                      width: double.maxFinite,
                      child: GetBuilder(
                        init: PatientController(),
                        builder: (controller) => ListView.separated(
                            shrinkWrap: true,
                            itemCount: allStudent.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: index == selectedStudent.value
                                    ? Palette.primaryDark
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedStudent.value = index;
                                    update();
                                  },
                                  child: ListTile(
                                    title: Text(
                                        "${allStudent[index].firstName} ${allStudent[index].lastName}"),
                                    leading: CircleAvatar(
                                      backgroundColor: Palette.primary,
                                      child: Text(allStudent[index].year!),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 5)),
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
                selectedStudent.value = 0;
              },
            ),
            TextButton(
              child:
                  const Text('Send', style: TextStyle(color: Palette.primary)),
              onPressed: () async {
                Get.back();
                studentSendCases(
                    allStudent[selectedStudent.value].id!, patientId);
                selectedStudent.value = 0;
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> studentSendCases(int studentId, int patientId) async {
    try {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));
      await PatientSevice.sendStudent(studentId, patientId);
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Success send request'),
        backgroundColor: Palette.primary,
      ));
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Faild send request'),
        backgroundColor: Palette.red,
      ));
      rethrow;
    }
  }
}
