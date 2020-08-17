import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Data from package listing. This has more details than [PubHomepagePackage].
@immutable
class PubPackage extends Equatable {
  /// The name of the package which is unique in `pub.dev`.
  final String name;

  /// The direct url of the package.
  final String url;

  /// Description of the package.
  final String description;

  /// Publisher domain name.
  final String publisher;

  /// The latest version of this package.
  final String version;

  /// The date this package was updated or uploaded (if initial version).
  final String published;

  /// Number of likes.
  final int likes;

  /// Total pub points calculated from *conventions*, *documentation*,
  /// *platform support*, *dart anaylsis*, and *dependencies*.
  final int pubPoints;

  /// Measures the number of apps that depend
  /// on a package over the past 60 days.
  ///
  /// Unit: `percentage (%)`.
  final int popularity;

  /// Returns true if this package is marked as `Flutter Favorite`.
  final bool isFlutterFavorite;

  /// List of platforms supported by this package.
  ///
  /// Example:
  ///
  /// `DART`, `NATIVE`, `JS`.
  ///
  /// `FLUTTER`, `ANDROID`, `IOS`, `WEB`.
  final List<String> pubTags;

  /// Data from package listing.
  /// This has more details than [PubHomepagePackage].
  PubPackage({
    @required this.name,
    @required this.url,
    @required this.description,
    @required this.publisher,
    @required this.version,
    @required this.published,
    @required this.likes,
    @required this.pubPoints,
    @required this.popularity,
    @required this.isFlutterFavorite,
    @required this.pubTags,
  });

  /// Convert this data into JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'description': description,
      'publisher': publisher,
      'version': version,
      'published': published,
      'likes': likes,
      'pubPoints': pubPoints,
      'popularity': popularity,
      'isFlutterFavorite': isFlutterFavorite,
      'pubTags': pubTags,
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
      version: map['version'],
      published: map['published'],
      likes: map['likes'],
      pubPoints: map['pubPoints'],
      popularity: map['popularity'],
      isFlutterFavorite: map['isFlutterFavorite'],
      pubTags: List<String>.from(map['pubTags']?.map(
        (x) => x?.toString(),
      )),
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
  factory PubPackage.fromRawJson(String source) {
    return PubPackage.fromJson(json.decode(source));
  }

  /// Returns a human readable string representation of this `PubPackage`.
  @override
  String toString() {
    return 'PubPackage(name: $name, url: $url, '
        'description: $description, publisher: $publisher, '
        'version: $version, published: $published, likes: $likes, '
        'pubPoints: $pubPoints, popularity: $popularity, '
        'isFlutterFavorite: $isFlutterFavorite, '
        'pubTags: $pubTags)';
  }

  @override
  List<Object> get props => [
        name,
        url,
        description,
        publisher,
        version,
        published,
        likes,
        pubPoints,
        popularity,
        isFlutterFavorite,
        pubTags,
      ];
}
