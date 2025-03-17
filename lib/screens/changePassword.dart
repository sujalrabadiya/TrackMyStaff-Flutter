import 'package:flutter/material.dart';
import 'package:track_my_staff/screens/login.dart';
import 'package:track_my_staff/theme.dart';
import 'package:track_my_staff/widgets/changePasswordForm.dart';
import 'package:track_my_staff/widgets/primaryButton.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Change Password',
              style: titleText,
            ),
            SizedBox(
              height: 10,
            ),
            ChangePasswordForm(),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInScreen(),
                      ));
                },
                child: PrimaryButton(buttonText: 'Change Password')),
          ],
        ),
      ),
    );
  }
}
