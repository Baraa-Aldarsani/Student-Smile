import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';
import 'package:http/http.dart' as http;

class DiagnosisAppointmentService {
  static Future<List<DiagnosisAppointmentModel>> getDiaApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
      Uri.parse('$BASE_URL/profile/studentDiagnosisCases'),
      headers: {'X-Token': 'Bearer $token', 'Authorization': basicAuth},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> nestedData = json.decode(response.body)['data'];
      List<dynamic> allPatients = [];
      for (var sublist in nestedData) {
        allPatients.addAll(sublist);
      }
      return allPatients
          .map<DiagnosisAppointmentModel>(
              (jsonData) => DiagnosisAppointmentModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch Diagnosis Appointment');
    }
  }

  static Future<List<TypeCasesModel>> getTypes() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
      Uri.parse('$BASE_URL/profile/tupeOfSections'),
      headers: {'X-Token': 'Bearer $token', 'Authorization': basicAuth},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];

      return data
          .map<TypeCasesModel>((jsonData) => TypeCasesModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch Type Cases');
    }
  }

  static Future<void> addPatientCases(List<TypeCasesModel> typeCases,
      DiagnosisAppointmentModel diagnosisApp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final request = http.MultipartRequest(
        'POST', Uri.parse('$BASE_URL/profile/addPatientCases'));
     request.headers['Authorization'] = basicAuth;
    request.headers['X-Token'] = 'Bearer $token';
    request.fields['diagnosis_appointments_id'] = diagnosisApp.id.toString();
    int i = 0;
    for (var cases in typeCases) {
      request.fields['cases[$i][types_of_cases_id]'] = cases.id.toString();
      request.fields['cases[$i][details_of_cases]'] = 'ssss';
      i++;
    }
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Success: add Patient Cases.');
    } else {
      print(
          'Error: Failed to add Patient Cases. Status code: ${response.statusCode}');
    }
  }
}
