import 'dart:async' show Future;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_first_app/utility/widget/progressIndicator.dart';

class Utility {
  Utility._();

  static final shared = Utility._();

  bool isShow = false;

  Image assetImage(String name) {
    return Image.asset(name);
  }

  Image webImage(String src) {
    return Image.network(src);
  }

  Future<String> readFile({required String assetsPath}) async {
    final response = await rootBundle.loadString(assetsPath);
    return response;
  }

  Future<dynamic> readJSON({required String assetsPath}) async {
    final response = await readFile(assetsPath: assetsPath);
    return const JsonDecoder().convert(response);
  }
}
