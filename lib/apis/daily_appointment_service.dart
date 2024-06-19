import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:student_smile/feautre/feautre.dart';

class DailyAppointmentService {
  static Future<List<DailyAppointmentModel>> getInfoDepartment(
      String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
        Uri.parse('$BASE_URL/profile/studentAppointments?history=$date'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<DailyAppointmentModel>(
              (jsonData) => DailyAppointmentModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch daily appointment');
    }
  }

  static Future<void> addSession(
      int clinicID, int referralsID, String date, String time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.post(
      Uri.parse('$BASE_URL/profile/addSession'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "clinic_id": clinicID.toString(),
        "referrals_id": referralsID.toString(),
        "history": date,
        "timeSession": time,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("success add session");
    } else {
      throw Exception('Failed to add session');
    }
  }

  static Future<void> updateSession(
      int sessionID, String status, String note) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.put(
      Uri.parse('$BASE_URL/profile/updateSession'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "session_id": sessionID.toString(),
        "status_of_session": status,
        "student_notes": note,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success update session");
    } else {
      throw Exception('Failed to update session');
    }
  }

  static Future<void> addListTool(DailyAppointmentModel dailyAppoint,
      List<LaborarotyPicesModel> submitTools) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final request = http.MultipartRequest(
        'POST', Uri.parse('$BASE_URL/profile/toolsRequired'));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['session_id'] = dailyAppoint.sessionModel.id.toString();
    // request.fields['patient_id'] = dailyAppoint.sessionModel.id.toString();
    request.fields['patient_id'] = '1';
    int i = 0;
    for (var item in submitTools) {
      request.fields['tools[$i][laboratoryTools_id]'] = item.id.toString();
      i++;
    }
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("success add List Tools");
    } else {
      throw Exception('Failed to add List Tools');
    }
  }
}