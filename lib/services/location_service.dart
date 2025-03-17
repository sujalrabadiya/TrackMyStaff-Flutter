import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:track_my_staff/screens/splash.dart';

class LocationService {
  static const String baseUrl = "http://192.168.169.194:7165/api";
  // static const String baseUrl = "http://localhost:5046/api";

  static Future<void> sendLocation(int userId) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      await http.post(
        Uri.parse("$baseUrl/location/add"),
        body: jsonEncode({
          "userId": userId.toString(),
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
        }),
        headers: {"Content-Type": "application/json"},
      );

    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  static Timer startLocationUpdates() {
    return Timer.periodic(Duration(seconds: 5), (Timer t) => sendLocation(finalUId!));
  }

  static Future<List<Map<String, dynamic>>?> getLocations() async {
    final Uri url = Uri.parse("$baseUrl/Location/live/$finalCId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => e as Map<String, dynamic>).toList();
    } else {
      return [];
    }
  }
}