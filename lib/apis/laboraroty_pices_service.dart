// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_smile/feautre/feautre.dart';
import 'package:http/http.dart' as http;

class LaborarotyPicesService {
  static Future<List<LaborarotyPicesModel>> getRequiredMaterial() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final response = await http.get(Uri.parse('$BASE_URL/profile/getTools'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<LaborarotyPicesModel>(
              (jsonData) => LaborarotyPicesModel.fromJson(jsonData))
          .toList();
    } else {
      throw Exception('Failed to fetch Laboraroty Pices');
    }
  }

  static Future<void> addEquipment(String name, File imageFile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final request =
        http.MultipartRequest('POST', Uri.parse('$BASE_URL/profile/addTools'));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['details_of_tool'] = name;

    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var length = await imageFile.length();
    var multipartFile = http.MultipartFile('image_tool', stream, length,
        filename: 'image_tool$length.png');

    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("success add Equipment");
    } else {
      throw Exception('Failed to add Equipment');
    }
  }
}
