import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/feautre/feautre.dart';

class LaborarotyPicesController extends GetxController {
  var requiredMaterial = <LaborarotyPicesModel>[].obs;
  int selectedMaterila = -1;
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final TextEditingController name = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      // Compress the image
      final File compressedImage = await _compressImage(File(pickedImage.path));
      _image.value = compressedImage;
      update();
    } else {
      print("Error");
    }
  }

  Future<File> _compressImage(File file) async {
    final img.Image? image = img.decodeImage(file.readAsBytesSync());
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Resize the image to a smaller size (e.g., 800x800)
    final img.Image resizedImage = img.copyResize(image, width: 800);

    // Compress the resized image
    final List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 85);

    // Create a new file with the compressed image
    final File compressedFile = File(file.path)
      ..writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  void selectImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Center(
            child: Text(
              "Select Image",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  await pickImage(ImageSource.camera);
                  Get.back();
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.camera_enhance,
                    size: 30,
                    color: Color(0xFFB74D3F),
                  ),
                  title: Text(
                    "From Camera",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 2),
              InkWell(
                onTap: () async {
                  await pickImage(ImageSource.gallery);
                  Get.back();
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.camera,
                    size: 30,
                    color: Color(0xFFB74D3F),
                  ),
                  title: Text(
                    "From Gallery",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    getRequiredMaterial();
    requiredMaterial.listen((_) {
      updateSubCheckedValues();
    });
    super.onInit();
  }

  Future<void> getRequiredMaterial() async {
    try {
      final List<LaborarotyPicesModel> fetchData =
          await LaborarotyPicesService.getRequiredMaterial();
      requiredMaterial.value = fetchData;
      update();
    } catch (e) {
      rethrow;
    }
  }

  void updateSelectedIndex(int index) {
    if (selectedMaterila == index) {
      selectedMaterila = -1;
    } else {
      selectedMaterila = index;
    }
    update();
  }

  void deleteProduct(int id) async {
    try {
      await LaborarotyPicesService.deleteTool(id);
      requiredMaterial.removeWhere((material) => material.id == id);
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEquipment(String nameTool, File image) async {
    try {
      await LaborarotyPicesService.addEquipment(nameTool, image);
      Get.back();
      name.clear();

      update();
    } catch (e) {
      rethrow;
    }
  }

  //add tool for patient
  var isChecked = <bool>[].obs;

  void toggleCheckbox(int index, bool? value) {
    if (value != null) {
      isChecked[index] = value;
    }
    update();
  }

  void updateSubCheckedValues() {
    isChecked.value = List<bool>.filled(requiredMaterial.length, false);
    update();
  }
}
