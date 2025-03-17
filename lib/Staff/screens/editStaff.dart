import 'package:flutter/material.dart';
import 'package:track_my_staff/Staff/widgets/editStaffForm.dart';
import 'package:track_my_staff/screens/login.dart';
import 'package:track_my_staff/theme.dart';
import 'package:track_my_staff/widgets/primaryButton.dart';
import 'package:track_my_staff/widgets/signupForm.dart';

class Editstaff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Edit Staff',
                style: titleText,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: kDefaultPadding,
              child: EditStaffForm(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(buttonText: 'Edit'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
