import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/chat_service.dart';
import 'package:track_my_staff/theme.dart';

void main() {
  ChatService.getConversation(13, 17);
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