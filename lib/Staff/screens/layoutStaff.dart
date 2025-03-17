import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:track_my_staff/Staff/screens/profileStaff.dart';
import 'package:track_my_staff/screens/about.dart';
import 'package:track_my_staff/screens/chatPage.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/location_service.dart';
import 'package:track_my_staff/theme.dart';

class StaffLayout extends StatefulWidget {
  StaffLayout({super.key});

  @override
  State<StaffLayout> createState() => _StaffLayoutState();
}

class _StaffLayoutState extends State<StaffLayout> {
  List<Widget> ls = [StaffProfile(), ChatPage(), About()];
  List<String> lsTitle = ["Profile", finalCName!, "About"];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = LocationService.startLocationUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          lsTitle[layoutIndex],
          style: appbarText,
        ),
      ),
      body: ls[layoutIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.person_outline,
            size: 33,
            color: kBackgroundColor,
          ),
          Icon(
            Icons.message_outlined,
            size: 30,
            color: kBackgroundColor,
          ),
          Icon(
            Icons.info_outline,
            size: 33,
            color: kBackgroundColor,
          ),
        ],
        color: kPrimaryColor,
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: kBackgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            layoutIndex = index;
          });
        },
        index: layoutIndex,
        letIndexChange: (index) => true,
      ),
    );
  }
}
