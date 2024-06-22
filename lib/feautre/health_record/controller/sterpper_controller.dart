import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class StepperController extends GetxController {
  var currentStep = 0.obs;
  var imageListRadiographs = <XFile>[].obs;
  var imageListMedicines = <MedicineModel>[].obs;
  var selectedIndex = List<bool>.filled(0, false).obs;
  final ImagePicker picker = ImagePicker();
  final ImagePicker pickerOneImage = ImagePicker();
  var viewDiseases = <DiseasesModel>[].obs;
  List<DiseasesModel> viewDiseasesSubmit = [];
  XFile? oneImage;
  RxInt selectedIndexButtons = 0.obs;
  List<String> text = [
    "Show",
    "Update",
  ];
  final TextEditingController nameMedicine = TextEditingController();
  var healthRecord = HealthRecordModel();

  @override
  void onInit() {
    fetchDiseases();
    viewDiseases.listen((_) {
      updateSubCheckedValues();
    });
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

  void updateSubCheckedValues() {
    selectedIndex.value = List<bool>.filled(viewDiseases.length, false);
  }

  void stepContinue() {
    if (currentStep < 2) {
      currentStep++;
    }
    if (currentStep == 2) {
      viewDiseasesSubmit.clear();
      for (int i = 0; i < viewDiseases.length; i++) {
        if (selectedIndex[i]) {
          viewDiseasesSubmit.add(viewDiseases[i]);
        }
      }
    }
  }

  void stepCancel() {
    if (currentStep > 0) {
      currentStep--;
    }
  }

  void showAlertDialog(int patientID) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure about the information entered in your health record?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Palette.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Palette.primary),
              ),
              onPressed: () async {
                Get.back();
                createHealthRecord(patientID);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImagesRadiographs() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages != null) {
      imageListRadiographs.addAll(selectedImages);
    }
  }

  Future<void> pickImagesMedicines() async {
    final XFile? selectedImages =
        await pickerOneImage.pickImage(source: ImageSource.camera);
    if (selectedImages != null) {
      oneImage = selectedImages;
      update();
    }
  }

  void addMedicines(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Palette.primaryLight,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Center(
            child: Text(
              "Add Medicine",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameMedicine,
                title: "Name of the drug",
                icon: Icons.medical_services_rounded,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      pickImagesMedicines();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Palette.black,
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text('Add Radiographs'),
                  ),
                  GetBuilder(
                    init: StepperController(),
                    builder: (controller) => ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: controller.oneImage != null
                          ? Image.file(
                              File(controller.oneImage!.path),
                              fit: BoxFit.cover,
                              height: 75,
                              width: 75,
                            )
                          : const SizedBox(),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.back();
                nameMedicine.clear();
                oneImage = null;
              },
              child: const Text(
                "cancel",
                style: TextStyle(color: Palette.red),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                if (oneImage != null && nameMedicine.text.isNotEmpty) {
                  addMedicineToList(nameMedicine.text, oneImage!);
                  Get.back();
                  nameMedicine.clear();
                  oneImage = null;
                }
              },
              child: const Text(
                "Ok",
                style: TextStyle(color: Palette.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  void addMedicineToList(String nameMedicine, XFile image) {
    imageListMedicines.add(MedicineModel(name: nameMedicine, image: image));
  }

  void removeNodeRadiographs(int index) {
    imageListRadiographs.removeAt(index);
  }

  void removeNodeMedicines(int index) {
    imageListMedicines.removeAt(index);
  }

  void toggleCheckbox(int index, bool? value) {
    if (value != null) {
      selectedIndex[index] = value;
    }
  }

  Future<void> fetchDiseases() async {
    try {
      final List<DiseasesModel> fetchData =
          await HealthRecordService.fetchDiseases();
      viewDiseases.assignAll(fetchData);
    } catch (e) {
      print("Error fetch Diseases $e");
    }
  }

  Future<void> createHealthRecord(int patientID) async {
    try {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Processing Data ...')));
      await HealthRecordService.createHealthRecord(imageListRadiographs,
          imageListMedicines, viewDiseasesSubmit, patientID);
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Success update session'),
        backgroundColor: Palette.primary,
      ));
      update();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('You should add tools'),
        backgroundColor: Palette.red,
      ));
      print("Error create Health Record $e");
    }
  }

  RxBool isLoading = false.obs;
  Future<void> getHealthRecordData(int id) async {
    try {
      isLoading(true);
      final HealthRecordModel fetchData =
          await HealthRecordService.getHealthRecord(id);

      healthRecord = fetchData;
      isLoading(false);
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
}
