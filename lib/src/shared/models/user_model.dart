import 'dart:convert';

UserModel? globaUserModel;

class UserModel {
  final String displayName;
  final String email;
  final String token;
  final String photoUrl;

  UserModel({
    required this.displayName,
    required this.email,
    required this.token,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'token': token,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'],
      email: map['email'],
      token: map['token'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());
}
