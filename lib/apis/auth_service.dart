import 'dart:convert';

import 'package:student_smile/feautre/feautre.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    const url = '$BASE_URL/auth/login';
    final body = jsonEncode({'email': email, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body)['data'];
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Faild Login');
    }
  }

  static Future<UserModel> createAccount(
      String email, String password, String unNumber) async {
    const url = '$BASE_URL/auth/register';
    final body = jsonEncode(
        {'email': email, 'password': password, 'university_number': unNumber});
    final headers = {'Content-Type': 'application/json'};
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body)['data'];
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Faild Register');
    }
  }
}
