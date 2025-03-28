import 'package:flutter/material.dart';
import 'package:track_my_staff/Admin/screens/layoutAdmin.dart';
import 'package:track_my_staff/screens/login.dart';
import 'package:track_my_staff/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  PrimaryButton({required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
      child: TextButton(
          onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInScreen(),
                ),
              ),
          child: Text(
            buttonText,
            style: textButton.copyWith(color: kWhiteColor),
          )),
    );
  }
}
