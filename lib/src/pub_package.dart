import 'package:meta/meta.dart';

/// Simple pub package data.
class PubPackage {
  /// The name of the package which is unique in `pub.dev`.
  final String name;

  /// The direct url of the package.
  final String url;

  /// Descriptio of the package.
  final String description;

  /// Publisher domain name.
  final String publisher;

  /// Simple pub package data.
  PubPackage({
    @required this.name,
    @required this.url,
    @required this.description,
    @required this.publisher,
  });

  /// Returns `true` if `publisher` is not null.
  bool get verified => publisher != null;
}
