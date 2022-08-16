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
