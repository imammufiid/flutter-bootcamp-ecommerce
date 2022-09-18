extension DoubleParsing on double? {
  double orNol() {
    if (this == null) {
      return 0.0;
    } else {
      return this!;
    }
  }
}