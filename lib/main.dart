import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackMyStaff',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: ThemeData(fontFamily: 'Poppins', scaffoldBackgroundColor: kBackgroundColor, colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor)),
      home: SplashScreen(),
    );
  }
}