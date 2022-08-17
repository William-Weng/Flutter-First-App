import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

extension WWList<T> on List<T> {
  T? safeElementAt(int safeIndex) {
    if (safeIndex < 0) {
      return null;
    }

    if ((safeIndex + 1) > length) {
      return null;
    }

    return elementAt(safeIndex);
  }
}

extension WWString on String {
  // https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter
  Color hexColor() {
    var code = toString().toUpperCase().replaceAll("#", "");

    if (code.length == 6) {
      code += "FF";
    }

    return Color(int.parse(code, radix: 16));
  }
}

extension WWTabController on TabController {
  isScrolledIndex() {
    final index = this.index;
    final scrollOffset = animation?.value;

    return (scrollOffset != index.toDouble()) ? false : true;
  }

  AnimationStatus? scrollDirection() {
    final animation = this.animation;

    if (animation == null) {
      return null;
    }

    final indexValue = animation.value;

    if (indexValue > index.toDouble()) {
      return AnimationStatus.forward;
    }

    if (indexValue < index.toDouble()) {
      return AnimationStatus.reverse;
    }

    return null;
  }
}

extension WWImageProvider on ImageProvider<Object> {
  void jj() {
    resolve(const ImageConfiguration()).addListener(ImageStreamListener(
      (image, synchronousCall) {
        log('image => $image / synchronousCall => $synchronousCall');
      },
    ));
  }
}

// https://wizardforcel.gitbooks.io/gsyflutterbook/content/Flutter-10.html
extension WWImage on Image {
  void defaultImage() {
    final Completer<void> completer = Completer<void>();

    image.resolve(const ImageConfiguration()).addListener(ImageStreamListener(
      (image, synchronousCall) {
        log('image => $image / synchronousCall => $synchronousCall');
        completer.complete();
      },
    ));
  }
}
