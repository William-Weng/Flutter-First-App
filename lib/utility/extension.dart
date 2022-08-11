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
