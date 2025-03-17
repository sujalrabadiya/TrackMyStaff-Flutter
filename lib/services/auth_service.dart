import 'dart:convert';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_my_staff/models/loginModel.dart';
import 'package:track_my_staff/models/registerModel.dart';
import 'package:track_my_staff/screens/login.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/theme.dart';

class AuthService {
  // static const String baseUrl = "https://localhost:7162/api/Auth";
  static const String baseUrl = "http://192.168.169.194:7165/api/Auth";
  // static const String baseUrl = "http://localhost:5046/api/Auth";

  static Future<Map<String, dynamic>?> login(LoginModel cred) async {
    final Uri url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cred),
    );

    if (response.statusCode == 200) {
      var user = await jsonDecode(response.body);
       storeData(user);
      return user;
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> register(RegisterModel registerData) async {
    final Uri url = Uri.parse("$baseUrl");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(registerData),
    );

    if (response.statusCode == 200) {
      finalPhone = registerData.phone;
      var user = await login(LoginModel(phone: registerData.phone, password: registerData.password));
      return user;
    } else {
      return null;
    }
  }

  static void logout() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('phone');
    sharedPreferences.remove('id');
    sharedPreferences.remove('name');
    sharedPreferences.remove('email');
    sharedPreferences.remove('img_url');
    sharedPreferences.remove('role');
    sharedPreferences.remove('company_id');
    sharedPreferences.remove('company_name');
    Get.off(LogInScreen());
  }

  static void storeData(user) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('id', user["id"]);
    await sharedPreferences.setString('email', user["email"]);
    await sharedPreferences.setString('name', user["name"]);
    await sharedPreferences.setString('img_url', user["img_url"]);
    await sharedPreferences.setString('role', user["role"]);
    await sharedPreferences.setInt('company_id', user["company_id"]);
    await sharedPreferences.setString('company_name', user["company_name"]);
    finalEmail = user["email"];
    finalImgUrl = user["img_url"];
    finalRole = user["role"];
    finalCId = user["company_id"];
    finalCName = user["company_name"];
    finalUId = user["id"];
    finalUName = user["name"];
    layoutIndex = finalRole == 'Staff' ? 1 : 2;
  }
}
