import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';
import 'package:http/http.dart' as http;

class HomeService {
  static Future<List<PatientFromSectionModel>>
      getPatientFromDepartment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
      Uri.parse('$BASE_URL/profile/convertFromSection'),
      headers: {'X-Token': 'Bearer $token', 'Authorization': basicAuth},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<PatientFromSectionModel>(
              (jsonData) => PatientFromSectionModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch patient from section');
    }
  }

  static Future<List<PatientFromSectionModel>> getPatientFromSudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(
      Uri.parse('$BASE_URL/profile/convertFromStudent'),
      headers: {'X-Token': 'Bearer $token', 'Authorization': basicAuth},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<PatientFromSectionModel>(
              (jsonData) => PatientFromSectionModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch patient from studnet');
    }
  }

  static Future<void> acceptReffera(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http
        .put(Uri.parse("$BASE_URL/profile/acceptMyReferral"), headers: {
      'X-Token': 'Bearer $token',
      'Authorization': basicAuth
    }, body: {
      "referral_id": id.toString(),
    });
    print(id);
    print(response.statusCode);
    if (true) {
      print("Success accept refferal");
    } else {
      throw Exception('Failed to accept refferal');
    }
  }

  static Future<void> rejectReffera(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http
        .put(Uri.parse("$BASE_URL/profile/rejectMyReferral"), headers: {
      'X-Token': 'Bearer $token',
      'Authorization': basicAuth
    }, body: {
      "referral_id": id.toString(),
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success reject refferal");
    } else {
      throw Exception('Failed to reject refferal');
    }
  }
}
