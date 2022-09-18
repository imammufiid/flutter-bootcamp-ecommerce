extension ListParsing<E> on List<E>? {
  List<E> orEmpty() {
    if (this == null) {
      return [];
    } else {
      return this!;
    }
  }
}
