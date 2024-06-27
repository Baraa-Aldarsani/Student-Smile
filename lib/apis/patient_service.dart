import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';
import 'package:http/http.dart' as http;

class PatientSevice {
  static Future<List<PatientModel>> getAllPatients() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/studentPatientNow'),
        headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> nestedData = json.decode(response.body)['data'];
      List<dynamic> allPatients = [];
      for (var sublist in nestedData) {
        allPatients.addAll(sublist);
      }
      return allPatients
          .map<PatientModel>((jsonData) => PatientModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch patients');
    }
  }

  static Future<List<DailyAppointmentModel>> getPatientSession(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/studentPatientSessions?patient_id=$id'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data']['sessions'];
      return data
          .map<DailyAppointmentModel>(
              (jsonData) => DailyAppointmentModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch patient Session');
    }
  }

  static Future<List<UserModel>> getAllStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/allStudentView'),
        headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<UserModel>(
              (jsonData) => UserModel.fromJson(jsonData, getProfile: true))
          .toList();
    } else {
      throw Exception('Failed to fetch all Student');
    }
  }
}
