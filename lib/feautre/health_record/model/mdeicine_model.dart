import 'package:image_picker/image_picker.dart';

class MedicineModel {
  final String name;
  final XFile image;
  MedicineModel({
    required this.name,
    required this.image,
  });
}

class GetMedicineModel{
  final String name;
  final String image;
  GetMedicineModel({
    required this.name,
    required this.image,
  });

  factory GetMedicineModel.fromJson(Map<dynamic, dynamic> json) {
    return GetMedicineModel(
      name: json['name'],
      image: json['medicine_image'],
    );
  }
}
