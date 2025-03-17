import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_my_staff/Admin/screens/layoutAdmin.dart';
import 'package:track_my_staff/Staff/screens/layoutStaff.dart';
import 'package:track_my_staff/models/loginModel.dart';
import 'package:track_my_staff/screens/resetPassword.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/auth_service.dart';
import 'package:track_my_staff/theme.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isObscure = true;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter phone and password")),
      );
      return;
    }

    final cred = LoginModel(phone: phone, password: password);
    var user = await AuthService.login(cred);

    if (user != null) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('phone', phone);
      finalPhone = phone;
      if (user["role"] == 'Staff') {
        Get.off(() => StaffLayout());
      } else {
        Get.off(() => AdminLayout());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInputForm('Phone', false, _phoneController),
        buildInputForm('Password', true, _passwordController),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
              color: kZambeziColor,
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationThickness: 1,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
          child: TextButton(
              onPressed: loginUser,
              child: Text(
                "Login",
                style: textButton.copyWith(color: kWhiteColor),
              )),
        )
      ],
    );
  }

  Padding buildInputForm(
      String label, bool pass, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(Icons.visibility_off, color: kTextFieldColor)
                        : Icon(Icons.visibility, color: kPrimaryColor),
                  )
                : null),
      ),
    );
  }
}
