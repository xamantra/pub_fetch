import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Homepage featured package data.
@immutable
class PubPackage extends Equatable {
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

  /// Convert this data into JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'description': description,
      'publisher': publisher,
    };
  }

  /// Parse JSON data and convert to type `PubPackage`.
  factory PubPackage.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return PubPackage(
      name: map['name'],
      url: map['url'],
      description: map['description'],
      publisher: map['publisher'],
    );
  }

  /// Convert this data into raw string JSON.
  ///
  /// Useful for saving in local storage in front-end apps.
  String toRawJson() => json.encode(toJson());

  /// Parse raw string JSON data and convert to type `PubPackage`.
  ///
  /// Useful for retrieving saved data from local storage
  /// in front-end apps.
  factory PubPackage.fromRawJson(String source) => PubPackage.fromJson(
        json.decode(source),
      );

  /// Returns a human readable string representation of this `PubPackage`.
  @override
  String toString() {
    return 'PubPackage(name: $name, url: $url,'
        ' description: $description, publisher: ${publisher ?? "none"})';
  }

  @override
  List<Object> get props => [
        name,
        url,
        description,
        publisher,
      ];
}
