import 'package:flutter/material.dart';

class SampleDefaultTabModel {
  TabModel tabModel;
  Widget body;

  SampleDefaultTabModel({required this.tabModel, required this.body});
}

class TabModel {
  String title;
  Color? color;
  Color? backgroundColor;

  TabModel({
    required this.title,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
  });
}
