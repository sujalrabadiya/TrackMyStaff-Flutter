class CompanyModel {
  final String id;
  final String name;
  final String phone;
  final String? email;

  CompanyModel({
    required this.id,
    required this.phone,
    required this.name,
    this.email
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json["id"],
      phone: json["phone"],
      name: json["name"],
      email: json["email"]
    );
  }

  Map<String, dynamic> toJson () {
    return {
      "id": id,
      "phone": phone,
      "name": name,
      "email": email
    };
  }
}
