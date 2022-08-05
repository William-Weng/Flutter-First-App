import 'package:flutter/material.dart';

class BottomNavigationBarItemModel {
  BottomNavigationBarItem item;
  Widget body;

  BottomNavigationBarItemModel({required this.item, required this.body});
}

class Sample {
  String title;
  String content;
  String imageUrl;

  Sample({required this.title, required this.content, required this.imageUrl});

  factory Sample.fromJSON(Map<String, dynamic> json) {
    final record = Sample(
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
    );

    return record;
  }

  // https://zhuanlan.zhihu.com/p/133924017

  static List<Sample> fromList(List<dynamic> jsonList) {
    List<Sample> list = [];

    for (var json in jsonList) {
      final sample = Sample.fromJSON(json);
      list.add(sample);
    }

    return list;
  }
}
