import 'dart:convert';

class FilterModel {
  String? type;
  String? title;
  bool? isSelected;

  FilterModel({
    this.type,
    this.title,
    this.isSelected,
  });

  factory FilterModel.fromRawJson(String str) => FilterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    type: json["type"],
    title: json["title"],
    isSelected: json["isSelected"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "isSelected": isSelected,
  };
}
