import 'dart:async' show Future;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Utility {
  Utility._();

  static final shared = Utility._();

  image(String path, {required String errorImage, BoxFit? fit}) {
    bool isMatch = RegExp(r'^(https://|http://)').hasMatch(path);

    if (!isMatch) {
      return assetImage(path, errorImage: errorImage);
    }

    return webImage(path, errorImage: errorImage);
  }

  Image assetImage(String name, {required String errorImage, BoxFit? fit}) {
    return Image.asset(
      name,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(errorImage);
      },
    );
  }

  // https://sa123.cc/t8u0ukszw4jd1n66tjtm.html
  Image webImage(String src, {required String errorImage, BoxFit? fit}) {
    return Image.network(
      src,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(errorImage);
      },
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
