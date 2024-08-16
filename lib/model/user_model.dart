import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class UserModel {
  String? username;
  int? age;
  XFile? pickedImage;

  UserModel({
    this.username,
    this.age,
    this.pickedImage
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    age: json["age"],
    pickedImage: json["pickedImage"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "age": age,
    "pickedImage": pickedImage
  };
}
