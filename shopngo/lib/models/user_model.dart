// lib/models/user_model.dart

enum UserRole { user, seller }

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? photoUrl;
  final UserRole role;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      role: UserRole.values.byName(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role.name,
    };
  }
}