import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:track_my_staff/models/userModel.dart';

class AdminService {
  // static const String baseUrl = "https://localhost:7162/api";
  static const String baseUrl = "http://192.168.169.194:7165/api";
  // static const String baseUrl = "http://localhost:5046/api";

  static Future<List<Map<String, dynamic>>?> getAllUsers(companyId) async {
    final Uri url = Uri.parse('$baseUrl/User/CompanyId/$companyId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((e) => e as Map<String, dynamic>).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getUserById(userId) async {
    final Uri url = Uri.parse("$baseUrl/User/$userId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> deleteUserById(userId) async {
    final Uri url = Uri.parse("$baseUrl/User/$userId");

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> editUserById(UserModel user) async {
    final Uri url = Uri.parse("$baseUrl/User");

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> addUser(UserModel user) async {
    final Uri url = Uri.parse("$baseUrl/User");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
