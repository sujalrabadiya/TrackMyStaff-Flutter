import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_my_staff/Admin/screens/layoutAdmin.dart';
import 'package:track_my_staff/Staff/screens/layoutStaff.dart';
import 'package:track_my_staff/screens/login.dart';
import 'package:track_my_staff/theme.dart';

String? finalPhone;
String? finalEmail;
String? finalImgUrl;
String? finalRole;
int? finalUId;
String? finalUName;
int? finalCId;
String? finalCName;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    getValidationData().whenComplete(() {
      Timer(Duration(seconds: 3), () => Get.offAll(finalPhone == null ? LogInScreen() : finalRole == 'Staff' ? StaffLayout() : AdminLayout()));
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedPhone = sharedPreferences.getString('phone');
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedImgUrl = sharedPreferences.getString('img_url');
    var obtainedRole = sharedPreferences.getString('role');
    var obtainedUID = sharedPreferences.getInt('id');
    var obtainedUName = sharedPreferences.getString('name');
    var obtainedCId = sharedPreferences.getInt('company_id');
    var obtainedCName = sharedPreferences.getString('company_name');
    setState(() {
      finalPhone = obtainedPhone;
      finalEmail = obtainedEmail;
      finalImgUrl = obtainedImgUrl;
      finalRole = obtainedRole;
      finalCId = obtainedCId;
      finalCName = obtainedCName;
      finalUId = obtainedUID;
      finalUName = obtainedUName;
      layoutIndex = obtainedRole == 'Staff' ? 1 : 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 247, 248, 240),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("TrackMyStaff"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: Center(
                child: Text("~Apps by S",style: TextStyle(color: Color.fromARGB(100, 89, 36, 40)),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
