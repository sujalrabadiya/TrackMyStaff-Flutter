import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_my_staff/Admin/screens/layoutAdmin.dart';
import 'package:track_my_staff/models/registerModel.dart';
import 'package:track_my_staff/services/auth_service.dart';
import 'package:track_my_staff/theme.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _cNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _uNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  void registerCompany() async {
    String cName = _cNameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String uName = _uNameController.text.trim();
    String password = _passwordController.text.trim();

    if (cName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        uName.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final registerData = RegisterModel(
      cName: cName,
      email: email,
      phone: phone,
      uName: uName,
      password: password,
      role: "Admin",
    );

    var response = await AuthService.register(registerData);

    if (response != null) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('phone', phone);
      Get.offAll(()=>AdminLayout());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInputForm('Company Name', false, _cNameController),
        buildInputForm('Email', false, _emailController),
        buildInputForm('Phone', false, _phoneController),
        buildInputForm('Username', false, _uNameController),
        buildInputForm('Password', true, _passwordController),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
          child: TextButton(
              onPressed: registerCompany,
              child: Text(
                "Register",
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
          labelStyle: TextStyle(color: kTextFieldColor),
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
              : null,
        ),
      ),
    );
  }
}
