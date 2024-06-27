import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../feautre/feautre.dart';

class HealthRecordService {
  static Future<List<DiseasesModel>> fetchDiseases() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(Uri.parse('$BASE_URL/profile/viewDisease'),
        headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<DiseasesModel>((jsonData) => DiseasesModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch Diseases');
    }
  }

  static Future<void> createHealthRecord(
    List<XFile> imageListRadiographs,
    List<MedicineModel> imageListMedicines,
    List<DiseasesModel> viewDiseasesSubmit,
    int patientID,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final request = http.MultipartRequest(
        'POST', Uri.parse('$BASE_URL/profile/updateHealthRecord'));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['patient_id'] = patientID.toString();
    int i = 0;
    for (var radiograph in imageListRadiographs) {
      var file = await http.MultipartFile.fromPath(
          'radiograph[$i][radiograph_image]', radiograph.path);
      request.files.add(file);
      i++;
    }
    i = 0;
    for (var medicine in imageListMedicines) {
      request.fields['medicine[$i][name]'] = medicine.name.toString();
      var file = await http.MultipartFile.fromPath(
          'medicine[$i][medicine_image]', medicine.image.path);
      request.files.add(file);
      i++;
    }
    i = 0;
    for (var diseases in viewDiseasesSubmit) {
      request.fields['diseases[$i][preexisting_disease_id]'] =
          diseases.id.toString();

      i++;
    }
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success: Health record created.');
    } else {
      print(
          'Error: Failed to create health record. Status code: ${response.statusCode}');
    }
  }

  static Future<HealthRecordModel> getHealthRecord(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse(
            '$BASE_URL/profile/studentPatientHealthRecord?patient_id=$id'),
        headers: {'Authorization': 'Bearer $token'});
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (responseJson['status'] == false) {
        throw Exception('Failed to fetch Health Record: Status is false');
      }
      return HealthRecordModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to fetch Health Record');
    }
  }
}
