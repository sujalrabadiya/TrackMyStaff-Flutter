import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:track_my_staff/Admin/screens/homeAdmin.dart';
import 'package:track_my_staff/Admin/screens/locationAdmin.dart';
import 'package:track_my_staff/Admin/screens/profileAdmin.dart';
import 'package:track_my_staff/screens/about.dart';
import 'package:track_my_staff/screens/chatPage.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/theme.dart';

class AdminLayout extends StatefulWidget {
  AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  List<Widget> ls = [AdminProfile(),AdminHome(),LocationAdmin(),ChatPage(),About()];
  List<String> lsTitle = ["Profile", finalCName!, finalCName!, finalCName!, "About"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(lsTitle[layoutIndex],style: appbarText,),
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
            Icons.home_outlined,
            size: 33,
            color: kBackgroundColor,
          ),
          Icon(
            Icons.location_on_outlined,
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
