extension StringXNull on String? {
  bool get isNotNullEitherEmpty => this != null && this!.isNotEmpty;
}
