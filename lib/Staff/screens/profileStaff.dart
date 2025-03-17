import 'package:flutter/material.dart';
import 'package:track_my_staff/Staff/screens/editStaff.dart';
import 'package:track_my_staff/screens/changePassword.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/auth_service.dart';
import 'package:track_my_staff/theme.dart';

class StaffProfile extends StatelessWidget {
  const StaffProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: kGradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight))),
            ),
            Positioned(
              top: 90,
              bottom: -10,
              right: 30,
              left: 30,
              child: Card(
                elevation: 8,
                color: kBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(
                    top: 60,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            finalUName!,
                              style: TextStyle(
                                  fontSize: 18, color: kPrimaryColor)),
                        ),
                        Text(
                          finalRole!,
                          style: TextStyle(color: kSecondaryColor),
                        ),
                        const Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Divider(
                            thickness: 0.5,
                            color: kDarkGreyColor,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            finalEmail!,
                            style: listTileText,
                          ),
                          leading: Icon(
                            Icons.email_outlined,
                            size: 20,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            finalPhone!,
                            style: listTileText,
                          ),
                          leading: Icon(
                            Icons.phone_outlined,
                            size: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                DialogRoute(
                                  context: context,
                                  builder: (context) => ChangePasswordScreen(),
                                ));
                          },
                          child: ListTile(
                            title: Text(
                              "Change Password",
                              style: listTileText.copyWith(color: Colors.blue),
                            ),
                            leading: Icon(
                              Icons.password_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: AuthService.logout,
                          child: ListTile(
                            title: Text(
                              "Logout",
                              style: listTileText.copyWith(color: Colors.red),
                            ),
                            leading: Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    finalImgUrl!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height - 30)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
