class UserModel {
  final int id;
  final String? email;
  final String? password;
  final String name;
  final String phone;
  final String role;
  final String? imgUrl;
  final int? cId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({required this.id, this.email, this.password, required this.name, required this.phone, required this.role, this.imgUrl, this.cId, this.createdAt, this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Email": email,
      "Password": password,
      "Name": name,
      "Phone": phone,
      "Role": role,
      "ImgUrl": imgUrl,
      "CompanyId": cId,
      "CreatedAt": createdAt,
      "UpdatedAt": updatedAt
    };
  }
}
