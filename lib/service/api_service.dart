import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> fetchApiData() async {
    String api = 'https://raw.githubusercontent.com/bikashthapa01/myvideos-android-app/master/data.json';
    Uri uri = Uri.parse(api);
    Response response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Data did not fetched!");
      }
    } catch (e) {
      throw Exception("Error!");
    }
  }
}
