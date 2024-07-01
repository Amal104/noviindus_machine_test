// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    bool status;
    String message;
    String token;
    bool isSuperuser;
    UserDetails userDetails;

    User({
        required this.status,
        required this.message,
        required this.token,
        required this.isSuperuser,
        required this.userDetails,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        isSuperuser: json["is_superuser"],
        userDetails: UserDetails.fromJson(json["user_details"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "is_superuser": isSuperuser,
        "user_details": userDetails.toJson(),
    };
}

class UserDetails {
    int id;
    dynamic lastLogin;
    String name;
    String phone;
    String address;
    String mail;
    String username;
    String password;
    String passwordText;
    int admin;
    bool isAdmin;
    bool isActive;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic branch;

    UserDetails({
        required this.id,
        required this.lastLogin,
        required this.name,
        required this.phone,
        required this.address,
        required this.mail,
        required this.username,
        required this.password,
        required this.passwordText,
        required this.admin,
        required this.isAdmin,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.branch,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        lastLogin: json["last_login"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        mail: json["mail"],
        username: json["username"],
        password: json["password"],
        passwordText: json["password_text"],
        admin: json["admin"],
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        branch: json["branch"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "name": name,
        "phone": phone,
        "address": address,
        "mail": mail,
        "username": username,
        "password": password,
        "password_text": passwordText,
        "admin": admin,
        "is_admin": isAdmin,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "branch": branch,
    };
}
