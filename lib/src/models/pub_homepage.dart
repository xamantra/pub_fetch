import 'package:meta/meta.dart';

import '../index.dart';

/// `pub.dev` homepage data.
///
/// The homepage contains:
/// - 4 random flutter favorite packages.
/// - 6 random most popular packages (dart or flutter).
/// - 6 random top flutter packages.
/// - 6 random top dart packages.
class PubHomepage {
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
}
