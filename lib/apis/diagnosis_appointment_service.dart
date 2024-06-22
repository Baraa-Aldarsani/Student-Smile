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
        headers: {'Authorization': 'Bearer $token'});
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
}
