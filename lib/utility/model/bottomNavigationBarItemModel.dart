import 'package:flutter/material.dart';

class BottomNavigationBarItemModel {
  BottomNavigationBarItem item;
  Widget body;

  BottomNavigationBarItemModel({required this.item, required this.body});
}

class UserSample {
  String name;
  String username;
  String imageUrl;

  UserSample(
      {required this.name, required this.username, required this.imageUrl});

  factory UserSample.fromJSON(Map<String, dynamic> json) {
    final record = UserSample(
      name: json['name'],
      username: json['username'],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhIhfq6znga9qC4mYUalta53bTa1UC_x1QNQ&usqp=CAU',
    );

    return record;
  }

  Sample toSample() {
    return Sample(title: username, content: name, imageUrl: imageUrl);
  }

  static List<Sample> fromListToSample(List<dynamic> jsonList) {
    List<Sample> list = [];

    for (var json in jsonList) {
      final sample = UserSample.fromJSON(json).toSample();
      list.add(sample);
    }

    return list;
  }
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
