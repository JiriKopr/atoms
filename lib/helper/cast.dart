/// In some cases just a simple if statement is not enough
/// for the Dart to recognize the cast to a new type, this helps
/// and shortens the cast to single line
T cast<T>(dynamic input) {
  if (input is T) return input;

  return null;
}
