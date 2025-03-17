class UserListModel {
  final String name;
  final String? email;
  final String phone;
  final String role;
  final String created_at;
  final String? updated_at;

  UserListModel({required this.name, this.email, required this.phone, required this.role, required this.created_at, this.updated_at});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'created_at': created_at,
      'updated_at': updated_at
    };
  }
}