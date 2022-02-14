extension Let on Object {
  R let<R>(R Function(dynamic) mapper) {
    return mapper(this);
  }
}
