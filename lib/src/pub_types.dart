/// Package type. Either `Dart` or `Flutter` or any.
enum PackageType {
  /// Packages compatible with the `Dart` SDK.
  dart,

  /// Packages compatible with the `Flutter` SDK.
  flutter,

  /// Packages compatible with the any SDK.
  any,
}

/// Convert a `PackageType` enum to `int` for serialization.
int packageTypeToInt(PackageType packageType) {
  if (packageType == null) return null;
  return PackageType.values.indexOf(packageType);
}

/// Convert an `int` to `PackageType` enum for serialization.
PackageType intToPackageType(int packageType) {
  if (packageType == null) return null;
  return PackageType.values[packageType];
}

/// Available types or sorting packages in `pub.dev`.
enum PackageSort {
  /// Default sorting.
  relevance,

  /// Top sort.
  overallScore,

  /// Packages that got *updated* recently will be shown first.
  recentlyUpdated,

  /// Packages that got *just uploaded* in the last 30 days.
  newestPackage,

  /// Sort by number of likes.
  mostLikes,

  /// Sort by highest pub points.
  mostPubPoints,

  /// Sort by number of usage.
  popularity,
}

/// Convert a `PackageSort` enum to `int` for serialization.
int packageSortToInt(PackageSort packageType) {
  if (packageType == null) return null;
  return PackageSort.values.indexOf(packageType);
}

/// Convert an `int` to `PackageSort` enum for serialization.
PackageSort intToPackageSort(int packageType) {
  if (packageType == null) return null;
  return PackageSort.values[packageType];
}

/// Flutter package compatibility types.
///
/// `android`, `ios`, and `web`.
enum FlutterPlatform {
  /// Packages compatible with Flutter on the `Android` platform
  android,

  /// Packages compatible with Flutter on the `iOS` platform
  ios,

  /// Packages compatible with Flutter on the `Web` platform
  web,
}

/// Dart package compatibility types.
///
/// `native`, and `js`.
enum DartRuntime {
  /// Packages compatible with Dart running on a native platform (`JIT`/`AOT`)
  native,

  /// Packages compatible with Dart compiled for the web
  js,
}

/// Format flutter platform enum into `pub.dev`'s `GET` search url parameter.
String groupFlutterPlatforms(List<FlutterPlatform> items) {
  if (items == null || items.isEmpty) return '';
  var platforms = items.toSet().toList();
  var group = '';
  for (var i = 0; i < platforms.length; i++) {
    var platform = platforms[i].toString().replaceAll('FlutterPlatform.', '');
    group += '$platform';
    if (i != (platforms.length - 1)) {
      group += '+';
    }
  }
  return '&platform=$group';
  // if (items is List<DartRuntime>) {
  //   var platforms = items.toSet().cast<DartRuntime>().toList();
  //   var group = '';
  //   for (var i = 0; i < platforms.length; i++) {
  //     var runtime = platforms[i].toString().replaceAll('DartRuntime.', '');
  //     group += '$runtime';
  //     if (i != (platforms.length - 1)) {
  //       group += '+';
  //     }
  //   }
  //   return '&runtime=$group';
  // }
  // return '';
}

/// Format dart runtime enum into `pub.dev`'s `GET` search url parameter.
String groupDartRuntimes(List<DartRuntime> items) {
  if (items == null || items.isEmpty) return '';
  var platforms = items.toSet().toList();
  var group = '';
  for (var i = 0; i < platforms.length; i++) {
    var runtime = platforms[i].toString().replaceAll('DartRuntime.', '');
    group += '$runtime';
    if (i != (platforms.length - 1)) {
      group += '+';
    }
  }
  return '&runtime=$group';
}

/// Format `PackageSort` enum value into get url parameter string.
String getSortParam(PackageSort sort) {
  if (sort != null) {
    switch (sort) {
      case PackageSort.relevance:
        return '';
      case PackageSort.overallScore:
        return '&sort=top';
      case PackageSort.recentlyUpdated:
        return '&sort=updated';
      case PackageSort.newestPackage:
        return '&sort=created';
      case PackageSort.mostLikes:
        return '&sort=like';
      case PackageSort.mostPubPoints:
        return '&sort=points';
      case PackageSort.popularity:
        return '&sort=popularity';
      default:
        return '';
    }
  }
  return '';
}
