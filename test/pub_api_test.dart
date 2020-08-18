import 'package:pub_api/src/index.dart';
import 'package:test/test.dart';

import 'queries.dart';

void main() {
  test('internals.groupFlutterPlatforms(...)', () {
    var result1 = groupFlutterPlatforms([
      FlutterPlatform.android,
      FlutterPlatform.ios,
    ]);
    expect(result1, '&platform=android+ios');

    var result2 = groupFlutterPlatforms([
      FlutterPlatform.android,
      FlutterPlatform.ios,
      FlutterPlatform.web,
    ]);
    expect(result2, '&platform=android+ios+web');

    var result3 = groupFlutterPlatforms([
      FlutterPlatform.ios,
      FlutterPlatform.web,
      FlutterPlatform.ios,
    ]);
    expect(result3, '&platform=ios+web');
  });

  test('internals.groupDartRuntimes(...)', () {
    var result1 = groupDartRuntimes([
      DartRuntime.native,
      DartRuntime.js,
    ]);
    expect(result1, '&runtime=native+js');

    var result2 = groupDartRuntimes([DartRuntime.native]);
    expect(result2, '&runtime=native');

    var result3 = groupDartRuntimes([
      DartRuntime.js,
      DartRuntime.native,
      DartRuntime.native,
    ]);
    expect(result3, '&runtime=js+native');
  });

  // Repeat test 10 times
  for (var i = 0; i < 10; i++) {
    test('[${i + 1}] api.homepage()', () async {
      var homepage = await PubAPI().homepage();
      expect(homepage != null, true);
      expect(homepage, isA<PubHomepage>());
      expect(validHomepage(homepage), true);
      for (var flutterFavorite in homepage.flutterFavorites) {
        expect(validHomepagePackage(flutterFavorite), true);
      }
      for (var mostPopular in homepage.mostPopularPackages) {
        expect(validHomepagePackage(mostPopular), true);
      }
      for (var topFlutter in homepage.topFlutterPackages) {
        expect(validHomepagePackage(topFlutter), true);
      }
      for (var topDart in homepage.topDartPackages) {
        expect(validHomepagePackage(topDart), true);
      }
    });
  }

  // Repeat test for all query available
  var shuffledQueries = queries..shuffle();
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.search("$query")', () async {
      print('Testing with query "$query"');
      var result = await PubAPI().search(query);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = validPackage(package);
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    });
  }

  // Repeat test for all query available
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.searchFlutter("$query")', () async {
      print('Testing with query "$query"');
      var result = await PubAPI().searchFlutter(query);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = package.flutterSupport;
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    });
  }

  var platforms = [
    FlutterPlatform.android,
    FlutterPlatform.ios,
    FlutterPlatform.web,
  ];
  // Repeat test for all query available
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.searchFlutter("$query", [platforms])', () async {
      print('Testing platform search: "${groupFlutterPlatforms(platforms)}"');
      var result = await PubAPI().searchFlutter(query, platforms: platforms);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var androidSupport = package.flutterAndroidSupport;
        var iOSSupport = package.flutterIOSSupport;
        var webSupport = package.flutterWebSupport;
        var fullySupported = androidSupport && iOSSupport && webSupport;
        if (!fullySupported) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(fullySupported, true);
      }
    });
  }

  // Repeat test for all query available
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.searchDart("$query")', () async {
      print('Testing with query "$query"');
      var result = await PubAPI().searchDart(query);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = package.dartSupport;
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    });
  }

  var runtimes = [
    DartRuntime.native,
    DartRuntime.js,
  ];
  // Repeat test for all query available
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.searchDart("$query", [runtimes])', () async {
      print('Testing runtime search: "${groupDartRuntimes(runtimes)}"');
      var result = await PubAPI().searchDart(query, dartRuntimes: runtimes);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var nativeSupport = package.dartNativeSupport;
        var jsSupport = package.dartJSSupport;
        var fullySupported = nativeSupport && jsSupport;
        if (!fullySupported) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(fullySupported, true);
      }
    });
  }
}
