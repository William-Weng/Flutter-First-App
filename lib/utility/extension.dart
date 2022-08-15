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

extension WWTabController on TabController {
  isScrolledIndex() {
    final index = this.index;
    final scrollOffset = animation?.value;

    return (scrollOffset != index.toDouble()) ? false : true;
  }
}
