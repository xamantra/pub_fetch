import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../index.dart';

/// `pub.dev` homepage data.
///
/// The homepage contains:
/// - 4 random flutter favorite packages.
/// - 6 random most popular packages (dart or flutter).
/// - 6 random top flutter packages.
/// - 6 random top dart packages.
@immutable
class PubHomepage extends Equatable {
  /// 4 random flutter favorite packages.
  ///
  /// Packages that demonstrate the highest levels of quality,
  /// selected by the Flutter Ecosystem Committee
  final List<PubPackage> flutterFavorites;

  /// 6 random most popular packages (dart or flutter).
  ///
  /// The most downloaded packages over the past 60 days
  final List<PubPackage> mostPopularPackages;

  /// 6 random top flutter packages.
  ///
  /// Top packages that extend Flutter with new features
  final List<PubPackage> topFlutterPackages;

  /// 6 random top dart packages.
  ///
  /// Top packages for any Dart-based app or program
  final List<PubPackage> topDartPackages;

  /// `pub.dev` homepage data.
  ///
  /// The homepage contains:
  /// - 4 random flutter favorite packages.
  /// - 6 random most popular packages (dart or flutter).
  /// - 6 random top flutter packages.
  /// - 6 random top dart packages.
  PubHomepage({
    @required this.flutterFavorites,
    @required this.mostPopularPackages,
    @required this.topFlutterPackages,
    @required this.topDartPackages,
  });

  /// Convert this data into JSON.
  Map<String, dynamic> toJson() {
    return {
      'flutterFavorites': flutterFavorites?.map((x) => x?.toJson())?.toList(),
      // ignore: lines_longer_than_80_chars
      'mostPopularPackages': mostPopularPackages?.map((x) => x?.toJson())?.toList(),
      // ignore: lines_longer_than_80_chars
      'topFlutterPackages': topFlutterPackages?.map((x) => x?.toJson())?.toList(),
      'topDartPackages': topDartPackages?.map((x) => x?.toJson())?.toList(),
    };
  }

  /// Parse JSON data and convert to type `PubHomepage`.
  factory PubHomepage.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return PubHomepage(
      flutterFavorites: List<PubPackage>.from(
        map['flutterFavorites']?.map((x) => PubPackage.fromJson(x)),
      ),
      mostPopularPackages: List<PubPackage>.from(
        map['mostPopularPackages']?.map((x) => PubPackage.fromJson(x)),
      ),
      topFlutterPackages: List<PubPackage>.from(
        map['topFlutterPackages']?.map((x) => PubPackage.fromJson(x)),
      ),
      topDartPackages: List<PubPackage>.from(
        map['topDartPackages']?.map((x) => PubPackage.fromJson(x)),
      ),
    );
  }

  /// Convert this data into raw string JSON.
  ///
  /// Useful for saving in local storage in front-end apps.
  String toRawJson() => json.encode(toJson());

  /// Parse raw string JSON data and convert to type `PubHomepage`.
  ///
  /// Useful for retrieving saved data from local storage
  /// in front-end apps.
  factory PubHomepage.fromRawJson(String source) => PubHomepage.fromJson(
        json.decode(source),
      );

  @override
  String toString() {
    return 'PubHomepage(flutterFavorites: $flutterFavorites, '
        'mostPopularPackages: $mostPopularPackages, '
        'topFlutterPackages: $topFlutterPackages, '
        'topDartPackages: $topDartPackages)';
  }

  @override
  List<Object> get props => [
        flutterFavorites,
        mostPopularPackages,
        topFlutterPackages,
        topDartPackages,
      ];
}
