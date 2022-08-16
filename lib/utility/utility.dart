import 'dart:async' show Future;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Utility {
  Utility._();

  static final shared = Utility._();

  image(String path, {BoxFit? fit}) {
    bool isMatch = RegExp(r'^(https://|http://)').hasMatch(path);

    if (!isMatch) {
      return assetImage(path);
    }

    return webImage(path);
  }

  Image assetImage(String name, {BoxFit? fit}) {
    return Image.asset(
      name,
      fit: fit,
    );
  }

  Image webImage(String src, {BoxFit? fit}) {
    return Image.network(
      src,
      fit: fit,
    );
  }

  Future<String> readFile({required String assetsPath}) async {
    final response = await rootBundle.loadString(assetsPath);
    return response;
  }

  Future<dynamic> readJSON({required String assetsPath}) async {
    final response = await readFile(assetsPath: assetsPath);
    return const JsonDecoder().convert(response);
  }

  /// [記錄滾到哪一頁的Key](https://protocoderspoint.com/preserve-scroll-position-of-listview-flutter-pagestoragekey/)
  /// [Flutter進階篇（6）-- PageStorageKey、PageStorageBucket和PageStorage使用詳解 - 騰訊雲開發者社區-騰訊雲](https://cloud.tencent.com/developer/article/1461395)
  PageStorageKey<String> pageStorageKey(Widget widget) {
    return PageStorageKey('${widget.runtimeType}');
  }
}
