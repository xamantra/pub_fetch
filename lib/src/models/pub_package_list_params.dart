import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../index.dart';

/// Package listing parameters primarily search.
class PubPackageListParams extends Equatable {
  /// Package type. Either `Dart` or `Flutter` or any.
  final PackageType packageType;

  /// Flutter package compatibility types.
  ///
  /// `android`, `ios`, and `web`.
  final List<FlutterPlatform> platforms;

  /// Dart package compatibility types.
  ///
  /// `native`, and `js`.
  final List<DartRuntime> dartRuntimes;

  /// Available types or sorting packages in `pub.dev`.
  final PackageSort sortBy;

  /// Package listing parameters primarily search.
  PubPackageListParams({
    @required this.packageType,
    @required this.platforms,
    @required this.dartRuntimes,
    @required this.sortBy,
  });

  /// Convert this data into JSON.
  Map<String, dynamic> toJson() {
    return {
      'packageType': packageTypeToInt(packageType),
      'platforms': platforms
          ?.map(
            (x) => FlutterPlatform.values.indexOf(x),
          )
          ?.toList(),
      'dartRuntimes': dartRuntimes
          ?.map(
            (x) => DartRuntime.values.indexOf(x),
          )
          ?.toList(),
      'sortBy': packageSortToInt(sortBy),
    };
  }

  /// Parse JSON data and convert to type `PubPackageListParams`.
  factory PubPackageListParams.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return PubPackageListParams(
      packageType: intToPackageType(map['packageType']),
      platforms: List<FlutterPlatform>.from(map['platforms']?.map(
        (x) => FlutterPlatform.values[x],
      )),
      dartRuntimes: List<DartRuntime>.from(map['dartRuntimes']?.map(
        (x) => DartRuntime.values[x],
      )),
      sortBy: intToPackageSort(map['sortBy']),
    );
  }

  /// Convert this data into raw string JSON.
  ///
  /// Useful for saving in local storage in front-end apps.
  String toRawJson() => json.encode(toJson());

  /// Parse raw string JSON data and convert to type `PubPackageListParams`.
  ///
  /// Useful for retrieving saved data from local storage
  /// in front-end apps.
  factory PubPackageListParams.fromRawJson(String source) {
    return PubPackageListParams.fromJson(json.decode(source));
  }

  @override
  String toString() {
    return 'PubPackageListParams(packageType: $packageType, '
        'platforms: $platforms, dartRuntimes: $dartRuntimes, sortBy: $sortBy)';
  }

  @override
  List<Object> get props => [
        packageType,
        platforms,
        dartRuntimes,
        sortBy,
      ];
}
