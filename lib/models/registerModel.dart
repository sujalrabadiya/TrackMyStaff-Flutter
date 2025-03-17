class RegisterModel {
  final String cName;
  final String email;
  final String phone;
  final String uName;
  final String password;
  final String role;

  RegisterModel({required this.phone, required this.password, required this.role, required this.email, required this.cName, required this.uName,});

  Map<String, dynamic> toJson() {
    return {
      "cName": cName,
      "email": email,
      "phone": phone,
      "uName": uName,
      "password": password,
      "role": role
    };
  }
}
