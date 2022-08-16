import 'dart:developer';

import 'package:flutter/material.dart';

import '/utility/extension.dart';

class ClothesModel {
  int cost;
  String title;
  String imageUrl;
  List<Color> colors;

  ClothesModel({
    required this.cost,
    required this.title,
    required this.imageUrl,
    required this.colors,
  });

  factory ClothesModel.fromJSON(Map<String, dynamic> json) {
    final hexColorList = json['colors'] as List<dynamic>;

    final colors = hexColorList.map((hexCode) {
      return hexCode.toString().hexColor();
    }).toList();

    final record = ClothesModel(
      cost: json['cost'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      colors: colors,
    );

    return record;
  }

  static List<ClothesModel> fromList(List<dynamic> jsonList) {
    List<ClothesModel> list = [];

    for (var json in jsonList) {
      final sample = ClothesModel.fromJSON(json);
      list.add(sample);
    }

    return list;
  }
}
