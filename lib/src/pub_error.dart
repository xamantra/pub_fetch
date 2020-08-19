/// Error related to `pub_fetch` internally.
class PubError implements Exception {
  /// Error message.
  String cause;

  /// Error related to `pub_fetch` internally.
  PubError(this.cause);

  @override
  String toString() {
    return '$PubError("$cause")';
  }
}
