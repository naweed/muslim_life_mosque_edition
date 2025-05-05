extension ListExtensions on Iterable? {
  bool isListEmpty() {
    if (this == null) return true;

    return this!.isEmpty;
  }
}
