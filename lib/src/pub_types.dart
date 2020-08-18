/// Package type. Either `Dart` or `Flutter` or any.
enum PackageType {
  /// Packages compatible with the `Dart` SDK.
  dart,

  /// Packages compatible with the `Flutter` SDK.
  flutter,

  /// Packages compatible with the any SDK.
  any,
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
