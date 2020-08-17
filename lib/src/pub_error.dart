/// Error related to `pub_api` internally.
class PubError implements Exception {
  /// Error message.
  String cause;

  /// Error related to `pub_api` internally.
  PubError(this.cause);

  @override
  String toString() {
    return '$PubError("$cause")';
  }
}
