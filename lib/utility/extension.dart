extension WWList on List {
  Object? safeElementAt(int index) {
    if (index < 0) {
      return null;
    }

    if ((index + 1) > length) {
      return null;
    }

    return elementAt(index);
  }
}
