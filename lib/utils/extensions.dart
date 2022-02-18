extension Let on dynamic {
  R let<R>(R Function(dynamic) mapper) {
    return mapper(this);
  }
}
