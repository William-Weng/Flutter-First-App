import 'package:flutter/material.dart';

class Utility {
  Utility._();

  static final shared = Utility._();

  Image assetImage(String name) {
    return Image.asset(name);
  }

  Image webImage(String src) {
    return Image.network(src);
  }
}
