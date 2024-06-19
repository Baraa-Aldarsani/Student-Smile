import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';
import 'package:http/http.dart' as http;

class DepartmentService {
 static Future<List<DepartmentModel>> getInfoDepartment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(Uri.parse('$BASE_URL/profile/sectionsView'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<DepartmentModel>(
              (jsonData) => DepartmentModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch info department');
    }
  }
}
