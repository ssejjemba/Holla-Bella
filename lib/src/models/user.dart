// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? key;
  String? email;
  String? password;
  String? displayName;
  String? profilePic;

  UserModel({this.email, this.password, this.displayName, this.profilePic});

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    email = map['email'];
    password = map['password'];
    displayName = map['displayName'];
    profilePic = map['profilePic'];
    key = map['key'];
  }

  toJson() {
    return {
      'key': key,
      "password": password,
      "email": email,
      'displayName': displayName,
      'profilePic': profilePic,
    };
  }

  @override
  List<Object?> get props => [
        key,
        email,
        password,
        displayName,
        profilePic,
      ];
}
