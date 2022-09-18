extension IntParsing on int? {
  int orNol() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}