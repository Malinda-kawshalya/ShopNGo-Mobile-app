class UserModel {
  final String? name;
  final String? email;
  final String? photoUrl;

  UserModel({this.name, this.email, this.photoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}
