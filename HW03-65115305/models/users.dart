import 'dart:convert';
import 'package:uuid/uuid.dart';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String? id;
  String? fullname;
  String? email;
  String? password;
  String? gender;

  Users({
    this.id,
    this.fullname,
    this.email,
    this.password,
    this.gender,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "gender": gender,
      };

  // Method to create a new user with a generated ID
  static Users createNew(String fullname, String email, String password, [String? gender]) {
    final Uuid uuid = Uuid();
    return Users(
      id: uuid.v4(), // Generate a new UUID
      fullname: fullname,
      email: email,
      password: password,
      gender: gender,
    );
  }
}
